#!/bin/sh
# Runs on every container start and once from post-create.sh.
# Fixes ownership of the Claude volume only when needed.

dir=/home/vscode/.claude

if [ -d "$dir" ] && [ "$(stat -c %U "$dir")" != "vscode" ]; then
  echo "> Fixing ownership of $dir"
  sudo chown -R vscode:vscode "$dir"
fi
