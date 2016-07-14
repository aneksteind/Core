#Core
##A compiler for Core, implemented in Haskell.

This compiler is based on the book [*Implementing Functional Languages: A Tutorial*](http://research.microsoft.com/en-us/um/people/simonpj/Papers/pj-lester-book/) by Simon Peyton Jones and David Lester.

The Core language is a simple functional languages that many other functional languages can be compiled to. In the book, as well as in this implementation, Core is compiled to G-Code (which can be further translated into C or machine code), and later interpreted by the G-Machine. The grammar of Core in this implementation is ever so slightly different than what is in the book (for readability), but it had no affects on the compiler itself.

This project was meant to introduce me to the world of compiling as well as state transition and stack machines. I believe that it was a great next step after the [interpreter](https://github.com/aneksteind/Shkeem) that I implemented earlier. 

This project will be updated here and there to make improvements in efficiency (there are many places where this can and will be done) and readability as well as to abstract where appropriate. **_As such, this is still a work in progress._**

The project itself is broken into a series of steps:
Lexing(Alex) -> Parsing(Happy) -> Compiling(Compiler) -> Executing/Interpreting(GMachine)
