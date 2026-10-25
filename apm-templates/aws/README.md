# aws

AWS skills and the AWS MCP Server for your AI coding agents, installed with the **AWS CLI Agent
Toolkit** — not through APM.

This template is **README-only on purpose**. APM carries single-file instruction/agent/prompt refs
and inline MCP declarations; it does not own multi-file skill directories or the AWS MCP wiring. The
AWS CLI already installs and updates both, globally, into each detected agent's config directory
(`~/.kiro` for Kiro). Duplicating 20+ skill folders into `.apm` would mean maintaining a second copy
and losing the CLI's update path. So the setup below uses the AWS tool for what it owns, and this
template just documents it.

## What the toolkit installs

| Kind        | Where                                              | Owner        |
| ----------- | -------------------------------------------------- | ------------ |
| AWS skills  | `~/.kiro/skills/` (e.g. `aws-cdk`, `aws-serverless`) | AWS CLI      |
| AWS MCP server | `~/.kiro/settings/mcp.json`                     | AWS CLI      |

Skills are installed **globally** in the agent's config directory, not per project.

## Prerequisites

- **AWS CLI 2.35.0 or later.** Check with `aws --version`; see the [AWS CLI install guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- **A supported agent installed.** The CLI detects agents by their config directory — `~/.kiro`
  for Kiro. If the directory exists, the agent is detected.

## One-step setup (recommended)

Run the interactive wizard. It detects installed agents, installs the default AWS skills, and
configures the AWS MCP Server connection:

```sh
aws configure agent-toolkit
```

The wizard asks you to pick agents, confirms the default skill set, then writes:

- skills to `~/.kiro/skills/`
- the AWS MCP server to `~/.kiro/settings/mcp.json`

Restart your agent client afterward so it loads the new configuration.

To skip every prompt and accept defaults (all detected agents, default skills, AWS MCP server):

```sh
aws configure agent-toolkit --yes
```

## Managing individual skills

The wizard installs a small default set. Add, update, remove, and discover more with the
`aws agent-toolkit` command group. By default these apply to **all** detected agents; use `--agent kiro`
to target Kiro only.

```sh
# discover
aws agent-toolkit list-available-skills
aws agent-toolkit search-skills --search-query serverless

# install (all agents, or just Kiro)
aws agent-toolkit add-skill --skill-name aws-serverless
aws agent-toolkit add-skill --skill-name aws-cdk --agent kiro

# pin a version
aws agent-toolkit add-skill --skill-name aws-serverless --skill-version v1

# update / remove
aws agent-toolkit update-skill --skill-name aws-serverless
aws agent-toolkit remove-skill --skill-name aws-cdk --agent kiro

# inspect what's installed
aws agent-toolkit list-installed-skills --agent kiro
```

## Notes

- Skills are **global**, under `~/.kiro/`, shared across all your projects — there is no per-project
  install.
- The AWS MCP Server entry the wizard writes into `~/.kiro/settings/mcp.json` is managed by the AWS
  CLI; let the CLI update it rather than hand-editing.
- Nothing here installs through `apm install`. There is no `apm.yml` in this template by design.

## Sources

- [Agent Toolkit for AWS — AWS CLI](https://docs.aws.amazon.com/agent-toolkit/latest/userguide/aws-cli.html)
- [`aws configure agent-toolkit` command reference](https://docs.aws.amazon.com/cli/latest/reference/configure/agent-toolkit.html)

_Content was rephrased for compliance with licensing restrictions._
