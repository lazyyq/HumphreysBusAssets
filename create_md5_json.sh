#!/bin/bash

cd assets

printf '{\n  "files": ['
find . -type f -exec md5sum -z {} + |
sed -Ez '
s/\\/\\\\/g
s/"/\\"/g
s/\x08/\\b/g
s/\f/\\f/g
s/\n/\\n/g
s/\r/\\r/g
s/\t/\\t/g
s/(.{32})..(.*)/\
    {\
      "name": "\2",\
      "md5": "\1"\
    }/
$!s/$/,/' | tr -d '\0'

printf '\n  ]\n}\n'

cd ..
