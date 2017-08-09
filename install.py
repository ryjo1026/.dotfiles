"""
Customized no-frills installer to automatically create symlinks from the cwd to the correct places.
Config in config.yml
"""

import filecmp
import yaml
import shutil
import time
import os
import subprocess


os.path.expanduser('~')

config = yaml.safe_load(open('config.yml'))

for service in config.itervalues():
    for key, dotfile in service.iteritems():
        source = os.getcwd()+dotfile['source']
        dest = os.path.expanduser('~')+"/"+dotfile['dest']

        # Create backup
        if not filecmp.cmp(dest, source, shallow=False):
            print "Files differ; creating backup"
            backupFolder = '{}/backup-{}/'.format(os.getcwd(), time.strftime("%Y%m%d-%H:%M:%S"))
            os.mkdir(backupFolder)
            shutil.copy2(dest, backupFolder)

        os.remove(dest)
        os.symlink(source, dest)
        print "Symlinked " + key
