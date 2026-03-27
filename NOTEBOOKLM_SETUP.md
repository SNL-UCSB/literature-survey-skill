# NotebookLM MCP CLI: Setup Guide

This skill requires the [NotebookLM MCP CLI](https://github.com/jacob-bd/notebooklm-mcp-cli) as a backend. Follow these steps to install it, authenticate, and register it as an MCP server in Claude Code.

## Prerequisites

- **Python 3.8+**
- **`uv`** (recommended) — install via `curl -LsSf https://astral.sh/uv/install.sh | sh`
- **A Chromium-based browser** (Chrome, Arc, Brave, Edge) for Google authentication

## Step 1: Install the CLI

```bash
uv tool install notebooklm-mcp-cli
```

This installs two commands: `nlm` (the CLI) and `notebooklm-mcp` (the MCP server).

Alternative install methods:

```bash
pip install notebooklm-mcp-cli    # pip
pipx install notebooklm-mcp-cli   # pipx
```

## Step 2: Authenticate with Google

```bash
nlm login
```

This launches a browser window. Log into the Google account that has NotebookLM access. Cookies are extracted automatically and stored in `~/.notebooklm-mcp-cli/`.

Verify authentication:

```bash
nlm login --check
```

If you use multiple Google accounts:

```bash
nlm login --profile work
nlm login --profile personal
nlm login switch work          # set default profile
```

## Step 3: Register as an MCP Server in Claude Code

**Option A — Automatic (recommended):**

```bash
nlm setup add claude-code
```

**Option B — One-liner:**

```bash
claude mcp add --scope user notebooklm-mcp notebooklm-mcp
```

**Option C — Manual JSON config:**

Add to your Claude Code MCP settings (`~/.claude.json` or project `.mcp.json`):

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "command": "notebooklm-mcp"
    }
  }
}
```

If Claude Code can't find the binary, use the full path (`which notebooklm-mcp` to find it):

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "command": "/full/path/to/notebooklm-mcp"
    }
  }
}
```

**Option D — Without installing (uvx):**

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "command": "uvx",
      "args": ["--from", "notebooklm-mcp-cli", "notebooklm-mcp"]
    }
  }
}
```

## Step 4: Verify

Restart Claude Code (or open a new session), then run:

```bash
nlm doctor
```

This diagnoses authentication and MCP configuration issues.

Inside Claude Code, the NotebookLM tools (e.g., `notebook_create`, `notebook_query`, `source_add`) should now appear as available MCP tools.

## Upgrading

```bash
uv tool upgrade notebooklm-mcp-cli   # or pip/pipx equivalent
```

Restart Claude Code after upgrading so it reconnects to the updated MCP server.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `nlm login` fails to open browser | Try `nlm login --manual --file cookies.txt` with a manually exported cookie file |
| Claude Code doesn't see the tools | Run `which notebooklm-mcp` and use the full path in your MCP config |
| Authentication expired | Re-run `nlm login` — cookies expire periodically |
| Rate limited | Free tier is ~50 queries/day. Track usage in your survey's `nlm_config.md` |

## Heads Up

NotebookLM MCP CLI uses undocumented internal APIs that may change without notice. It is a personal/experimental tool — not an official Google product. The MCP server exposes ~35 tools; disable it when not actively surveying to preserve context window space.
