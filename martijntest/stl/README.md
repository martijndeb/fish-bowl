HumboldtJS Standard Library
===========================

## The project
This Standard Library is a set of (mostly) decoupled classes providing standard reusable functionality for HumboldtJS. Examples include the simple caching proxy object ObjectStore and the html/xml based templating engine.

## Dependencies
The library heavily depends on the PureMVC for HumboldtJS port, and as such you should also tell the humboldtjs.jar to link against the PureMVC library.

## Setting up your HumboldtJS project
1. Check out the Empty project from the HumboldtJS repository (https://github.com/humboldtjs/HumboldtJSEmpty). Alternatively set a project up from scratch.
2. Create a folder stl and check out the com folder from the STL (https://github.com/sexybiggetje/humboldtjs-stl/tree/master/com). Alternatively you might grab this folder from the tarball.
3. Add the stl folder to your source lookup path, and add the include flag to your humboldtjs.jar call. (Don't forget to include the PureMVC.swc from the HumboldtJS Empty Project).

```xml
<java jar="bin/humboldtjs.jar" fork="true">
	<arg value="-basedir"/>
	<arg value="../src"/>
	<arg value="-debug"/>
	<arg value="-I"/>
	<arg value="../stl"/> <!-- Link to the STL as source -->
	<arg value="-L"/>
	<arg value="../lib/HumboldtJSLibrary.swc"/> <!-- Link the HumboldtJS Core Library -->
	<arg value="-L"/>
	<arg value="../lib/PureMVC.swc"/> <!-- Link PureMVC for HumboldtJS -->
	<arg value="-o"/>
	<arg value="../bin-debug"/>
	<arg value="myTestProject.as"/>
</java>
```
4. Look at the wiki for information on how to use the templating system, so you can decouple your view.

## Roadmap
* A .swc version for major/minor releases.
* Example code in the wiki. For now refer to in class documentation.