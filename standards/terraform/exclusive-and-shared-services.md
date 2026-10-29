# Put an exclusive service with its consumer and a shared service in one repository

**Strength:** Team default

## The problem

A service with one consumer and a service with many consumers fail in different ways when the repository boundary is wrong. The single consumer cannot converge its own state, because the means to do that live somewhere else. Each additional consumer of a shared service writes a second copy, and those copies drift.

## The position

A service is exclusive when it has one consumer. The repository that contains that consumer also contains what is required to converge the service to the desired state. A person can bring that service to the desired state from that repository.

A service is shared when more than one consumer uses it, or will use it. One repository describes that service, and that repository has one purpose, as the [single-purpose repository](../../principles/single-purpose-repository-principle.md) principle requires. The repository states what the service provides and what a consumer must supply. The shared service's responsibility ends when the service is up and available to consume. A consumer confirms that the shared service is ready and uses it. The consumer's repository does not contain a second implementation of that service.

Both kinds of service can be delivered from the repository that owns them, as [self-contained repository delivery](../../principles/self-contained-repository-deployment-principle.md) describes.

The provider-fork procedure that used to accompany this distinction is historical. It is not part of this standard.

## What the team expects

- When a service has one consumer, keep the means to converge its state in that consumer's repository.
- When a service has more than one consumer, describe it in one repository. State what it provides and what a consumer must supply.
- Stop the shared service's responsibility at availability for consumption. A consumer verifies readiness and does not implement the shared service again.

## Where implementation details live

The service repository holds its configuration and the checks that show the service is ready. Shared modules that the service calls follow [Hold shared Terraform modules to one contract](modules/README.md). The previous strategy page is archived at [archive/pre-refresh/standards/iac-development/README.md](../../archive/pre-refresh/standards/iac-development/README.md). It is not this standard.

[Standards](../README.md)
