# MathCompiler: Compiler-Based Scientific Calculator with Advanced Function Support.
---
## Project Description
A simple scientific calculator implemented using compiler construction techniques. Built with Flex for lexical analysis and Bison for parsing, this project demonstrates how compiler theory can be applied to create a practical mathematical expression evaluator.



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
cd MathCompiler
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
This will create two files, `calc.tab.c` and `calc.tab.h`.

#### Compile `lex.yy.c` and `calc.tab.c`:
```bash
gcc lex.yy.c calc.tab.c -o calc.out -lm
```
After that, an executable file named `calc.out` will be created. (You may see some warnings. Ignore them)

#### Executing the program:
```bash
  ./calc.out
```



