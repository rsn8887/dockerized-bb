#! /bin/sh

OSXCROSS_VERSION=be2b79f444aa0b43b8695a4fb7b920bf49ecc01c
export XAR_VERSION=2b9a4ab7003f1db8c54da4fea55fcbb424fdecb0

PACKAGE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
HELPERS_DIR=$PACKAGE_DIR/../..
. $HELPERS_DIR/functions.sh

do_make_bdir

do_git_fetch osxcross "https://github.com/tpoechtrager/osxcross.git" "${OSXCROSS_VERSION}"

# Link SDK tarballs
for f in "${SDK_DIR}"/*; do
	ln -s "$f" tarballs/
done

# This will let build.sh use our own clang
export PATH=$PATH:${TARGET_DIR}/bin

# Don't ask anything
UNATTENDED=1 ./build.sh

do_clean_bdir
