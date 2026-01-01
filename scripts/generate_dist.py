"""
This is not a module.


It is a script that I use across all my mods to generate distribution files.
The purpose is to exclude certain files and directories directly from the repository.
This reduces file size dramatically rather than including all of the files.

This `scripts` folder is symlinked to all of my mods locally.
This is why it appears that none of my mods have the scripts except this one.
"""

import os
import pathlib
import re
import shutil
import sys

EXCLUDED_PATTERNS = [
    r"^.+\.(?:blend1|psd)$",
]

EXCLUDED_DIRS = [".vscode"]

SCRIPT_PATH = pathlib.Path(__file__)
ROOT_PATH = SCRIPT_PATH.parent.parent


def copy_files(src: pathlib.Path, dest: pathlib.Path):
    for dirpath, _, filenames in src.walk():
        for excluded_dir in EXCLUDED_DIRS:
            if dirpath.match(excluded_dir):
                print("Matched excluded directory: ", excluded_dir)
                break
        else:  # No excluded directory found
            for filename in filenames:
                for pattern in EXCLUDED_PATTERNS:
                    if re.match(pattern, filename):
                        print("Matched excluded pattern: ", pattern)
                        break
                else:
                    src_file = dirpath.joinpath(filename)
                    dest_file = dest.joinpath(pathlib.Path(*src_file.relative_to(ROOT_PATH).parts[1:]))

                    print(f"Copying file {src_file} to {dest_file}")

                    if not dest_file.parent.exists():
                        dest_file.parent.mkdir(parents=True)

                    shutil.copy2(src_file, dest_file)


def main():
    """Main entry point."""

    src_path = ROOT_PATH.joinpath("src")
    dist_path = ROOT_PATH.joinpath("dist")
    workshop_path = ROOT_PATH.joinpath("workshop")

    # Get mod id for later use

    print("Getting mod id...")

    mod_id = None
    with open(src_path.joinpath("mod.info"), "r", encoding="utf-8") as modinfo:
        for line in modinfo.readlines():
            if line.startswith("id="):
                mod_id = line.removeprefix("id=").strip()
                break

    if mod_id is None:
        print("Failed to find mod ID in mod.info.")
        sys.exit(1)

    print("Generating dist files...")

    # Make dist folder (cleanup if it already exists)

    if dist_path.exists():
        for it in dist_path.iterdir():
            os.remove(it.absolute())
        dist_path.rmdir()
    dist_path.mkdir()

    # Create workshop folder tree

    contents = dist_path.joinpath("Contents")
    mods = contents.joinpath("mods")
    mod_path = mods.joinpath(mod_id)
    mod_path.mkdir(parents=True)

    copy_files(src_path, mod_path)
    copy_files(workshop_path, dist_path)

    print("Dist files generated successfully.")


if __name__ == "__main__":
    main()
