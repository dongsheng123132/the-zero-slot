#!/usr/bin/env bash
# The Zero Slot —— 每日自动写一章并推送（GitHub Actions）
# 每章 = 一个语义事务，过门禁（数值账本：str+agi+int+vit+wis+stat_points = 30+(level-1)*5，
# 账本不平/等级回退/引用未知对象 一律拒稿）。失败不落盘，第二天重试同一章。
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

# 1) hermes 通道配置
mkdir -p /tmp/hermes-home
cat > /tmp/hermes-home/config.yaml <<EOF
model:
  base_url: ${HERMES_API_BASE}
  api_key: ${HERMES_API_KEY}
  default: ${HERMES_MODEL}
EOF
export HERMES_HOME=/tmp/hermes-home

# 2) 引擎（2origin 仓库，含 zs-run.mjs，单点维护）
ENGINE=/tmp/2origin
if [ ! -d "$ENGINE/.git" ]; then
  git clone --depth 1 https://github.com/dongsheng123132/2origin.git "$ENGINE"
fi

# 3) 下一章号
OUTLINE=world/narrative/chapters/outline.jsonl
if [ -f "$OUTLINE" ]; then
  LAST=$(node -e "const fs=require('fs');const l=fs.readFileSync('$OUTLINE','utf8').trim().split('\n').filter(Boolean).map(x=>JSON.parse(x).chapter);console.log(l.length?Math.max(...l):0)")
else
  LAST=0
fi
NEXT=$((LAST+1))
NN=$(printf '%02d' "$NEXT")
echo "== Next chapter: ch$NN =="

# 4) 可选 brief（共创者 PR briefs/chNN.md；没有则自由续写）
BRIEF_ARGS=()
if [ -f "briefs/ch$NN.md" ]; then
  BRIEF_ARGS=(--brief "$(cat "briefs/ch$NN.md")")
  echo "== Using brief: briefs/ch$NN.md =="
fi

# 5) 写章（数值账本门禁；违反即拒，世界状态不动）
node "$ENGINE/adapters/story/zs/zs-run.mjs" world "$NEXT" \
  --provider hermes --max-tokens 30000 --retries 3 "${BRIEF_ARGS[@]}"

# 6) 同步展示版 + 推送
cp world/narrative/chapters/ch$NN.txt chapters/ch$NN.txt
cp world/provenance/history.jsonl state/state.jsonl
git add world chapters state briefs
git -c user.name="dongsheng123132" -c user.email="hefangsheng@gmail.com" commit -q -m "ch$NN: daily auto chapter (GitHub Actions, gate passed)" || echo "nothing to commit"
git push -q origin master || git push -q origin main
echo "== ch$NN pushed =="
