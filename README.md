# C-plus-plus-Compiler-Semester-Project

- Code for Lexical Phase is in [lexer.l](lexer.l)
- Code for Syntax  Phase is in [parser.y](parser.y)
- [input.c](input.c) contains the input passed to the Program to validate

Following Commands are used to run above files:
```
flex lexer.l            #this will produce lex.yy.c
bison -dy parser.y      #this will produce y.tab.c
gcc lex.yy.c y.tab.c    #this will produce 'a' executable file 
.\\a                    #this will show the output results
```

Cheers!

---
