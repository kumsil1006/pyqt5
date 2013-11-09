#!/bin/sh

set -ex

export TAR_OPTIONS='--owner root --group root --mode a+rX'
export GZIP_OPTIONS='-9n'
pwd=$(pwd)
dfsg_version="$1"
if [ -z "$dfsg_version" ]
then
	printf 'Usage: %s <version>\n' "$0"
	exit 1
fi
upstream_version="${dfsg_version%+dfsg*}"
cd "$(dirname "$0")/../"
tmpdir=$(mktemp -t -d get-orig-source.XXXXXX)
uscan --noconf --force-download --rename --download-version="$upstream_version" --destdir="$tmpdir"
cd "$tmpdir"
tar -xzf pyqt5_*.orig.tar.gz
rm pyqt5_*.orig.tar.gz

mv PyQt-gpl-* "pyqt5-${dfsg_version}.orig"

# jquery.min.js
rm -rf "pyqt5-${dfsg_version}.orig/doc/html/"
rm -f "pyqt5-${dfsg_version}.orig/examples/webkit/fancybrowser/jquery.min.js"
rm -f "pyqt5-${dfsg_version}.orig/examples/webkit/fancybrowser/jquery_rc.py"

tar -czf "$pwd/pyqt5_${dfsg_version}.orig.tar.gz" "pyqt5-${dfsg_version}.orig"
rm -rf "$tmpdir"
