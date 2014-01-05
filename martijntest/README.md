HumboldtJS Empty Project
========================

## What is it?

HumboldtJS Empty Project is an empty stub project that you can clone and
start to create your own applications with. It already has everything setup
to work. Just rename that main Class name, and update that name in the
ant build scripts, and you are ready to build your own HumboldtJS applications.

## What do I do with it?

Clone the repository and import it into Flash Builder or your IDE of choice.
If you are using Flash Builder everything should already work out of the box
and you should have a building default application.

You can then change the main application class's name (be sure to update it
in the ant build script as well).

By default Flash Builder will already compile this to an .swf file. This
default compiler will do the compile-time checking of strict typing for example
and helps to already filter out a lot of possible errors.

After the default compiler has run you still need to run the ant build script
from the *build* folder. This will start the humboldtjs.jar compiler.

After running the ant build you should have a bunch of javascript files in your
bin-debug folder, and you should be able to run the application by opening
the HTML file.