#!/bin/sh
#set -x
# Create cscope db based in src dir but in $HOME (quota disk problem)




#SRC_ROOT=/repo/zjamvra/toBuildEpg
SRC_ROOT=.
CSCOPE_FILE_PATTERN="cscope*"

true >cscope.files
echo "Deleting old cscope files: $(ls "$CSCOPE_FILE_PATTERN")"
rm "$CSCOPE_FILE_PATTERN"

# cd ~ # Avoid home
#find $SRC_ROOT/cdpi-main \( -name '*.cc' -o -name '*.h' \) -exec realpath {} \; > cscope.files
#find $SRC_ROOT/cdpi-toolkit \( -name '*.cc' -o -name '*.h' \) -exec realpath {} \; >> cscope.files
#find $SRC_ROOT/cdpi-heur  \( -name '*.cc' -o -name '*.h' \) -exec realpath {} \; >> cscope.files
#find $SRC_ROOT/epg  \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -exec realpath {} \; >> cscope.files

#find $SRC_ROOT  \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -exec realpath {} \; >> cscope.files
echo "Searching for source files..."
find $SRC_ROOT  \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \)  >> cscope.files


# Avoid temp files of build/install directories
grep -v "install\/include" cscope.files > cscope.files.$$
mv cscope.files.$$ cscope.files

# -b: just build
# -q: create inverted index
echo "Creating cscope db..."
cscope -b -q
echo "Result of cscope command:"$?

#cd - # Avoid home

echo "Creating universal-ctags tag file ..."
universal-ctags "$(cat cscope.files)"
# ctags
#ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
#echo "press key to continue..."
#read
