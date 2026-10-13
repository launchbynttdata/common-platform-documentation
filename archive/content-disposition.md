# Content disposition

This record is the decision log for legacy material in the knowledge base. It does not repeat private source locations, credentials, account identifiers, or personal filesystem paths.

The archive task that follows this navigation change implements the archived and removed rows below. It does not rewrite active prose and it does not leave a legacy page in place as a final keep. Rewritten and retained are defined so later tasks use the same outcomes. They have no rows in this task.

## Outcomes

**Rewritten.** The durable point is kept, and a current page replaces the old one. The old path does not remain as a second copy of active guidance.

**Retained.** The existing page stays in the active tree because it is still the document the team means to keep. The task does not move it and does not delete it.

**Archived.** The path moves under `archive/` and is historical context, not current guidance. Sensitive values are removed or the unsafe artifact is dropped before the archive is treated as public-safe.

**Removed.** The path is deleted because it is empty scaffolding or it has nothing worth keeping as history. A directory left empty by those deletions is removed as well.

## Archived

The archive task moves these paths with history preserved. Destinations are the archive locations for that move.

| Former path | Destination | Reason |
| --- | --- | --- |
| `platform/common-automation-framework/` | `archive/framework-era/platform/common-automation-framework/` | Service procedures, screenshots, and example inputs from the older automation layout. They are not the current platform map. |
| `platform/development-environments/` | `archive/framework-era/platform/development-environments/` | Step-by-step local and hybrid environment procedures, including tool setup. They are not the platform map. |
| `standards/iac-development/terraform/module/wrapper/deploy/` | `archive/framework-era/standards/iac-development/terraform/module/wrapper/deploy/` | Service-specific deploy notes. They are procedures, not the Terraform module standard. |
| `platform/pipeline/iac/azure-subscription-bootstrapping/` | `archive/framework-era/platform/pipeline/iac/azure-subscription-bootstrapping/` | Subscription bootstrap diagrams and their drawing source. They are historical procedure assets, not an active pipeline standard. |

`platform/development-environments/` includes substantive tool pages and the placeholder pages outside `serverless/`. Those move with the directory. The three `serverless/` placeholders are removed instead; see below.

`standards/iac-development/terraform/module/wrapper/deploy/` includes `dns.md`, `expressroute.md`, and a placeholder `README.md`. The two notes stay in the archived directory. The placeholder `README.md` is removed after the move.

## Removed

Placeholder-only Markdown has no body after headings are removed, or the body is only an empty marker. Non-empty documents in the same trees are not removed by this task and do not yet have a rewritten or retained outcome.

| Former path | Reason |
| --- | --- |
| Every `*.md` file under `platform/pipeline/` | Each one is placeholder-only and only reserves a pipeline title. This does not include `platform/pipeline/iac/azure-subscription-bootstrapping/`, which has no Markdown and is archived above. |
| Every `.keep` file under `platform/infrastructure/`, then any directory that deletion leaves empty | The tree has no documentation. It only reserves infrastructure titles. |
| Placeholder-only `*.md` files under `standards/common-development/` | Empty or heading-only pages reserve titles. The non-empty exceptions below stay in place. |
| Placeholder-only `*.md` files under `standards/iac-development/` | Empty pages reserve titles. The non-empty module and strategy pages below stay in place. The placeholder `standards/iac-development/terraform/module/wrapper/deploy/README.md` is removed even though its directory is archived. |
| `platform/development-environments/serverless/README.md` | Placeholder-only. Not kept inside the archived environment tree. |
| `platform/development-environments/serverless/aws-sam-cli/README.md` | Placeholder-only. Not kept inside the archived environment tree. |
| `platform/development-environments/serverless/azure-functions-core-tools/README.md` | Placeholder-only. Not kept inside the archived environment tree. |
| Directories left empty by the deletions above | They exist only to hold the removed scaffolding. |

### Non-empty documents this task does not remove

Under `standards/common-development/`:

- `standards/common-development/git/repository/naming-schemes.md`
- `standards/common-development/git/repository/naming-schemes/iac-repository-names.md`
- `standards/common-development/git/repository/naming-schemes/lcaf-component-names.md`
- `standards/common-development/git/repository/naming-schemes/platform-sample-applications.md`
- `standards/common-development/git/tagging/README.md`
- `standards/common-development/versioning/README.md`

Under `standards/iac-development/`, excluding the archived deploy directory:

- `standards/iac-development/README.md`
- `standards/iac-development/terraform/module/primitive/README.md`
- `standards/iac-development/terraform/module/collection/README.md`
- `standards/iac-development/terraform/module/reference-architecture/README.md`
- `standards/iac-development/terraform/module/library/README.md`

Under the archived deploy directory, `dns.md` and `expressroute.md` are archived, not removed.

No other legacy path receives an outcome in this task. Later tasks record those decisions in this file.
