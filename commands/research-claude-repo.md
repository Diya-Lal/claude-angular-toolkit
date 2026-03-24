# Research Claude GitHub Repo

The user has shared a GitHub repository URL. Clone it, read it, and give them a sharp, practical summary focused on what they can actually use today.

## Steps

### 1. Clone the repo

Extract `owner/repo` from the URL if a full URL was given, then clone to a temp directory:
```bash
gh repo clone owner/repo /tmp/claude-repo-research/repo-name
```

### 2. Scan the structure

```bash
find /tmp/claude-repo-research/repo-name -maxdepth 4 \
  \( -name "*.md" -o -name "*.json" -o -name "*.ts" -o -name "*.py" \) \
  | grep -v node_modules | grep -v ".git" | head -50

ls /tmp/claude-repo-research/repo-name/.claude 2>/dev/null
```

### 3. Read the key files (in this order)

- `README.md` — always first
- `CLAUDE.md` — at root and in subdirectories
- Any `SKILL.md` files
- `.claude/` directory — commands, hooks, settings
- `hooks/` or `commands/` directories if present

Focus on files that shape your understanding of value — don't read everything.

### 4. Write the report

Use this exact structure:

---

## What It Does
[1–2 sentences. Concrete. What problem does this solve?]

## The 3 Most Valuable Things Inside
1. **[Name]** — [What it is and why it's useful. One sentence.]
2. **[Name]** — [What it is and why it's useful. One sentence.]
3. **[Name]** — [What it is and why it's useful. One sentence.]

## What to Copy Into Your `.claude/` Directory

| Copy This (repo path) | To Here (~/.claude/...) | Why |
|-----------------------|--------------------------|-----|
| `path/in/repo`        | `~/.claude/path`         | reason |

If nothing is worth copying, say so honestly.

## Use It Right Now

[One concrete, copy-paste-ready example — exact command, prompt, or file to edit. Not "you could" — "do this:"]

---

Be direct. If the repo is mostly hype with little substance, say so.
