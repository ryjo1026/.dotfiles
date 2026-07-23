# Agent context

This is a **chezmoi source directory** (public repo). Files here render/deploy to `$HOME` on `chezmoi apply`.

- Always edit here, never the deployed copies in `$HOME`; run `chezmoi apply` after.
- Consult https://www.chezmoi.io/ docs before relying on general chezmoi knowledge — key pages: [concepts](https://www.chezmoi.io/reference/concepts/), [source state attributes](https://www.chezmoi.io/reference/source-state-attributes/), [templates](https://www.chezmoi.io/reference/templates/), [special files](https://www.chezmoi.io/reference/special-files-and-directories/), [commands](https://www.chezmoi.io/reference/commands/).
- Root files without `dot_` prefix deploy to `$HOME` too — repo-only files must be listed in `.chezmoiignore`.
- Every `*.tmpl` must render for both `darwin/arm64` and `linux/amd64` (pre-push hook enforces this).
- Per-tool shell config is its own self-guarding module in `dot_zsh/` (see `pyenv.zsh`, `mise.zsh`), auto-sourced by `.zshrc`. Guard on the tool's presence (`command -v` or `[[ -d ... ]]`) so it no-ops where absent — don't append tool setup to `dot_zshrc.tmpl`/`dot_zshrc.mac.tmpl`.

Detailed agent docs live in `agents/`:

- **Before creating, moving, or removing any skill (`SKILL.md`), read [`agents/skill-routing.md`](agents/skill-routing.md)** — it defines the layered routing system (public / private / team / trial) and where a new skill must live based on its audience. Never drop skills directly into `~/.claude/skills/`.

`CLAUDE.md` is a symlink to this file — edit here only.
