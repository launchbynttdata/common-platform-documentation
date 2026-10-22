# Evolutionary database changes

**Strength:** Team default

This page stays at its existing address because other documents link to it. The delivery practice is [Deliver software through an evidence chain](../../../practices/trustworthy-software-delivery.md). [Martin Fowler's evolutionary database design](https://www.martinfowler.com/articles/evodb.html) is a longer discussion of the technique.

## The problem

An application package can be replaced with a new immutable version. A database that already holds data usually cannot. A schema change that only the new application understands will break the previous application version. A change that destroys or rewrites data cannot be undone by routing users back to the old application.

## The position

Change the schema in small, compatible steps, and store those steps in version control next to the application change they support. Apply them through the same reviewed delivery path as other changes.

A compatible step is one that the current application version and the next one can both run against. Expanding the schema first, moving readers and writers, and only then removing the old shape is the usual order. That order lets the team deploy the application and the schema at different moments and still return to the previous application version if needed.

The migration is code. It is reviewed, applied by automation so each environment runs the same steps, and checked for data integrity afterward. A migration that rewrites data needs a stated recovery path before it is applied to a shared environment.

## What the team expects

- Store schema changes as versioned migrations, not as an unrecorded manual edit.
- Keep each step compatible with the application version that is still running.
- Apply migrations through the delivery path, in order, and record which version each environment has applied.
- Test that existing data still matches what the application expects after the migration.
- Separate a data rewrite from a purely additive schema change, and name how the rewrite would be recovered.

## Where implementation details live

The migration tool and the scripts live in the application repository that owns the data. This page does not require a particular database product.

[Practices](../../../practices/README.md)
