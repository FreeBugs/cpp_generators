## cpp_generators

Illustrates a simple approach an how to deal with generating 
code at build time using `add_custom_command`. This solution
also deals with the problem that generated files may be used
by multiple targets (`add_library` in this case) by excluding
already generated files from the list of generated files with
the help of a parent scope (global) list. 

## License
The Fair License