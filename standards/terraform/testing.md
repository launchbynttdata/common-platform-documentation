# Test the behavior a module claims

**Strength:** Team default

## The problem

A test that only checks that the provider accepted a call will pass when the resource is created wrong. A plan that shows the intended change will pass when the applied result is different. A test that never destroys what it created leaves the next run, and the next team, with infrastructure nobody owns.

## The position

The functional test applies the module and then destroys it. Between those two steps it asserts the behavior the contract claims. For a data store, that includes the encryption and network limits the documented usage promises. For a library module, the assertions cover representative input-to-output transformations, and the test does not provision cloud resources. A passing test that does not check the claimed behavior does not confirm that behavior, which is the general rule in [Confirm a claim with a check that would fail](../confirming-a-claim.md).

A read-only check is a second suite, not a substitute. It runs against infrastructure that already exists and proves that a composition still fits that infrastructure. It does not replace the apply-and-destroy test of the module's own contract.

The tests live with the module and run from the repository. A result that depends on a step remembered by one engineer is not a test the next change can rely on.

## What the team expects

- Apply the module, assert the configured behavior, and destroy it in the functional test.
- Assert the promise the contract makes. Do not stop at the provider returning an identifier.
- For a library module, assert representative input-to-output transformations without provisioning cloud resources.
- Use a read-only check for composition against existing infrastructure, and keep the apply-and-destroy test as well.
- Keep the test command, the inputs, and the expected behavior in the module repository.

## Where implementation details live

The module repository holds the test files and the command that runs them. The pipeline that runs those tests is the workflow repository that the module already calls. This page does not name a test framework. [Hold shared Terraform modules to one contract](modules/README.md) is the contract these tests confirm.

[Standards](../README.md)
