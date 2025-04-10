# MathCompiler: Compiler-Based Scientific Calculator with Advanced Function Support.
---
## Project Description
A simple scientific calculator implemented using compiler construction techniques. Built with Flex for lexical analysis and Bison for parsing, this project demonstrates how compiler theory can be applied to create a practical mathematical expression evaluator.

## Features

- Basic arithmetic operations (addition, subtraction, multiplication, division) ✅
- Proper operator precedence and parentheses support ✅
- Floating-point number handling ✅
- Advanced mathematical functions (planned):   (not implemented yet) 

  * Trigonometric functions (sin, cos, tan)
  * Logarithmic functions
  * Exponential operations
  * Constants (π, e)

## Run Locally
### Prerequisites:
Ensure that you have **Bison** and **Flex** installed on your system. If not, follow the steps below for installation (specific to Ubuntu. If U are using Windows, you can suck you D).
#### Open terminal by `Ctrl+Alt+t`
#### Installing Bison and Flex (if not installed):
```bash
sudo apt update && sudo apt upgrade -y
sudo apt-get install bison flex
```

#### Clone the project:

```bash
  git clone https://github.com/MahirTanzim/MathCompiler.git
```

#### Go to the project directory:

```bash
  cd Syntax-Directed-Translator
```

#### Run Flex file:

```bash
  flex calc.l
```
This will create a .c file named `lex.yy.c`.
#### Run Bison File:

```bash
  bison -d -t calc.y
```
This will create two files, `parser.tab.c` and `parser.tab.h`.

#### Compile `lex.yy.c` and `parser.tab.c`:
```bash
  gcc gcc lex.yy.c parser.tab.c -o calc.out -lm
```
After that, an executable file named `sdt.out` will be created. (You may see some warnings. Ignore them)

#### Executing the program:
```bash
  ./calc.out
```



