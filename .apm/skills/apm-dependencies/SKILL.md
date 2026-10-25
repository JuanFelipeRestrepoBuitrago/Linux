---
name: apm-dependencies
description: Manages APM (Agent Package Manager) dependencies for the current project — install, update, uninstall, lock, outdated, prune, inspect, audit, and diagnose APM packages, MCP servers, and LSP services declared in apm.yml. Use when the user asks to install, add, update, refresh, remove, lock, audit, or troubleshoot apm dependencies, MCP servers, or the apm.yml / apm.lock.yaml files.
---

# APM dependencies

Operate the full `apm` dependency lifecycle: the sources of truth are `apm.yml` (declared deps + `targets:`) and `apm.lock.yaml` (resolved refs). `apm` deploys primitives into each declared target's native layout (kiro, claude, codex, cursor, copilot, …).

## When to use

The user asks to install, add, update, refresh, remove, lock, inspect, audit, or diagnose APM packages, MCP servers, or LSP services — anything touching `apm.yml` / `apm.lock.yaml`.

## Preflight

- Confirm the working directory is the intended project root (it must contain, or will create, `apm.yml`). For user-scope operations add `-g` / `--global` (acts on `~/.apm/`).
- If anything fails with auth/network/git errors, run `apm doctor` first and resolve what it reports.
- Prefer `--dry-run` before any mutating command when the outcome is uncertain, and show the plan to the user.

## Actions

### Install

```bash
apm install                 # install everything declared in apm.yml (auto-creates apm.yml if missing)
apm install <pkg>...        # add and install specific packages (APM pkgs, Claude SKILL.md, plugin.json)
apm install --frozen        # CI-safe: fail if apm.lock.yaml is missing or out of sync with apm.yml
apm install --only apm      # or --only mcp — restrict to one dependency kind
apm install --target kiro   # scope deploy to one/more targets (comma-separated)
apm install --dry-run       # preview without writing
```

- `--frozen` reproduces the lockfile exactly; it is mutually exclusive with `--update`, `--mcp`, and positional packages. Use it in CI.
- `--force` overwrites locally-authored files on collision and deploys despite critical security findings. It does NOT refresh refs — use `apm update` for that. Only use `--force` when the user accepts the overwrite.
- Add `--allow-insecure` only if a package must be fetched over `http://`.

### Update (refresh refs)

```bash
apm update                  # interactive plan, refresh deps to latest matching refs, rewrite lockfile
apm update --yes            # CI/automation: skip confirmation
apm update --dry-run        # render the plan and exit
apm update --target claude,cursor   # scope to targets
apm update -g               # user scope
```

Prefer `apm update` over the deprecated `apm install --update`.

### Uninstall / clean

```bash
apm uninstall <pkg>...      # remove by manifest entry or locked key (see 'apm deps list')
apm uninstall --dry-run <pkg>   # preview (pre-uninstall scripts still run)
apm deps clean              # remove ALL apm dependencies
apm prune                   # remove packages no longer in the resolved graph, repair stale owners
apm prune --dry-run
```

### Lock (resolve without deploying)

```bash
apm lock                    # resolve deps and write apm.lock.yaml, no deploy/delete
apm lock --update           # re-resolve refs to latest SHAs before writing
apm lock export             # export an SBOM / inventory from the lockfile
```

### Inspect

```bash
apm outdated                # show locked deps that have drifted from upstream (-v for available tags)
apm deps list               # installed deps and their primitives (gives the locked keys for uninstall)
apm deps tree               # full dependency tree
apm deps why <pkg>          # explain why a package is installed (walks the lockfile back)
apm view <org/repo>             # local package metadata
apm view <org/repo> versions    # remote tags/branches (--registry to query a registry)
```

### MCP servers

```bash
apm mcp search <query>      # search the MCP registry
apm mcp list                # list available MCP servers
apm mcp show <name>         # detailed server info
apm mcp install <name>      # add an MCP server to apm.yml
```

MCP servers live under `dependencies.mcp:` in `apm.yml` (transport, command, args, `disabledTools`). After editing, run `apm install --only mcp` to deploy.

### Audit & security

```bash
apm audit                   # scan installed primitives for hidden Unicode, drift, lockfile/policy violations
apm audit --ci              # CI gate: exit 0 clean / 1 on violations
apm audit --strip           # remove hidden characters (use --dry-run first to preview)
apm audit -f sarif -o apm.sarif   # SARIF for GitHub Code Scanning
```

### Environment & maintenance

```bash
apm doctor                  # diagnostics: git, network, auth, marketplace config (non-zero on critical fail)
apm auth <host>             # resolve/validate a git host credential (--check hits the REST API)
apm cache info              # cache location and size
apm cache prune --days N    # drop old checkout SHA groups
apm cache clean             # wipe the cache
apm self-update             # update the apm binary itself (--check to only look)
```

## Rules

- Never hardcode tokens in `apm.yml`; `apm auth` reads from env vars (`GITHUB_APM_PAT` / `GITHUB_TOKEN` / `GH_TOKEN`, `GITLAB_APM_PAT` / `GITLAB_TOKEN`) or the git credential helper.
- Treat `apm.lock.yaml` as the reproducibility anchor: commit it, and use `--frozen` in CI.
- Pin and review refs; run `apm audit` after installing untrusted packages before trusting deployed primitives.
- Use `--dry-run` and show the plan before destructive or force operations (`uninstall`, `prune`, `deps clean`, `--force`).
- A command's `-g` / `--global` flag switches it to user scope (`~/.apm/`); confirm scope with the user when it is ambiguous.
