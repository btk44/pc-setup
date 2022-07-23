#!/bin/bash
# the script will set up terminal prompt to: "[ user|host: short-directory ]$> "
# if it is not set yet

if ! grep -q 'PS1=' ~/.bashrc ; then
   sed -i '/unset rc/i PS1="[ \\u|\\h: \\W ]$> "\n' ~/.bashrc
   echo 'bashrc changed. restart terminal to see effect.'
else
   echo 'nothing chnged. PS1 has a value already.';
fi
