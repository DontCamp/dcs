#!/usr/bin/env/python

import argparse
import os
import requests
import subprocess
import sys
from contextlib import closing
from subprocess import DEVNULL
from yaml import safe_load


# program info for help text
version = '0.1.1'
desc_text = 'DontCamp.com DCS skin package manager version {}'.format(version)
# CLI arguments
parser = argparse.ArgumentParser(description=desc_text)
parser.add_argument('-b', action='store_true',
                    help='Run in non-interactive batch mode')
args = parser.parse_args()
batch_mode = args.b


# inform the user if running in batch mode
if batch_mode is True:
    print('Executing in non-interactivate batch mode')


# attempt to get environment vars, if set
ENV_VARS = {'SKINDLE_SEVEN_ZIP': os.getenv('SEVEN_ZIP'),
            'SKINDLE_TEMP_DIR': os.getenv('TEMP_DIR'),
            'SKINDLE_SKIN_DIR': os.getenv('SKIN_DIR'),
            'SKINDLE_SKIN_DATA_URL': os.getenv('SKIN_DATA_URL')}


# default config if env vars are not set
DEF_CONFIG = {
    'SKINDLE_SEVEN_ZIP':
    os.path.join(os.getenv('PROGRAMFILES'), '7-Zip', '7z.exe'),
    'SKINDLE_TEMP_DIR':
    os.getenv('TEMP'),
    'SKINDLE_SKIN_DIR':
    os.path.join((os.getenv('USERPROFILE')), 'Saved Games', 'DCS', 'Liveries'),
    'SKINDLE_SKIN_DATA_URL':
    'https://raw.githubusercontent.com/DontCamp/dcs/master/configs/skins.yml'
}


# set global config based on existence of env vars
config = dict()
for key, value in ENV_VARS.items():
    if value:
        config[key] = os.getenv(key)
    else:
        config[key] = DEF_CONFIG[key]


# display current config
print('''Executing with configuration as follows:
(NOTE: these values may be overridden using environment variables)\n''')
for key, value in config.items():
    print(key, '{}'.format('='), value)
print('\n')


# confirm on exit to hold terminal window open
if batch_mode is False:
    input('Press ENTER to continue and install skins, or close this window to '
          'exit.\n')


# shorthand variables for cleanliness
SEVEN_ZIP = config['SKINDLE_SEVEN_ZIP']
TEMP_DIR = config['SKINDLE_TEMP_DIR']
SKIN_DIR = config['SKINDLE_SKIN_DIR']
SKIN_DATA_URL = config['SKINDLE_SKIN_DATA_URL']


# skin directory error handling
if not os.path.isdir(SKIN_DIR):
    print(f'ERROR: skin directory {SKIN_DIR} not found!')
    print('Is DCS installed?')
    input('Press ENTER to exit.')
    sys.exit()


# check for 7-zip installation
if not os.path.isfile(SEVEN_ZIP):
    print(f'ERROR: 7-Zip ({SEVEN_ZIP}) not found!')
    print('Ensure that 64-bit Z-Zip is installed from https://7-zip.org')
    input('Press ENTER to exit.')
    sys.exit()


# download skin list data YAML
print(f'Downloading skin list data from {SKIN_DATA_URL}\n')
with closing(requests.get(SKIN_DATA_URL)) as r:
    skin_data = safe_load(r.text)


# download and install skins
for skin in skin_data['skins']:
    # check for existing skin installation.
    # for archives with multiple skins, we only need to check for one of them
    if os.path.isdir(os.path.join(SKIN_DIR, skin['type'], skin['sub_dir'])):
        print('"{name}" already installed, skipping.'.format(**skin))
        continue

    # make paths
    basename = skin['dl_url'].rsplit('/', 1)[-1]
    target = os.path.join(TEMP_DIR, basename)

    # check for existing archive file in temp directory, and skip the download
    # if the archive already exists
    if not os.path.isfile(target) or not skin.get('cache_archive', true):
        print('Downloading skin "{name}" from {dl_url} to temporary '
              'directory {}'.format(TEMP_DIR, **skin))
        try:
            with closing(requests.get(skin['dl_url'], stream=True)) as r:
                with open(target, 'wb') as fd:
                    for chunk in r.iter_content(chunk_size=128):
                        fd.write(chunk)
        except requests.exceptions.RequestException:
            print('Cannot download "{name}", skipping.'.format(**skin))
            continue

    # destination unpack directory
    dest = os.path.join(SKIN_DIR, skin['type'])

    # create target directory
    if not os.path.isdir(dest):
        print(f'Creating skin destination directory at {dest}')
        os.mkdir(dest)

    # extract file using 7-zip
    print(f'Extracting skin via 7-Zip from {target} to {dest}')
    subprocess.call([SEVEN_ZIP, '-bd', '-aoa', f'-o{dest}', 'x', target],
                    stdout=DEVNULL)


# confirm on exit to hold terminal window open
if batch_mode is False:
    input('\nPress ENTER to exit.')
