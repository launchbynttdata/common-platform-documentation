# Topic index

This index helps readers and AI tools find canonical guidance quickly. Each entry links to the authoritative source page. Summaries and aliases here are routing aids; they do not replace the source.
An entry is a team position only when it carries a `strength` label. `new-idea` entries are proposals under exploration.

Archived pages are not indexed as canonical sources. Compatibility addresses can appear in `former_paths` only.

## Entries

```yaml
- id: docs.how-to-read-these-docs
  title: How to read these docs
  summary: Explains document types, page structure, strength labels, and change process.
  aliases: [reader guide]
  type: knowledge-base
  source: how-to-read-these-docs.md
- id: docs.promoting-an-idea
  title: Promote a new idea into active guidance
  summary: Defines how a proposal moves into active principles, practices, or standards.
  aliases: [promotion process]
  type: knowledge-base
  strength: Team default
  source: promoting-an-idea.md
- id: docs.maintaining-the-topic-index
  title: Maintain the topic index with the source
  summary: Defines how topic-index updates stay synchronized with canonical pages.
  aliases: [topic index maintenance, index maintenance]
  type: knowledge-base
  strength: Team default
  source: maintaining-the-topic-index.md
- id: idea.helm-and-argocd
  title: Deliver Kubernetes workloads with Helm and Argo CD
  summary: Proposal for packaging with Helm and reconciling with Argo CD.
  aliases: [helm, argocd]
  type: new-idea
  status: Exploring
  source: new-ideas/helm-and-argocd.md
- id: platform.evolutionary-database-deployment
  title: Evolutionary database changes
  summary: Covers database evolution aligned with immutable delivery practices.
  aliases: [database migration]
  type: platform-map
  strength: Team default
  source: platform/continuous-deployment/evolutionary-database-deployment/README.md
- id: platform.immutable-application-deployment
  title: Immutable application deployment
  summary: Describes immutable deployment as part of the delivery capability map.
  aliases: [immutable deploy]
  type: platform-map
  strength: Team default
  source: platform/continuous-deployment/immutable-application-deployment/README.md
- id: platform.terraform-module-registry
  title: The registry is where Terraform downloads a public module
  summary: Maps the module registry capability and ownership boundary.
  aliases: [module registry]
  type: platform-map
  source: platform/launch-public-service/terraform-module-registry/README.md
- id: platform.readiness
  title: Readiness is the delivery path at the start of an engagement
  summary: Maps readiness capability at engagement start.
  aliases: [sprint zero readiness]
  type: platform-map
  source: platform/readiness.md
- id: platform.repository-instructions
  title: A module repository contains a README and instructions for coding agents
  summary: Maps where module-level instructions and ownership live.
  aliases: [repo instructions]
  type: platform-map
  source: platform/repository-instructions.md
- id: platform.reusable-modules
  title: The team publishes Terraform modules that others can reuse
  summary: Maps reusable module publication capability.
  aliases: [public modules]
  type: platform-map
  source: platform/reusable-modules.md
- id: platform.reusable-workflows
  title: Shared automation for delivery and for pipelines
  summary: Maps shared workflow automation capability.
  aliases: [reusable workflows]
  type: platform-map
  source: platform/reusable-workflows.md
- id: platform.terraform-module-template
  title: The template is how a new Terraform module repository starts
  summary: Maps the template capability used to initialize module repositories.
  aliases: [module template]
  type: platform-map
  source: platform/terraform-module-template.md
- id: platform.terraform-skeleton
  title: The skeleton shares configuration across Terraform module repositories
  summary: Maps shared skeleton capability across module repositories.
  aliases: [terraform skeleton]
  type: platform-map
  source: platform/terraform-skeleton.md
- id: practice.ai-assisted-engineering
  title: Use AI without giving up accountability
  summary: Defines accountable AI-assisted engineering practices.
  aliases: [ai-assisted engineering]
  type: practice
  strength: Team default
  source: practices/ai-assisted-engineering.md
- id: practice.application-platform-boundary
  title: Work at the application and platform boundary
  summary: Describes expected ownership and collaboration at the app/platform boundary.
  aliases: [application platform boundary]
  type: practice
  strength: Team default
  source: practices/application-platform-boundary.md
- id: practice.infrastructure-as-software
  title: Maintain infrastructure as software
  summary: Defines infrastructure-as-software practice expectations.
  aliases: [infrastructure as software]
  type: practice
  strength: Team default
  source: practices/infrastructure-as-software.md
- id: practice.observability-and-operability
  title: Observe the system in order to operate it
  summary: Defines observability and operability practices.
  aliases: [observability, monitoring, telemetry]
  type: practice
  strength: Team default
  source: practices/observability-and-operability.md
- id: practice.security-as-shared-responsibility
  title: Share responsibility for security
  summary: Defines shared security responsibilities across delivery teams.
  aliases: [shared security]
  type: practice
  strength: Team default
  source: practices/security-as-shared-responsibility.md
- id: practice.sprint-zero-platform-readiness
  title: Establish a minimum platform path at the start
  summary: Defines minimum platform readiness expectations at engagement start.
  aliases: [sprint zero]
  type: practice
  strength: Team default
  source: practices/sprint-zero-platform-readiness.md
- id: practice.technical-backstop
  title: Help when ownership is unclear
  summary: Defines technical backstop expectations when ownership is unclear.
  aliases: [technical backstop]
  type: practice
  strength: Team default
  source: practices/technical-backstop.md
- id: practice.trustworthy-software-delivery
  title: Deliver software through an evidence chain
  summary: Defines trustworthy software delivery through evidence-backed change.
  aliases: [evidence chain]
  type: practice
  strength: Team default
  source: practices/trustworthy-software-delivery.md
- id: principle.built-in-from-the-beginning
  title: Build delivery, security, and observability in from the start
  summary: Principle that critical delivery capabilities are built in from the beginning.
  aliases: [built in]
  type: principle
  strength: Principle
  source: principles/built-in-from-the-beginning.md
- id: principle.outcomes-over-activity
  title: Platform work serves delivery outcomes
  summary: Principle that platform work is measured by delivery outcomes.
  aliases: [outcomes over activity]
  type: principle
  strength: Principle
  source: principles/outcomes-over-activity.md
- id: principle.rigor-follows-dependency
  title: Rigor increases as others depend on a capability
  summary: Principle that required rigor scales with downstream dependency.
  aliases: [rigor]
  type: principle
  strength: Principle
  source: principles/rigor-follows-dependency.md
- id: principle.safe-speed-and-accountability
  title: Speed is safe when controls keep pace
  summary: Principle that speed is sustainable only when controls keep pace.
  aliases: [safe speed]
  type: principle
  strength: Principle
  source: principles/safe-speed-and-accountability.md
- id: principle.self-contained-repository-delivery
  title: Self-contained repository delivery
  summary: Principle that repositories should support delivery without hidden dependencies.
  aliases: [self contained repository]
  type: principle
  strength: Principle
  source: principles/self-contained-repository-deployment-principle.md
- id: principle.single-purpose-repository
  title: Single-purpose repository
  summary: Principle that repositories should have one clear purpose.
  aliases: [single purpose repository]
  type: principle
  strength: Principle. The team default for repository topology is labeled where it appears.
  source: principles/single-purpose-repository-principle.md
- id: principle.stewardship-and-enablement
  title: Leave people and systems more capable
  summary: Principle that platform work should increase long-term capability.
  aliases: [stewardship]
  type: principle
  strength: Principle
  source: principles/stewardship-and-enablement.md
- id: principle.trust-and-evidence
  title: Trust is earned through reliability and evidence
  summary: Principle that trust is built through evidence-backed reliability.
  aliases: [trust and evidence]
  type: principle
  strength: Principle
  source: principles/trust-and-evidence.md
- id: standard.repository-contract-naming
  title: Name a repository for the contract it publishes
  summary: Standard for naming repositories by published contract.
  aliases: [repository naming]
  type: standard
  strength: Team default
  source: standards/common-development/git/repository/naming-schemes.md
- id: standard.infrastructure-repository-naming
  title: Name infrastructure repositories by tool, provider, and name
  summary: Standard for infrastructure repository names.
  aliases: [iac repository names]
  type: standard
  strength: Team default
  source: standards/common-development/git/repository/naming-schemes/iac-repository-names.md
- id: standard.sample-application-repository-naming
  title: Name platform sample applications by language, platform, and purpose
  summary: Standard for sample application repository names.
  aliases: [sample app names]
  type: standard
  strength: Team default
  source: standards/common-development/git/repository/naming-schemes/platform-sample-applications.md
- id: standard.tool-version-pinning
  title: Pin the tools a repository requires
  summary: Standard for pinning repository tool versions.
  aliases: [tool versions]
  type: standard
  strength: Team default
  source: standards/common-development/tool-versions.md
- id: standard.semantic-versioning
  title: Version published modules semantically
  summary: Standard for semantic versioning of published modules.
  aliases: [semver]
  type: standard
  strength: Team default
  source: standards/common-development/versioning/README.md
- id: standard.confirming-a-claim
  title: Confirm a claim with a check that would fail
  summary: Standard for validating claims with falsifiable checks.
  aliases: [verify claims]
  type: standard
  strength: Team default
  source: standards/confirming-a-claim.md
- id: standard.documentation-ownership
  title: Keep procedures in the repository that owns them
  summary: Standard for where procedures and usage details must live.
  aliases: [documentation ownership]
  type: standard
  strength: Team default
  source: standards/documentation-ownership.md
- id: standard.exclusive-and-shared-services
  title: Put an exclusive service with its consumer and a shared service in one repository
  summary: Standard for exclusive versus shared Terraform service boundaries.
  aliases: [exclusive shared services]
  type: standard
  strength: Team default
  source: standards/terraform/exclusive-and-shared-services.md
- id: standard.terraform-module-contract
  title: Hold shared Terraform modules to one contract
  summary: Standard for the shared Terraform module contract.
  aliases: [module contract]
  type: standard
  strength: Team default
  source: standards/terraform/modules/README.md
- id: standard.terraform-module-collection
  title: Compose primitives into a collection
  summary: Standard for Terraform collection modules.
  aliases: [collection module]
  type: standard
  strength: Team default
  source: standards/terraform/modules/collection.md
  former_paths:
    - standards/iac-development/terraform/module/collection/README.md
- id: standard.terraform-module-library
  title: Use a library module to transform inputs into shared outputs
  summary: Standard for Terraform library modules.
  aliases: [library module]
  type: standard
  strength: Team default
  source: standards/terraform/modules/library.md
  former_paths:
    - standards/iac-development/terraform/module/library/README.md
- id: standard.terraform-module-primitive
  title: Build a primitive around one resource type
  summary: Standard for Terraform primitive modules around one resource type.
  aliases: [primitive module]
  type: standard
  strength: Team default
  source: standards/terraform/modules/primitive.md
  former_paths:
    - standards/iac-development/terraform/module/primitive/README.md
- id: standard.terraform-module-reference-architecture
  title: Publish a reference architecture as one deployable environment
  summary: Standard for Terraform reference architecture modules.
  aliases: [reference architecture module]
  type: standard
  strength: Team default
  source: standards/terraform/modules/reference-architecture.md
  former_paths:
    - standards/iac-development/terraform/module/reference-architecture/README.md
- id: standard.terragrunt-orchestration
  title: Use Terragrunt to orchestrate Terraform across environments and regions
  summary: Standard for orchestrating Terraform with Terragrunt.
  aliases: [terragrunt]
  type: standard
  strength: Team default
  source: standards/terraform/terragrunt.md
- id: standard.terraform-testing
  title: Test the behavior a module claims
  summary: Standard for Terraform module behavior testing.
  aliases: [module testing]
  type: standard
  strength: Team default
  source: standards/terraform/testing.md
- id: standard.version-compatibility
  title: Show that the declared version floor works
  summary: Standard for proving declared version floor compatibility.
  aliases: [version floor]
  type: standard
  strength: Team default
  source: standards/terraform/version-compatibility.md
- id: strategy.repository-topology
  title: Repository topology
  summary: Trade-off guide for repository topology decisions and default.
  aliases: [poly-git]
  type: knowledge-base
  strength: Context-dependent choice. The team default is labeled below.
  source: strategies/poly-git-repo-strategy.md
```
