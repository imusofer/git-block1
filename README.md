# Git Block 1 Lab

## Purpose
- Practice core Git fundamentals
- Understand file states and commit flow
- Build cleaner repo habits
- Understand CI/CD practices by creating a GitHub Actions workflow
- Practice repo quality cleanup habits
- Practice Python automation scripting
- Practice building a Docker image and running a Docker container
- Practice building a Kubernetes Pod manifest
- Practice loading a Docker image to use for Kubernetes Pod manifest
- Practice running a Kubernetes Pod manifest from loaded Docker image
- Practice inspecting Pod status and history logs
- Practice inspecting cluster name
- Practice building a Kubernetes Deployment manifest
- Practice running a Kubernetes Deployment manifest
- Practice building and running a Kubernetes Job manifest
- Practice building and running a Kubernetes CronJob manifest
- Practice suspending and resuming a Kubernetes CronJob manifest
- Practice running a one-off Job from a suspended Kubernetes CronJob manifest
- Practice creating a failing Job and verify failure behavior
- Practice building a long-running Flask HTTP app with 4 route handlers

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
- k8s/py-block2-deployment.yaml
- k8s/py-block2-job.yaml
- k8s/py-block2-cronjob.yaml
- app/py-block3.py

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
- Kubernetes Pod YAML file structure and behavior
- kind get clusters
- Load Docker image into cluster - kind load docker-image <image-name> --name <cluster-name>
- Apply manifest from YAML file - kubectl apply -f <manifest-name>
- Check Pod status - kubectl get pod
- Check Deployment status - kubectl get deployments
- Inspect in depth information of the deployment - kubectl describe deployment <deployment-name>
- Inspect in-depth information of the pod - kubectl describe pod <pod-name>
- Inspect Pod logs - kubectl logs <pod-name>
- Delete deployments/jobs - kubectl delete job/deployment <deployment/job-name>
- Running a one-off Job from a suspended CronJob manifest - kubectl create job <manual-job-name> --from=cronjob/<cronjob-name>
- Python @app.route("")
- Python os.getenv()
- Python datetime.now(ZoneInfo()).isoformat()
- Python main guard - if __name__ == "__main__":

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
- Containerize a long-running HTTP web app
