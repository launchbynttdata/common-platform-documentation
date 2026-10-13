# Content disposition

This record is the decision log for legacy material in the knowledge base. It does not repeat private source locations, credentials, account identifiers, or personal filesystem paths.

The rows below are the pull request 1 outcomes. This task does not rewrite active pages into new standards. It does not leave a legacy page in place as a final keep. Rewritten and retained are defined so later tasks use the same outcomes. They have no rows in this task.

A few active pages were edited only where a checker violation or a removed target required it. The platform map no longer calls empty title reservations historical procedures. The repository naming index dropped the section for the archived framework naming scheme and the link to a removed Python placeholder. The library module page dropped a deprecated product name from its example sentence. The standards index no longer lists the tagging page. The versioning page now points at the archived tagging note so that pointer still resolves. The rest of those pages is unchanged.

## Outcomes

**Rewritten.** The durable point is kept, and a current page replaces the old one. The old path does not remain as a second copy of active guidance.

**Retained.** The existing page stays in the active tree because it is still the document the team means to keep. The task does not move it and does not delete it.

**Archived.** The path moves under `archive/` and is historical context, not current guidance. Sensitive values are removed or the unsafe artifact is dropped before the archive is treated as public-safe.

**Removed.** The path is deleted because it is empty scaffolding or it has nothing worth keeping as history. A directory left empty by those deletions is removed as well.

## Archived

The archive task moved these paths with history preserved. Destinations are the archive locations for that move.

| Former path | Destination | Reason |
| --- | --- | --- |
| `platform/common-automation-framework/` | `archive/framework-era/platform/common-automation-framework/` | Service procedures, screenshots, and example inputs from the older automation layout. They are not the current platform map. |
| `platform/development-environments/` | `archive/framework-era/platform/development-environments/` | Step-by-step local and hybrid environment procedures, including tool setup. They are not the platform map. |
| `standards/iac-development/terraform/module/wrapper/deploy/` | `archive/framework-era/standards/iac-development/terraform/module/wrapper/deploy/` | Service-specific deploy notes. They are procedures, not the Terraform module standard. |
| `platform/pipeline/iac/azure-subscription-bootstrapping/` | `archive/framework-era/platform/pipeline/iac/azure-subscription-bootstrapping/` | Subscription bootstrap diagrams and their drawing source. They are historical procedure assets, not an active pipeline standard. |
| `standards/common-development/git/repository/naming-schemes/lcaf-component-names.md` | `archive/framework-era/standards/common-development/git/repository/naming-schemes/lcaf-component-names.md` | Repository names for the deprecated framework. The scheme is historical context, not a current naming standard. |
| `standards/common-development/git/tagging/README.md` | `archive/pre-refresh/standards/common-development/git/tagging/README.md` | The page contained a former-company repository link and a personal shell prompt. It is a historical note, not an active standard. The page was not rewritten. |

`platform/development-environments/` includes substantive tool pages and the placeholder pages outside `serverless/`. Those moved with the directory. The three `serverless/` placeholders were removed instead; see below.

`standards/iac-development/terraform/module/wrapper/deploy/` includes `dns.md` and `expressroute.md`. Both notes stayed in the archived directory. The placeholder `README.md` was removed after the move. Client tenant, subscription, and DNS names in `dns.md` were replaced with obvious neutral examples.

Account identifiers, personal names, contact details, machine-local paths, former-company repository locations, and client hostnames in the archived trees were replaced with obvious neutral examples. The rendered hub-and-spoke diagram image was removed because it showed a client DNS name and could not be redacted as text. The drawing source and HTML export stayed after those names were replaced. An unverified private-link DNS name in that drawing and in the matching HTML export was replaced with `privatelink.example.com` in both files. Console screenshots under the archived automation procedures were removed, except the architecture diagram exports. The VPN client pictures were removed. Two multi-account images that showed a personal GitHub account were removed. A later pass removed more archived screenshots that showed a personal account, a home path, a machine name, cloud account identifiers, an identity-provider start URL, or an email address. Pages no longer reference those removed images.

## Removed

Placeholder-only Markdown has no body after headings are removed, or the body is only an empty marker. Non-empty documents in the same trees were not removed by this task and do not yet have a rewritten or retained outcome.

| Former path | Reason |
| --- | --- |
| Every `*.md` file under `platform/pipeline/` | Each one was placeholder-only and only reserved a pipeline title. This does not include `platform/pipeline/iac/azure-subscription-bootstrapping/`, which has no Markdown and was archived above. |
| Every `.keep` file under `platform/infrastructure/`, then any directory that deletion left empty | The tree had no documentation. It only reserved infrastructure titles. |
| Placeholder-only `*.md` files under `standards/common-development/` | Empty or heading-only pages reserved titles. The non-empty exceptions below stayed in place. |
| Placeholder-only `*.md` files under `standards/iac-development/` | Empty pages reserved titles. The non-empty module and strategy pages below stayed in place. The placeholder `standards/iac-development/terraform/module/wrapper/deploy/README.md` was removed even though its directory was archived. |
| `platform/development-environments/serverless/README.md` | Placeholder-only. Not kept inside the archived environment tree. |
| `platform/development-environments/serverless/aws-sam-cli/README.md` | Placeholder-only. Not kept inside the archived environment tree. |
| `platform/development-environments/serverless/azure-functions-core-tools/README.md` | Placeholder-only. Not kept inside the archived environment tree. |
| `platform/launch-public-service/README.md` | Empty placeholder. The module-registry page in the same directory stayed. |
| `platform/launch-public-service/regula-policies/README.md` | Empty placeholder. The directory held no other file, so the directory was removed. |
| `platform/development-environments/hybrid/terraform/hub-spoke_networks/architecture_diagram-per_wrapper.jpg` | The rendered diagram showed a client DNS name. The image could not be redacted, so it was removed instead of archived. |
| Console screenshots under `platform/common-automation-framework/`, except `*complete.png` architecture exports | The samples showed account identifiers and live webhook URLs. The images could not be redacted, so the console captures were removed. |
| `platform/development-environments/local/tools/aws/configure_vpn_client/pictures/` | The pictures showed account details, VPN configuration, and a VPN endpoint. The directory was removed. |
| `platform/development-environments/local/tools/git/multi-account/images/github-user-selection.png` | The image showed personal GitHub account names. |
| `platform/development-environments/local/tools/git/multi-account/images/reauthorization.png` | The image showed a personal GitHub account name. |
| `archive/framework-era/platform/development-environments/local/tools/git/token/pictures/img_1.png` | The image showed a personal GitHub account. |
| `archive/framework-era/platform/development-environments/local/tools/asdf/pictures/3.2-asdf-terminal-01.png` | The image showed a personal account name and a machine name. |
| `archive/framework-era/platform/development-environments/local/tools/asdf/pictures/3.2-asdf-install-01.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/asdf/pictures/3.2-asdf-shell-01.png` | The image showed a personal account name and a machine name. |
| `archive/framework-era/platform/development-environments/local/tools/asdf/pictures/3.2-asdf-version-01.png` | The image showed a personal account name and a machine name. |
| `archive/framework-era/platform/development-environments/local/tools/homebrew/pictures/3.1-homebrew-install-01.png` | The image showed a personal account name and a home path. |
| `archive/framework-era/platform/development-environments/local/tools/homebrew/pictures/3.1-homebrew-terminal-01.png` | The image showed a personal account name and a machine name. |
| `archive/framework-era/platform/development-environments/local/tools/gradle/pictures/3.3-intellij-gradle-02.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/java/17/pictures/3.3-intellij-java-04.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/java/17/pictures/3.3-intellij-java-05.png` | The image showed a personal account name and a machine name. |
| `archive/framework-era/platform/development-environments/local/tools/vscode/dev-containers/pictures/dev-containers-new-container-ubuntu-fresh.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/vscode/dev-containers/pictures/dev-containers-new-container-ubuntu-script-settings.png` | The image showed cloud account identifiers, an identity-provider start URL, and an email address. |
| `archive/framework-era/platform/development-environments/local/tools/jetbrains/dev-containers/pictures/3-intellij-devcontainer-build-01.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/jetbrains/dev-containers/pictures/3-intellij-devcontainer-copy-01.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/jetbrains/dev-containers/pictures/3-intellij-devcontainer-postcreate-01.png` | The image showed a personal home path. |
| `archive/framework-era/platform/development-environments/local/tools/jetbrains/dev-containers/pictures/3-intellij-devcontainer-postcreate-copy-01.png` | The image showed an identity-provider start URL and an email address. |
| `archive/framework-era/platform/development-environments/local/tools/jetbrains/dev-containers/pictures/3-intellij-devcontainer-postcreate-settings-01.png` | The image showed cloud account identifiers, an identity-provider start URL, an email address, and a personal home path. |
| Directories left empty by the deletions above | They existed only to hold the removed scaffolding. |

### Non-empty documents this task does not remove

Under `standards/common-development/`:

- `standards/common-development/git/repository/naming-schemes.md`
- `standards/common-development/git/repository/naming-schemes/iac-repository-names.md`
- `standards/common-development/git/repository/naming-schemes/platform-sample-applications.md`
- `standards/common-development/versioning/README.md`
- `standards/common-development/java/hexagonal/pictures/`

The hexagonal pictures stayed because they are not Markdown and the directory was not empty after the placeholder page was removed. They are not a current standard.

Under `standards/iac-development/`, excluding the archived deploy directory:

- `standards/iac-development/README.md`
- `standards/iac-development/terraform/module/primitive/README.md`
- `standards/iac-development/terraform/module/collection/README.md`
- `standards/iac-development/terraform/module/reference-architecture/README.md`
- `standards/iac-development/terraform/module/library/README.md`

Under the archived deploy directory, `dns.md` and `expressroute.md` were archived, not removed.

No other legacy path receives an outcome in this task. Later tasks record those decisions in this file.
