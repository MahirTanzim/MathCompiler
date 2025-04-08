# Syntax-Directed Translator for Simple Mathematical Expressions

## Project Description

The **Syntax-Directed Translator for Simple Mathematical Expressions** is a tool that translates simple arithmetic expressions into a target representation, such as assembly-like instructions (3-address code). The translator takes expressions like `2 + 3 * 4` and processes them based on operator precedence and associativity. It will also print the value of the evaluated expression.

### Key Features:
- **Three-Address Code Generation** (Not Done)
- **Evaluation of Expressions** to calculate and print their value (Done)
- **Error Handling** (e.g., Division by Zero – Not Done)
- **Expression Parsing** including handling of parenthesis and floating point numbers (Not Done)
- **Support for Mathematical Operations** such as addition, subtraction, multiplication, and more (Power, Floating Point values, etc. – Not Done)

## How to Run the Code

### Prerequisites:
Ensure that you have **Bison** and **Flex** installed on your system. If not, follow the steps below for installation (specific to Ubuntu).

#### Installing Bison and Flex (if not installed):
```bash
sudo apt-get update
sudo apt-get install bison flex
