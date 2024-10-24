# Library Module

A library module is a helper module that does not deploy any resources on its own. Instead, it accepts some inputs, performs transformations on those inputs, and then outputs the results to be utilized by other Terraform modules.

The canonical example for the LCAF ecosystem is the [resource_name library](https://github.com/launchbynttdata/tf-launch-module_library-resource_name), that accepts a series of naming inputs and then generates many variants of a name in its outputs, which are then referenced by other modules. This allows us to provide consistent naming schemes across our ecosystem that are used in resource names and tags.
