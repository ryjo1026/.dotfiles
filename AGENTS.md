# Agent context

This is a **chezmoi source directory** (public repo). Files here render/deploy to `$HOME` on `chezmoi apply`.

- Always edit here, never the deployed copies in `$HOME`; run `chezmoi apply` after.
- Consult https://www.chezmoi.io/ docs before relying on general chezmoi knowledge — key pages: [concepts](https://www.chezmoi.io/reference/concepts/), [source state attributes](https://www.chezmoi.io/reference/source-state-attributes/), [templates](https://www.chezmoi.io/reference/templates/), [special files](https://www.chezmoi.io/reference/special-files-and-directories/), [commands](https://www.chezmoi.io/reference/commands/).
- Root files without `dot_` prefix deploy to `$HOME` too — repo-only files must be listed in `.chezmoiignore`.
- Every `*.tmpl` must render for both `darwin/arm64` and `linux/amd64` (pre-push hook enforces this).

Detailed agent docs live in `agents/`:

- **Before creating, moving, or removing any skill (`SKILL.md`), read [`agents/skill-routing.md`](agents/skill-routing.md)** — it defines the layered routing system (public / private / team / trial) and where a new skill must live based on its audience. Never drop skills directly into `~/.claude/skills/`.

`CLAUDE.md` is a symlink to this file — edit here only.
