# expr2tac-Syntax-Directed-Translator

# 🧮 Syntax-Directed Translator for Simple Mathematical Expressions

## 📖 Project Description

This project implements a **Syntax-Directed Translator (SDT)** for evaluating and translating simple arithmetic expressions using **Flex** and **Bison**.
https://github.com/MahirTanzim/expr2tac-Syntax-Directed-Translator/blob/main/README.md
Given an input expression such as `2 + 3 * 4`, the translator:

- Parses the expression considering **operator precedence** and **associativity**
- Evaluates and **prints the result** of the expression
- Translates the input into **assembly-like instructions (Three Address Code - TAC)** (to be implemented)

The goal is to simulate how a compiler frontend might generate intermediate representations during expression parsing.

---

## 🚀 How to Run the Project

### 1. Clone this Repository

```bash
git clone https://github.com/your-username/sdt-expression-parser.git
cd sdt-expression-parser
2. Open Terminal in the Project Folder
Make sure you're in the correct directory after cloning.

3. Compile and Run
Run the following commands to build and execute the project:

bash
Copy
Edit
flex lexer.l
bison -d parser.y
gcc expr.tab.c lex.yy.c -o sdt
./sdt
4. (Optional) Install Bison and Flex on Ubuntu
If bison or flex is not installed, run the following command:

bash
Copy
Edit
sudo apt update
sudo apt install bison flex
🔧 Project Progress & Features
Feature	Status
✅ Evaluate and display result of expression	Done
🛠️ Generate Three Address Code	Not Done
❌ Handle divide-by-zero gracefully	Not Done
❌ Support parentheses ( ) in expressions	Not Done
❌ Support for floating point numbers	Not Done
❌ Support for exponentiation (^)	Not Done
📝 Example
Input:

Copy
Edit
2 + 3 * 4
Expected Output:

makefile
Copy
Edit
Result = 14
Three Address Code:
t1 = 3 * 4
t2 = 2 + t1
(Note: Three Address Code generation is still pending implementation.)

📌 Future Enhancements
 Full TAC generation for complex expressions

 Better error handling (e.g., divide by zero)

 Add support for parentheses

 Floating-point and power operations

 Modularize the code and improve syntax tree visualization

👨‍💻 Author
Developed by [Your Name] — 4th Year CSE Student | Enthusiast in Compilers and Systems Programming
Feel free to fork, contribute, or raise issues!
