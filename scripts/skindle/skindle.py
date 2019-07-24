#!/usr/bin/env/python

import argparse
import atexit
import os
import requests
import subprocess
import sys
import urllib.parse as up
from bs4 import BeautifulSoup
from contextlib import closing
from subprocess import DEVNULL
from yaml import safe_load


# program info for help text
version = '0.3.0'
desc_text = 'DontCamp.com DCS skin package manager version {}'.format(version)
# CLI arguments
parser = argparse.ArgumentParser(description=desc_text)
parser.add_argument('-b', action='store_true',
                    help='Run in non-interactive batch mode')
args = parser.parse_args()
batch_mode = args.b


# hold cmd.exe window open if not in batch mode or an exeption occurs
if batch_mode is False:
    atexit.register(input, '\nPress ENTER to exit.')


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
        config[key] = DEF_CONFIG.get(key)


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
SEVEN_ZIP = config.get('SKINDLE_SEVEN_ZIP')
TEMP_DIR = config.get('SKINDLE_TEMP_DIR')
SKIN_DIR = config.get('SKINDLE_SKIN_DIR')
SKIN_DATA_URL = config.get('SKINDLE_SKIN_DATA_URL')


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
for skin in skin_data.get('skins'):
    site_url = skin.get('link')
    base_url = '{uri.scheme}://{uri.netloc}/'.format(uri=up.urlparse(site_url))

    # scrape DCS site if base URL is the DCS site...?
    if base_url == 'https://www.digitalcombatsimulator.com/':
        with closing(requests.get(site_url)) as r:
            soup = BeautifulSoup(r.text, features="lxml")

        # find skin type via scraping the category
        tag = soup.find(lambda tag: tag.name == 'div'
                        and tag.get('class') == ['col-xs-4'])
        site_skin_type = tag.text.strip()
        dir_map = skin_data.get('dir_map')
        skin_type = dir_map.get(site_skin_type)

        # find all links in page
        links = list()
        for link in soup.find_all('a'):
            links.append(link.get('href'))

        # search list of links for ones that download stuff
        dl_link_search = 'download.php?'
        dl_link_suffix = next((s for s in links if dl_link_search in s), None)

        # find dl path via the 'goto' parameter in the url
        # this strips the session IDs, which we do not need
        parsed_url_suffix = up.urlparse(dl_link_suffix)
        url_params = up.parse_qs(parsed_url_suffix.query)['goto'][0]

        # create direct download URL
        direct_dl_url = up.urljoin(base_url, url_params)
    else:
        # non-DCS site direct downloads
        skin_type = skin.get('type')
        direct_dl_url = site_url

    # check for existing skin installation.
    # for archives with multiple skins, we only need to check for one of them
    full_sub_dir_path = os.path.join(SKIN_DIR, skin_type, skin.get('sub_dir'))
    if os.path.isdir(full_sub_dir_path):
        print('"{}" already installed, skipping.'.format(skin.get('name')))
        continue

    # make paths
    base_name = direct_dl_url.rsplit('/', 1)[-1]
    target = os.path.join(TEMP_DIR, base_name)

    # check for existing archive file in temp directory, and skip the download
    # if the archive already exists
    if not os.path.isfile(target) or not skin.get('cache_archive', True):
        print('Downloading skin "{}" from {} to temporary '
              'directory {}'.format(skin.get('name'), direct_dl_url, TEMP_DIR))
        try:
            with closing(requests.get(direct_dl_url, stream=True)) as r:
                with open(target, 'wb') as fd:
                    for chunk in r.iter_content(chunk_size=128):
                        fd.write(chunk)
        except requests.exceptions.RequestException:
            print('Cannot download "{name}", skipping.'.format(**skin))
            continue

    # destination unpack directory
    dest = os.path.join(SKIN_DIR, skin_type)

    # create target directory
    if not os.path.isdir(dest):
        print(f'Creating skin destination directory at {dest}')
        os.mkdir(dest)

    # extract file using 7-zip
    print(f'Extracting skin via 7-Zip from {target} to {dest}')
    subprocess.call([SEVEN_ZIP, '-bd', '-aoa', f'-o{dest}', 'x', target],
                    stdout=DEVNULL)
