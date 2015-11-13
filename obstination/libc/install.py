#!/usr/bin/python

from os.path import join, dirname, islink, basename
from os import makedirs, readlink, symlink
from shutil import copyfile
from sys import argv

def makedirs_no_eexist(path):
    """create a directory without exception in case it already exists"""
    try:
        makedirs(path)
    except OSError as e:
        if e.errno != 17:
            raise e

def main():
    # file to create
    dest = argv[1]
    # file to copy or link to recreate
    source = argv[2]
    dest_dir = dirname(dest)
    makedirs_no_eexist(dest_dir)

    if islink(source):
        target = readlink(source)
        copyfile(join(dirname(source), target), join(dest_dir,
				basename(target)))
        symlink(basename(target), dest)
    else:
        copyfile(source, dest)

if __name__ == "__main__":
    main()
