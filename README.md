# The Zero Slot

> A LitRPG novel whose **numbers are machine-verified**.
> 2037. The Panel arrived — everyone on Earth got a game interface.
> Everyone except Kael, who has one extra slot on his panel: **Slot Zero**.
> It is blank. No identify spell can read it. And every time the System
> releases a version update, a single word appears in it.

- **Engine**: Origin IR (本象协议) — every chapter is a semantic transaction; world state is public.
- **Ledger rule**: str+agi+int+vit+wis+stat_points = 25 + (level-1)*5, machine-checked per chapter.
- **Status panel**: see `state/` or run `node adapters/story/cli.mjs state pkg.origin`.

## Chapters

| # | Title | Status |
|---|---|---|
| 01 | The Panel Arrives | ✅ 2026-08-06 |
| 02 | First Rift | ✅ 2026-08-06 |
| 03 | "VERSION" | ✅ 2026-08-06 |
| 04 | Theater Rift (training) | ✅ 2026-08-06 |
| 05 | Skill Tree + "SHIFT" | ✅ 2026-08-06 |
| 06 | Stagehand / Guild Alpha / "1.0" | ✅ 2026-08-06 |
| 07+ | daily auto chapter | ⏰ GitHub Actions cron (06:45 Beijing, ledger-gated) |

## Auto chapters & briefs

A GitHub Actions cron writes one chapter per day into `world/` (ledger-gated:
str+agi+int+vit+wis+stat_points must balance). PR a `briefs/chNN.md` to steer
the next chapter's direction — merged briefs are used by the next auto-run.

## Co-create (5 entrances)

1. **Vote** — Discussions, weekly (next rift / next skill)
2. **Nominate** — Issue template, one sentence
3. **Create** — Skill/Item & Rift Issue templates → credited in-chapter
4. **Bug-hunt** — Ledger Bug template (audit the numbers)
5. **Side stories** — canon-consistent PRs

See [CONTRIBUTING.md](CONTRIBUTING.md).

## IP

© He Qubing (hequbing.com). Contributions enter canon under the contribution license.
