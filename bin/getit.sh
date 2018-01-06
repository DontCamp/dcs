#!/bin/bash -e

script_dir=$(dirname "$0")
source "${script_dir}/params.sh"

temp_dir="$(mktemp -d)"

wget "https://github.com/DontCamp/dcs/archive/${mission}.zip" -O "${temp_dir}/${mission}.zip"
unzip -d "$temp_dir" "${temp_dir}/${mission}.zip"
pushd "${temp_dir}"/dcs-"${mission}"
ls
zip -r "${dcs_mission_dir}/${mission}.miz" ./*
popd
rm -r "$temp_dir"
echo 
echo '*** RESULT ***'
unzip -l "${dcs_mission_dir}/${mission}.miz"
