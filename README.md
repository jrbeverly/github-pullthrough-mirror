# Release Mirror for GitHub Releases

Lightweight experiment for mirroring GitHub releases into a file store system like Minio or AWS S3.

## Getting Started


### packages/

Contains the tool definition files for each of the mirror repositories (`tool.ini`), and the computed checksums for the downloaded files. In an actual use case it would be better to store the checksums externally from this repository, allowing this one to act purely as an executor, and the other repository acting as a "record" of the known-good commit SHAs (as well as `.sign/.ack` files to chain "trust")

### cmd/

Contains the scripts that are responsible for performing the lookup & download of toolchains from each of the potential sources. Only source for now is GitHub.com.

## Notes

- Could other tools like `asdf` be leveraged instead to download the core binaries, then checksum/bundle that way? What about concerns running any old git repos?
- Do we wish to mirror the GitHub releases, or the binaries themselves? Or is it multiple things we wish to run?
- Are there alternative options for having this kind of mirror?
- Could this benefit from some "import into content addressable storage" model
- Commiting against the same repo isn't great, as it can muddle the commit history of changes to the executor
- Likely want the ability to work off not just the "latest", but any release created for these
- Revocation of builds with known CVEs should be its own separate thing (not integrated into this)
- `gh` (GitHub CLI) is pretty effective for downloading these kinds of binaries
