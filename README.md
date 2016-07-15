#Core

*This compiler is based on the book [Implementing Functional Languages: A Tutorial](http://research.microsoft.com/en-us/um/people/simonpj/Papers/pj-lester-book/) by Simon Peyton Jones and David Lester.*

As of this commit, the way to run this program is as follows:
```
stack build  
stack exec core-compiler [file]
```


- I have included a quick script that will run all of the test programs in the folder provided.
- As the project currently stands, anyone who wants to create a simple functional language can do so by parsing it into the Core Expression AST found in this project. 

##About the Project

The Core language is a simple functional language that many other functional languages (such as Haskell) can be compiled to. In the book, as well as in this implementation, Core is compiled to G-Code (which can be further translated into C or machine code), and later interpreted by the G-Machine. The grammar of Core in this implementation is ever so slightly different than what is in the book (for readability), but it had no affects on the compiler itself.

This project was meant to introduce me to the world of compilers as well as state transition and stack machines. I believe that it was a great next step after the [interpreter](https://github.com/aneksteind/Shkeem) that I implemented earlier and before writing a compiler that targets the machine itself. 

This project will be updated here and there to improve efficiency (there are many places where this can and will be done), readability, and abstraction, as well as to make a proper package using stack. **_As such, this is still a work in progress._**

The project itself is broken into a series of steps:
Lexing(Alex) -> Parsing(Happy) -> Compiling(Compiler) -> Executing/Interpreting(GMachine)

    
