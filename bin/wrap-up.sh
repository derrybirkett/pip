#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

check_file(){
  local file="$1"
  if [[ ! -s "$file" ]]; then
    echo "[WARN] $file is missing or empty. Update docs before wrapping up." >&2
  fi
}

echo "=== Wrap-Up Checklist ==="
check_file "$ROOT_DIR/docs/processes/wrap-up-checklist.md"
check_file "$ROOT_DIR/docs/activity-log.md"
check_file "$ROOT_DIR/docs/changelog.md"
echo "Review \"docs/processes/wrap-up-checklist.md\" and ensure every step is complete."

read -rp "Have you updated activity log and changelog? [y/N] " confirm_docs
if [[ ! "$confirm_docs" =~ ^[Yy]$ ]]; then
  echo "Please update docs before wrapping up." >&2
  exit 1
fi

echo "=== Git Status ==="
( cd "$ROOT_DIR" && git status -sb )

read -rp "Enter commit message (leave blank to cancel): " commit_msg
if [[ -z "$commit_msg" ]]; then
  echo "Commit cancelled." >&2
  exit 1
fi

cd "$ROOT_DIR"
git add -A
git commit -m "$commit_msg"

read -rp "Tag release? (e.g., v0.4.0) [leave blank to skip]: " tag_name
if [[ -n "$tag_name" ]]; then
  read -rp "Tag description: " tag_msg
  git tag -a "$tag_name" -m "$tag_msg"
fi

git push
if [[ -n "${tag_name:-}" ]]; then
  git push origin "$tag_name"
fi

echo "Wrap-up complete."
