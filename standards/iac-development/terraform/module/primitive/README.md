# Primitive

A primitive module is a basic building block that is leveraged by higher-order (collection and reference architecture) modules.

Primitive modules should expose a single cloud resource where possible. This atomic approach allows engineers greater flexibility in composing collections and reference architectures. When primitive modules contain more than a single resource, we found that assumptions are usually baked into these modules that limit their utility in higher-order modules, so we avoid this pattern. Our ideal primitive module is composed of a single `resource` statement and perhaps some `data` blocks if necessary.

At a minimum, primitive modules should contain unit tests that validate they've been set up correctly and that the resource we expect to have deployed was deployed. Ideally, unit tests would expand to encompass further functionality checks, i.e. can you enqueue items into the queue you provisioned?

Historically, a few primitives exist that wrap existing third-party modules. If you're considering pulling in a third-party dependency into a primitive, first consider:

- Does the third-party dependency limit its scope to a single logical unit (e.g. Lambda function)?
- Is this third-party dependency actively maintained? Is there a community around this external module?
- Does the third-party dependency provide sufficient flexibility for consumption in collections and reference architectures?
- Does the third-party dependency provide assurances of functionality (tests)?

If the answer to all of the above is "yes" then you may have a candidate for wrapping a third-party module with a primitive module.
