# Deliver Kubernetes workloads with Helm and Argo CD

**Status:** Exploring
**Owner:** Launch by NTT DATA Platform Engineering team
**Last reviewed:** 2026-10-22

## Problem or opportunity

Application teams deploy workloads to Kubernetes without a platform path that says how the package is built, how it is applied, and how the cluster is brought back to the reviewed desired state. The knowledge base has had Helm chart notes since 2024. Those notes were never tied to a reconciler, and they were never shown to be the path engagements use. Teams that need Kubernetes delivery still have to invent the package and the deployment step.

## Current hypothesis

Helm is the package. Argo CD is the reconciler. A chart is built and versioned as an artifact. Argo CD applies that artifact to the cluster and keeps the running state aligned with the reviewed desired state. Drift is corrected by the reconciler, not by an edit in the cluster.

The 2024 notes proposed three chart kinds. This idea carries them forward as candidates, not as requirements. A library chart holds reusable templates and deploys nothing by itself. A deployment chart deploys one workload shape and can be rendered on its own. An umbrella chart is the application entry point: a `Chart.yaml` and a `values.yaml` that depend on deployment charts. An umbrella chart does not depend on a library chart directly. Deployment charts do not depend on sibling charts for values they need at render time.

A Helm chart repository, if one is created, is named with the [infrastructure naming scheme](../standards/common-development/git/repository/naming-schemes/iac-repository-names.md), using the type `chart_library`, `chart_deployment`, or `chart_umbrella`. The name does not make Helm a supported path.

## Why this may be worth pursuing

Engagements already meet Kubernetes, and [Deliver software through an evidence chain](../practices/trustworthy-software-delivery.md) requires an immutable artifact and a controlled deployment. A chart plus a reconciler is one way to meet that requirement without editing a running workload. A single supported path would also stop each engagement from choosing a different package format and a different way to apply it.

## Trade-offs and open questions

- Argo CD is a product choice. Another reconciler could apply the same charts. The idea is not a decision that Argo CD is the only tool the team will operate.
- A reconciler that applies Git continuously can bypass the evidence chain if the Git state is not the reviewed artifact. The path has to say which repository Argo CD watches and how a promoted artifact gets there.
- The 2024 notes also named `helm lint`, `yamllint`, `kubeconform`, and `helm-docs`. Those tools are candidates for the checks. They are not required by this idea.
- Who operates the cluster, the Argo CD project, and the chart repositories is not decided. The platform team should not become the owner of every application chart.
- The older Helm pages under `standards/helm-development/` are pointers to this idea. They are not a current standard.

## Evidence or experiments needed

- One reference application whose chart is built once, versioned, and applied by Argo CD to a non-production cluster.
- A written account of how the promoted artifact becomes the desired state Argo CD watches, and how a bad release is reverted.
- A list of the checks that fail when the chart is wrong, run on that reference application.
- A statement of what the application team owns and what the platform team owns.

## Promotion or abandonment criteria

Promote this idea when the evidence above exists and a standards page can state the chart contract, the reconciler, and the ownership split without pointing back to this page for a requirement. Promotion follows the process in [Promote a new idea into active guidance](../promoting-an-idea.md).

Abandon this idea when the team records a different supported Kubernetes delivery path, or when a review finds that the evidence still does not exist and no engagement is waiting on the platform team for it. Record the reason on this page, and leave the pointer pages under `standards/helm-development/` stating that Helm is not a current standard.
