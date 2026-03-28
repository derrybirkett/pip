#!/usr/bin/env python3
"""Validate that local relative Markdown links resolve inside the repo."""

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[2]
LINK_RE = re.compile(r"(?<!\!)\[[^\]]+\]\(([^)]+)\)|!\[[^\]]*\]\(([^)]+)\)")
TOP_LEVEL_DOCS = {
    "README.md",
    "CONTRIBUTING.md",
    "AGENTS.md",
    "WARP.md",
    "ROADMAP.md",
    "fragment-prompt.md",
}


def should_scan(path: Path) -> bool:
    return path.suffix == ".md" or path.name in TOP_LEVEL_DOCS


def is_external(target: str) -> bool:
    return (
        "://" in target
        or target.startswith("#")
        or target.startswith("mailto:")
        or target.startswith("/")
    )


def iter_doc_paths() -> list[Path]:
    return sorted(
        path
        for path in REPO_ROOT.rglob("*")
        if path.is_file() and should_scan(path.relative_to(REPO_ROOT))
    )


def main() -> int:
    errors: list[str] = []

    for doc_path in iter_doc_paths():
        in_fence = False
        rel_doc_path = doc_path.relative_to(REPO_ROOT)

        with doc_path.open(encoding="utf-8") as handle:
            for lineno, line in enumerate(handle, 1):
                stripped = line.strip()
                if stripped.startswith("```"):
                    in_fence = not in_fence
                    continue
                if in_fence:
                    continue

                for match in LINK_RE.finditer(line):
                    raw_target = match.group(1) or match.group(2) or ""
                    target = raw_target.strip()
                    if is_external(target):
                        continue

                    target_path = target.split("#", 1)[0]
                    if not target_path:
                        continue

                    resolved = (doc_path.parent / target_path).resolve()
                    try:
                        resolved.relative_to(REPO_ROOT)
                    except ValueError:
                        errors.append(
                            f"{rel_doc_path}:{lineno}: link escapes repo root: {raw_target}"
                        )
                        continue

                    if not resolved.exists():
                        errors.append(
                            f"{rel_doc_path}:{lineno}: missing target {raw_target}"
                        )

    if errors:
        for error in errors:
            print(error)
        print(f"\nFound {len(errors)} broken relative link(s).")
        return 1

    print("All local relative Markdown links resolve.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
