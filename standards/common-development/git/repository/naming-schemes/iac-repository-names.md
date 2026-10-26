# Name infrastructure repositories by tool, provider, and name

**Strength:** Team default

## The problem

A repository name is how another engineer finds the module and how a caller sees what contract they are taking. Names that differ in order, case, or separator hide modules that already exist. A second module is then written for a resource the platform already publishes.

## The position

An infrastructure repository name is lowercase ASCII. Hyphens separate the fields. The required order is the tool, the provider, and then the name of the contract:

```text
tool-provider-name
```

GitHub treats repository names as case-insensitive, so two casings of the same name are the same repository. Underscores separate words inside a field.

That hyphen pattern is the standard. The rest of this page is guidance. It shows how to keep a new name consistent with repositories that already exist, and how to keep one contract from being mistaken for another. It does not limit which tools, providers, or name tokens a repository may use.

Existing repositories usually split the name into a type and a resource, which reads `tool-provider-type-resource`. A new repository follows that split when the repositories beside it do. Because the [single-purpose repository](../../../../../principles/single-purpose-repository-principle.md) principle gives each repository one lifecycle, a second contract needs a second repository and a second name.

The name does not decide which tools the team supports. Helm chart repositories that already exist use this pattern. Helm is not a standard. It remains a [new idea](../../../../../new-ideas/helm-and-argocd.md).

## What the team expects

**Tool.** Start with the short name neighboring repositories use for that tool. `tf` is Terraform. `tg` is Terragrunt. `helm` is Helm.

**Provider.** Use the provider token neighboring repositories use for that target. Examples include `aws`, `azurerm`, `sumologic`, and `launch`. `launch` is for a module with no cloud affinity, including a library module used on more than one cloud. `k8s` appears on Helm charts written for any Kubernetes provider.

When a module spans a cloud and a vendor, existing names put the cloud in the provider field and the vendor in the name. `tf-aws-module_reference-sumologic_observability` is the form.

**Name.** Prefer the type and resource split when that is how the related repositories are named. Terraform names that already exist use `module_primitive`, `module_library`, `module_collection`, and `module_reference`. A collection was previously called a wrapper. Use `module_collection` so the name matches current repositories. Helm chart names that already exist use tokens such as `chart_library`, `chart_deployment`, and `chart_umbrella`. Those tokens do not make Helm a standard. Words inside the name are separated with underscores. `s3_bucket` and `key_vault` are resource words. `sumologic_observability` is a name that carries both a vendor and a purpose.

**Examples.**

- `tf-aws-module_primitive-s3_bucket` is one Amazon S3 bucket and no other resource.
- `tf-launch-module_library-resource_name` transforms naming inputs into names. It creates no infrastructure. `launch` is the provider because the module is not tied to one cloud.
- `tf-aws-module_collection-activemq_broker` groups the primitives and library modules that operate an ActiveMQ broker. It does not redeclare those resources.
- `tf-aws-module_reference-sumologic_observability` names a deployable observability environment. The provider field is `aws`. The name carries the vendor and the purpose.

## Where implementation details live

A new repository for a primitive, a collection, a reference architecture, or a library is created from the shared skeleton. The team's generator performs that creation. The creation steps are in the private repository `launch-terraform-modules`. A reader outside the organization does not need those steps. Once the repository exists, the public skeleton's [collection-module skill](https://github.com/launchbynttdata/launch-terraform-skeleton/blob/main/template/.agents/skills/collection-module/SKILL.md) is the instruction for building a collection module. The module type pages define what each type contains: [primitive](../../../../terraform/modules/primitive.md), [library](../../../../terraform/modules/library.md), [collection](../../../../terraform/modules/collection.md), and [reference architecture](../../../../terraform/modules/reference-architecture.md).

[Repository names](../naming-schemes.md)
