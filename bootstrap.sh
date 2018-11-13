#!/usr/bin/env bash
# Created by Georgi Yadkov


set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app



for dotdir in "${__dir}"/*; do
    [ ! -d "${dotdir}" ] && continue

    # Can't expand the wildcard in the second loop
    # found solution with find https://stackoverflow.com/a/9353205
    for j in "$(find ${dotdir} -type f)"; do
       filedir="$(dirname "$j")"
       dotfile="$(basename "$j")"
       basefile="$HOME/${dotfile}"

        if [ -h "${basefile}" ]; then
           echo "Deleting link : ${basefile}"
           rm "${basefile}"
        elif [ -d "${basefile}" ]; then
           echo "Replacing directory: ${basefile} (saving old version)"
           save_name="${basefile}.dotfiles.sav"
           if [ -e "${save_name}" ]; then
              save_name="${save_name}.$(date +'%s')"
           fi
           mv "${basefile}" "${save_name}"
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



