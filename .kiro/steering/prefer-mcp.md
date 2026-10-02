# Prefer MCP servers over built-in equivalents

When an MCP server covers a capability, use it instead of the built-in tool or raw shell command.

## Git

- Local git operations (status, diff, log, add, commit, branch, etc.) use the `git` shell command. There is no local git MCP.
- For GitHub operations (pull requests, issues, reviews, releases), prefer the GitHub MCP server over scripting the GitHub API or raw shell.
- Fall back to shell only when the GitHub MCP is disabled/unavailable, or the operation has no MCP equivalent.

## Fetch

- Prefer the fetch MCP server for retrieving web content over Kiro's built-in web fetch.
- Fall back to the built-in fetch only when the fetch MCP is disabled/unavailable.
