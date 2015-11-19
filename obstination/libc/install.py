#!/usr/bin/python

from os.path import join, dirname, islink, basename
from os import makedirs, readlink, symlink, remove
from shutil import copyfile, copymode
from sys import argv
import errno

def makedirs_no_eexist(path):
    """create a directory without exception in case it already exists"""
    try:
        makedirs(path)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise e

def remove_no_enoent(path):
    """remove a file without exception in case it doesn't exists"""
    try:
        remove(path)
    except OSError as e:
        if e.errno != errno.ENOENT:
            raise e

def main():
    # file to create
    dest = argv[1]
    # file to copy or link to recreate
    source = argv[2]
    dest_dir = dirname(dest)
    makedirs_no_eexist(dest_dir)

    if islink(source):
        target = source
        while islink(target):
            target = readlink(source)
	if basename(target) != basename(dest):
		remove_no_enoent(dest)
		symlink(basename(target), dest)
        src = join(dirname(source), target)
        dst = join(dest_dir, basename(target))
        remove_no_enoent(dst)
        copyfile(src, dst)
        copymode(src, dst);
    else:
        remove_no_enoent(dest)
        copyfile(source, dest)

if __name__ == "__main__":
    main()
