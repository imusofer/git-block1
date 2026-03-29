import sys

if len(sys.argv) != 2:
    print("Usage: Please provide a lab or repo name")
    sys.exit(1)

repo_name = sys.argv[1]
project_name = "Git Block 1 Lab"
language = "Python"
current_status = "Learning arguments"

print(f"Project: {project_name}\nRepo: {repo_name}\n{language} Block 1 is active\nLanguage: {language}\nStatus: {current_status}")