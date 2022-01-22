# C-plus-plus-Compiler-Semester-Project

- [lexer.l](lexer.l) contains code for Lexical Phase 
- [parser.y](parser.y) contains code for Syntax Phase is in 
- [input.c](input.c) contains the input passed to the Program to validate

Following Commands are used to run above files:
```
flex lexer.l            #this will produce lex.yy.c
bison -dy parser.y      #this will produce y.tab.c
gcc lex.yy.c y.tab.c    #this will produce 'a' executable file 
.\\a                    #this will show the output results
```

Note:

> This Project only completes the follwings:
> - Implementation of Lexical analysis Phase
> - Implementation of Syntax analysis Phase
> - Implementation of Symbol table manager(Register variables)
> - Error report in case of error in some cases

> This Project does not completes the follwings:
> - Appling Semantic actions to evaluate data type, arithmetic and boolean expressions.
> - Error report at some points


Happy Coding ;)

---
