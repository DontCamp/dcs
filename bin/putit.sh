#!/bin/bash -e

script_dir=$(dirname "$0")
source "${script_dir}/params.sh"

cd "${git_dir}"
git checkout "${mission}"
unzip -o "${dcs_mission_dir}/${mission}.miz"
