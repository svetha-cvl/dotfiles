# AI tooling (shared skills)

Global skills live in **`skills/`**. Each skill is a directory:

```text
skills/
  <skill-name>/
    SKILL.md          # required — Cursor and OpenCode both use this name
    scripts/          # optional
    reference.md      # optional
```

Do **not** edit or version **`~/.cursor/skills-cursor/`**; that directory is reserved for Cursor’s built-in skills.

## Cursor and OpenCode

Running [`install.sh`](../install.sh) symlinks:

- `~/.cursor/skills` → `<dotfiles>/ai/skills`
- `~/.config/opencode/skills` → `<dotfiles>/ai/skills`

Both tools read the same tree; changes stay in this repository.

## Migrating existing skills

If `~/.cursor/skills` or `~/.config/opencode/skills` is already a **plain directory** (not a symlink), `ln -snf` may fail or behave oddly on macOS. Move or merge those skill folders into `dotfiles/ai/skills/`, remove or rename the old directory, then re-run `install.sh`.
