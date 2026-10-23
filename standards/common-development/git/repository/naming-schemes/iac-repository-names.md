# Name infrastructure repositories by tool, provider, type, and resource

**Strength:** Team default

## The problem

A repository name is how another engineer finds the module and how a caller sees what contract they are taking. Names that differ in order, case, or separator hide modules that already exist. A second module is then written for a resource the platform already publishes.

## The position

An infrastructure repository name has four fields in this order: tool, provider, type, and resource.

```text
tool-provider-type-resource
```

Names are lowercase ASCII. GitHub treats repository names as case-insensitive, so two casings of the same name are the same repository. Hyphens separate the fields. Underscores separate words inside a field. A compound tool, type, or resource is written in snake case.

A name identifies one tool, one provider, one module type, and one resource. Because the [single-purpose repository](../../../../../principles/single-purpose-repository-principle.md) principle gives each repository one lifecycle, a second contract needs a second repository and a second name.

The type field records the module kind. It does not, by itself, make a new kind supported. A Helm chart repository, if one is created, is named with this scheme. The name does not make Helm a supported path. Helm as a delivery path is a [new idea](../../../../../new-ideas/helm-and-argocd.md).

## What the team expects

**Tool.** Use the short name of the tool. `tf` is Terraform. `tg` is Terragrunt. `helm` is Helm.

**Provider.** Use the provider or vendor the repository targets. `aws`, `azurerm`, `gcp`, `oci`, and `sumologic` are the cloud and vendor names in use. `launch` is for a module with no cloud affinity, including a library module used on more than one cloud. `k8s` is for a Helm chart written for any Kubernetes provider.

When a module spans a cloud and a vendor, the provider field is the cloud. Put the vendor in the resource field. `tf-aws-module_reference-sumologic_observability` is the form.

**Type.** Use the type that matches the module page.

- Terraform: `module_primitive`, `module_library`, `module_collection`, and `module_reference`. A custom Terraform provider, if the team publishes one, uses `provider`.
- Helm, when a chart repository is named: `chart_library`, `chart_deployment`, and `chart_umbrella`.

`module_collection` is the type that was previously called a wrapper. Do not create new repositories with a wrapper type.

**Resource.** Use the provider's name for the resource when the module corresponds to one. `s3_bucket` and `key_vault` are resource fields. A reference architecture uses the provider's name plus any further specifier the architecture needs, such as `ecs_platform`. Words inside the resource field are separated with underscores.

**Examples.**

- `tf-aws-module_primitive-s3_bucket` is one Amazon S3 bucket and no other resource.
- `tf-launch-module_library-resource_name` transforms naming inputs into names. It creates no infrastructure. `launch` is the provider because the module is not tied to one cloud.
- `tf-aws-module_collection-activemq_broker` groups the primitives and library modules that operate an ActiveMQ broker. It does not redeclare those resources.
- `tf-aws-module_reference-sumologic_observability` is a deployable observability environment. The provider field is `aws`. The resource field carries the vendor and the purpose.

## Where implementation details live

New Terraform module repositories are created from the [module generator](https://github.com/launchbynttdata/launch-terraform-modules). The module type pages define what each type contains: [primitive](../../../../terraform/modules/primitive.md), [library](../../../../terraform/modules/library.md), [collection](../../../../terraform/modules/collection.md), and [reference architecture](../../../../terraform/modules/reference-architecture.md).

[Repository names](../naming-schemes.md)
