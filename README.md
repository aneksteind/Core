#Core

*This compiler is based on the book [Implementing Functional Languages: A Tutorial](http://research.microsoft.com/en-us/um/people/simonpj/Papers/pj-lester-book/) by Simon Peyton Jones and David Lester.*

As of this commit, the way to run this program is as follows:
```
stack build  
stack exec core-compiler [file] -- OR
stack exec core-compiler run-steps [file]
```
The option ```run-steps``` will print out each step the G-Machine makes in evaluating the program, to help the user learn how it works.

As the project currently stands, anyone who wants to create a simple functional language can do so by parsing it into the Core Expression AST found in this project. 

When the project is ready, I will export a library to hackage that will sort of streamline the process of linking to the core compiler, sort of like connecting to LLVM IR in the llvm-general package.

##About the Project

The Core language is a simple functional language that many other functional languages (such as Haskell) can be compiled to. In the book, as well as in this implementation, Core is compiled to G-Code (which can be further translated into C or machine code), and later interpreted by the G-Machine. The grammar of Core in this implementation is ever so slightly different than what is in the book (for readability), but it had no affects on the compiler itself.

This project was meant to introduce me to the world of compilers as well as state transition and stack machines. I believe that it was a great next step after the [interpreter](https://github.com/aneksteind/Shkeem) that I implemented earlier and before writing a compiler that targets the machine itself. 

This project will be updated here and there to improve efficiency (there are many places where this can and will be done), readability, error handling, and abstraction. **_As such, this is still a work in progress._**

The project itself is broken into the following series of steps:  
- Lexing (using Alex)
- Parsing (using Happy)
- Compilation to initial G-Code
- Evaluation by the G-Machine
  
## To Do
- implement better parse error handling in Alex/Happy
- implement lambda lifting
- possibly implement GmState as a State monad
- implement the stack project as a library
- generate documentation on Haddock
- upload to Hackage

More information will be added soon ...

    
