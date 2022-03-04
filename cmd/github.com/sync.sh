#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
DOWNLOAD_DIR="${ROOT_DIR}/downloads"

source "${SCRIPT_DIR}/lib/github.bash"

find "${ROOT_DIR}/packages/github.com" -name 'tool.ini' -print0 | 
    while IFS= read -r -d '' line; do 
        tooldir="$(dirname "$line")"
        org="$(basename "$(dirname "$(dirname "$line")")")"
        repo="$(basename "$(dirname "$line")")"
        
        echo "[TOOL]: $org/$repo"
        latest="$(latest_version "$org/$repo")"
        latestDir="${tooldir}/${latest}"
        rm -rf $latestDir
        if [ -d "${latestDir}" ];
        then
            continue
        fi

        echo "[TOOL/$org/$repo]: $latest"
        latestRelease="$(latest_release "$org/$repo" "$latest")"
        downloadDir="${DOWNLOAD_DIR}/$org/$repo/$latest"
        rm -rf "${downloadDir}"
        mkdir -p "${latestDir}" "${downloadDir}"

        gh release download --repo "$org/$repo" --dir "${downloadDir}" "${latestRelease}"
        (
            cd "${downloadDir}"
            md5sum * > "${latestDir}/checklist.md5"
            sha256sum * > "${latestDir}/checklist.sha256"
            sha512sum * > "${latestDir}/checklist.sha512"
        )
    done
