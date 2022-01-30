#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3
import argparse
from functools import partial
from multiprocessing.dummy import Pool
from os import mkdir, path, walk
from subprocess import call
from typing import List


def find_ttfs(directory: str) -> List[str]:
    ttfs = []
    for root, dirs, files in walk(directory):
        for file in files:
            if file.endswith(".ttf"):
                ttfs.append(path.join(root, file))
    return ttfs


def get_ttf_command(input: str, output: str) -> str:
    return f'sh -c "cat \'{input}\' | ttf2woff2 > \'{output}/{path.splitext(path.basename(input))[0] + ".woff2"}\'"'


def convert_ttfs(inputs: List[str], output: str):
    commands = [get_ttf_command(input, output) for input in inputs]

    # https://stackoverflow.com/a/14533902, modified
    pool = Pool()
    for i, returncode in enumerate(pool.imap(partial(call, shell=True), commands)):
        text = f"{i+1}/{len(commands)+ 1}: {returncode} {commands[i]}"
        if returncode == 0:
            print(text)
        else:
            raise Exception(text)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", help="directory to scan for ttf files")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    ttfs = find_ttfs(args.input)
    output = "output"
    if not path.exists(output):
        mkdir(output)
    convert_ttfs(ttfs, output)


if __name__ == "__main__":
    main()
