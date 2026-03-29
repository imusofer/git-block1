import sys

if len(sys.argv) != 2:
    print("Usage: Please provide a status")
    sys.exit(1)

status = sys.argv[1]

if status == "learning":
    print("Learning mode")
elif status == "review":
    print("Review mode")
else:
    print("Unknown status")
    sys.exit(1)

project_name = "Git Block 1 Lab"
language = "Python"
current_status = status

print(f"Project: {project_name}\n{language} Block 1 is active\nLanguage: {language}\nStatus: {current_status}")