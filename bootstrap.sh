#!/usr/bin/env bash
# Created by Georgi Yadkov

#
# TODO 
# * uninstall script
# * manage permanent history file 
set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"


# found the idea for the structute of the repo at:
# https://github.com/jeffaco/dotfiles/blob/master/nix/bootstrap.sh
#
# loop through the directories in the repo
for dotdir in "${__dir}"/*; do
    [ ! -d "${dotdir}" ] && continue

    # Can't expand the wildcard in the second loop
    # found solution with find https://stackoverflow.com/a/9353205
    #
    # find the files in every directory and sym link them at $HOME
    for j in "$(find ${dotdir} -type f)"; do
       filedir="$(dirname "$j")"
       dotfile="$(basename "$j")"
       basefile="$HOME/${dotfile}"

       # check if the file in the $HOME is symlink
        if [ -h "${basefile}" ]; then
           echo "Deleting link : ${basefile}"
           rm "${basefile}"

	# check if hte file in the $HOME is directory
        elif [ -d "${basefile}" ]; then
           echo "Replacing directory: ${basefile} (saving old version)"
           save_name="${basefile}.dotfiles.sav"
           if [ -e "${save_name}" ]; then
              save_name="${save_name}.$(date +'%s')"
           fi
           mv "${basefile}" "${save_name}"

	# check if the file in the $HOME exist
        elif [ -e "${basefile}" ]; then
           echo "Replacing file: ${basefile}"
           save_name="${basefile}.dotfiles.sav"
           if [ -e "${save_name}" ]; then
              save_name="${save_name}.$(date +'%s')"
           fi
           mv "${basefile}" "${save_name}"
        else
            echo "Creating link: ${basefile}"
        fi

        ln -s "$j" "${basefile}"
    done
done
