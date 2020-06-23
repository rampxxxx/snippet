#!/bin/sh

# Create cscope db based in src dir but in $HOME (quota disk problem) 




#SRC_ROOT=/repo/zjamvra/toBuildEpg
SRC_ROOT=.

true >cscope.files

# cd ~ # Avoid home
#find $SRC_ROOT/cdpi-main \( -name '*.cc' -o -name '*.h' \) -exec realpath {} \; > cscope.files
#find $SRC_ROOT/cdpi-toolkit \( -name '*.cc' -o -name '*.h' \) -exec realpath {} \; >> cscope.files
#find $SRC_ROOT/cdpi-heur  \( -name '*.cc' -o -name '*.h' \) -exec realpath {} \; >> cscope.files
#find $SRC_ROOT/epg  \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -exec realpath {} \; >> cscope.files

find $SRC_ROOT  \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -exec realpath {} \; >> cscope.files


# Avoid temp files of build/install directories
grep -v "install\/include" cscope.files > cscope.files.$$
mv cscope.files.$$ cscope.files

# -b: just build
# -q: create inverted index
cscope -b -q

#cd - # Avoid home


# ctags
#ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
