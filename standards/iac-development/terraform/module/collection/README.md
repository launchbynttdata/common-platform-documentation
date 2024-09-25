# Collection Module

A collection module is a module that wraps modules together to provide a higher-order construct for consumption by other collection modules or reference architectures.

Collection modules consume primitive modules (and/or other collections) and provide a convenient interface for bundling a set of resources together in a consistent fashion. In practice, these modules end up looking very similar to reference modules, but collections are not intended to be independently-deployable and should defer decisions like naming to a higher-order module that imports it.
