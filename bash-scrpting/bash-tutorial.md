Here I jot down my learning path for the **Bash Scripting**.

Bash scripting refers to the practice of creating and running scripts written in the Bash (Bourne-Again Shell) programming language. Bash is a widely-used command-line interface and scripting language on Unix-like operating systems, including Linux and macOS. It provides a powerful way to automate tasks, manage files, and interact with the underlying operating system.

Here's a basic introduction to get you started with Bash scripting:

1. **What is Bash Scripting?**
   Bash scripting involves writing a series of commands in a plain text file (usually with a `.sh` extension) that can be executed as a single program. These scripts can automate repetitive tasks, perform system administration, manipulate files, and even create complex workflows.

2. **Creating a Bash Script:**
   To create a bash script, you'll need a text editor (like nano, vim, or even a graphical editor like VSCode). Start your script with a "shebang" or "hashbang" line, which tells the system which interpreter to use. The shebang line for Bash is usually:
   ```bash
   #!/bin/bash
   ```

3. **Writing Bash Commands:**
   After the shebang line, you can write any valid Bash command, just as you would in the terminal. For example:
   ```bash
   #!/bin/bash
   echo "Hello, World!"
   ```

4. **Running Bash Scripts:**
   To run a Bash script, make it executable using the `chmod` command:
   ```bash
   chmod +x your-script.sh
   ```
   Then, execute it by typing `./your-script.sh` in the terminal.

5. **Variables:**
   Bash supports variables to store and manipulate data. Variables are assigned without spaces around the equal sign:
   ```bash
   name="John"
   echo "Hello, $name!"
   ```

6. **Comments:**
   Comments in Bash scripts start with the `#` character. They are ignored by the interpreter and are used to provide explanations or notes:
   ```bash
   # This is a comment
   ```

7. **Control Structures:**
   Bash supports various control structures like `if` statements, `for` and `while` loops, and `case` statements to control the flow of your script:
   ```bash
   if [ "$variable" -eq 10 ]; then
       echo "Variable is 10"
   fi
   ```

8. **Functions:**
   You can define functions in Bash scripts to group related commands. Functions help organize your code and make it more modular:
   ```bash
   greet() {
       echo "Hello, $1!"
   }
   greet "Alice"
   ```

9. **Command-Line Arguments:**
   You can pass arguments to your Bash script when executing it. These arguments can be accessed using special variables like `$1`, `$2`, etc.:
   ```bash
   echo "First argument: $1"
   ```

10. **Exit Codes:**
    Bash scripts can return exit codes to indicate the success or failure of the script. `0` usually indicates success, and non-zero values indicate errors:
    ```bash
    exit 0  # Successful execution
    exit 1  # Error occurred
    ```

Remember that this is just a basic overview of Bash scripting. As you become more comfortable with the basics, you can explore more advanced topics like file handling, string manipulation, regular expressions, and more. Bash scripting can be incredibly powerful and useful for automating tasks and managing systems efficiently.

# More learning material

## Variables

* defining a variable with the subshell command:

```
#!/bin/bash

myName="Mostafa"
echo "Hello, my name is $myName"

files=$(ls)
echo $files
```

## Basic Math

```
a=300
b=100

expr $a + $b
expr $a - $b
expr $a / $b
expr $a \* 3
```