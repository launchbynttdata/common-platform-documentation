# Deliver Kubernetes workloads with Helm and Argo CD

**Status:** Exploring
**Owner:** Launch by NTT DATA Platform Engineering team

## Problem or opportunity

Application teams deploy workloads to Kubernetes without a platform path that says how the package is built, how it is applied, and how the cluster is brought back to the reviewed desired state. The 2024 Helm notes describe chart kinds, versioning, and the tools used to check a chart. They do not name a reconciler, and they were not shown to be the path engagements use. Teams that need Kubernetes delivery still have to invent the deployment step.

## Current hypothesis

Helm with Argo CD is the next evolution of that Helm work, and it is the latest suggestion the team is exploring. The 2024 notes did not include Argo CD. The team is now suggesting that Helm remain the package and that Argo CD be the reconciler: a chart is built and versioned as an artifact, Argo CD applies that artifact, and Argo CD keeps the running state aligned with the reviewed desired state. Drift is corrected by the reconciler, not by an edit in the cluster. This is a suggestion to test. It is not a decision that the team already operates this path.

The 2024 notes proposed three chart kinds. This idea carries them forward as candidates, not as requirements. A library chart holds reusable templates and deploys nothing by itself. A deployment chart deploys one workload shape and can be rendered on its own. An umbrella chart is the application entry point: a `Chart.yaml` and a `values.yaml` that depend on deployment charts. An umbrella chart does not depend on a library chart directly. Deployment charts do not depend on sibling charts for values they need at render time.

Helm chart repositories that already exist are named with the [infrastructure naming scheme](../standards/common-development/git/repository/naming-schemes/iac-repository-names.md). Some of those names use `chart_library`, `chart_deployment`, or `chart_umbrella`. Those names do not make Helm a standard. This page is still a proposal.

## Why this may be worth pursuing

Engagements already meet Kubernetes, and [Deliver software through an evidence chain](../practices/trustworthy-software-delivery.md) requires an immutable artifact and a controlled deployment. A chart plus a reconciler is one way to meet that requirement without editing a running workload. A single supported path would also stop each engagement from choosing a different package format and a different way to apply it.

## Trade-offs and open questions

- Argo CD is a product choice. Another reconciler could apply the same charts. The idea is not a decision that Argo CD is the only tool the team will operate.
- A reconciler that applies Git continuously can bypass the evidence chain if the Git state is not the reviewed artifact. The path has to say which repository Argo CD watches and how a promoted artifact gets there.
- The 2024 notes also named `helm lint`, `yamllint`, `kubeconform`, and `helm-docs`. Those tools are candidates for the checks. They are not required by this idea.
- Who operates the cluster, the Argo CD project, and the chart repositories is not decided. The platform team should not become the owner of every application chart.
- The 2024 Helm notes are archived and are not a current standard. The addresses under `standards/helm-development/` now point here. The archived notes are [Helm chart tools and practices](../archive/pre-refresh/standards/helm-development/README.md), [Helm deployment charts](../archive/pre-refresh/standards/helm-development/charts/deployment/README.md), [Helm library charts](../archive/pre-refresh/standards/helm-development/charts/library/README.md), and [Helm chart helpers](../archive/pre-refresh/standards/helm-development/helpers/README.md).

## Evidence or experiments needed

- One reference application whose chart is built once, versioned, and applied by Argo CD to a non-production cluster.
- A written account of how the promoted artifact becomes the desired state Argo CD watches, and how a bad release is reverted.
- A list of the checks that fail when the chart is wrong, run on that reference application.
- A statement of what the application team owns and what the platform team owns.

## Promotion or abandonment criteria

Promote this idea when the evidence above exists and a standards page can state the chart contract, the reconciler, and the ownership split without pointing back to this page for a requirement. Promotion follows the process in [Promote a new idea into active guidance](../promoting-an-idea.md).

Abandon this idea when the team records a different supported Kubernetes delivery path, or when a review finds that the evidence still does not exist and no engagement is waiting on the platform team for it. Record the reason on this page, and leave the pointer pages under `standards/helm-development/` stating that Helm is not a current standard.
