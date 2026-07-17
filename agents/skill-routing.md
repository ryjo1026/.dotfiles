# Skill routing

Skills follow the [Agent Skills](https://agentskills.io) format (`<name>/SKILL.md`, lowercase-hyphen name matching the dir). Everything merges into `~/.agents/skills/`, which most agents (Codex, Cursor, Gemini CLI, OpenCode, Amp) read natively; `run_onchange_after_agent-skills.sh` fans the merged dir into agents that don't (Claude Code) and prunes dangling links.

## Creating a skill: pick the layer by audience first

This dotfiles repo carries **no skill content** — skills live in source repos, laid out as `<name>/SKILL.md` at the repo root:

| Audience | Repo | Notes |
| --- | --- | --- |
| Public (anyone) | [`ryjo1026/skills`](https://github.com/ryjo1026/skills) | all machines; nothing work-related or private |
| Private (only Ryan) | `ryanjohnston-abridge/skills-private` | work-hosted, work machines only |
| Team | `abridgeai/ryan-skills` | work machines only |
| Experiment / trial | real dir in `~/.agents/skills/<name>/` | unmanaged; promote to a repo if it sticks |

If the layer is ambiguous, ask — moving later is cheap but a work detail committed to a public repo is not undoable.

## Mechanics

- External sources are cloned to `~/.agents/sources/<name>` via `.chezmoiexternal.toml.tmpl`; adding a source also requires adding its name to `SOURCES` in `.chezmoiscripts/run_onchange_after_agent-skills.sh.tmpl` (array order = collision precedence).
- Real dirs in `~/.agents/skills` beat source symlinks on name collision.
- Per-machine gating: profile conditionals in `.chezmoiexternal.toml.tmpl`, OS gating in `.chezmoiignore`.
- Never touch `~/.agents/.skill-lock.json` — owned by the `npx skills` CLI, which wipes formats it doesn't recognize.
- Remove a skill by deleting it from its source repo; the next `chezmoi apply` prunes its links.
