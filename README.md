# Git Block 1 Lab

## Purpose
- Practice core Git fundamentals
- Understand file states and commit flow
- Build cleaner repo habits
- Understand CI/CD practices by creating a GitHub Actions workflow
- Practice repo quality cleanup habits
- Practice Python automation scripting
- Practice building a Docker image and running a Docker container
- Practice building a Kubernetes Deployment Pod manifest

## Contents
- notes.txt
- readme.txt
- .gitignore
- README.md
- keep.log
- .github/workflows/repo-check.yml
- scripts/script.sh
- scripts/py-block1.py
- scripts/py-block2.py
- Dockerfile
- data/statuses.txt
- .dockerignore
- k8s/py-block2-pod.yaml

## What I Practiced
- git init
- git status
- git add
- git commit
- git log
- .gitignore behavior
- forced add of an ignored file to make Git track it
- git tag
- git diff
- git diff --staged
- git branch
- git switch
- Python variables
- Python strings
- Python f-strings
- Create a basic Python repo script
- One argument with multiple valid values
- Python for loops
- Python lists
- Python range()
- Python len()
- Python with open()
- Python line.strip()
- Dockerfile basics
- docker build -t
- docker run --rm
- Containerizing a Python script
- .dockerignore structure and behavior
- Kubernetes Deployment yaml file structure and behavior

## Manual Validation
- Checked repo state with git status
- Checked commit history with git log
- Verified ignore behavior with .gitignore
- Verified tracked vs ignored behavior with keep.log
- Verified added tag to a commit
- Verified changes before and after staging
- Verified current directory, repo files and README.md contents
- Verified README, .gitignore and workflow exist
- Verified README contains project heading
- Verified repo docs and file quality
- Verified documentation accuracy
- Verified Python script functionality
- Verified second Python script reads statuses from file
- Verified containerized Python script runs successfully and prints the expected output
- Verified Docker image builds successfully
- Verified Docker runs the containerized script successfully

## Next Automation Step
- Validate Kubernetes Deployment successfully deploys Pods as described 
