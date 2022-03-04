#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z.\1/; s/$/.z/; G; s/\n/ /' | \
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  local -r repo="${1}"

  gh release list --repo "${repo}" | \
    cut -f3 \
    grep -Eo '[0-9]\.[0-9]+.*' | \
    sort_versions | \
    uniq
}

latest_version() {
  local -r repo="${1}"

  gh release list --repo "${repo}" | \
    grep 'Latest' | \
    cut -f3 | \
    grep -Eo '[0-9]\.[0-9]+.*' | \
    sort_versions | \
    uniq
}

list_all_releases() {
  local -r repo="${1}"

  gh release list --repo "${repo}" | \
    cut -f3 \
    grep -Eo '[0-9]\.[0-9]+.*' | \
    sort_versions | \
    uniq
}

latest_release() {
  local -r repo="${1}"

  gh release list --repo "${repo}" | grep 'Latest' | cut -f3
}