#!/bin/bash

if [ ! -e  README.md ]; then
  echo "README.md is missing"
  exit 1
fi

if [ ! -e .gitignore ]; then
    echo ".gitignore is missing"
    exit 1
fi

echo "Repo validation passed"
exit 0
