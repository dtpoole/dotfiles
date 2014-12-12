#!/bin/sh

SCRIPT=`basename $0`
DIR=$PWD
cd $DIR

echo Creating links...
for FILE in *
do
    if [ "$FILE" = "$SCRIPT" ] || [ "$FILE" = "README.md" ]; then
        continue
    fi

    echo -- $FILE
    DEST=${HOME}/.${FILE}
    if [ -e $DEST ] || [ -L $DEST ]; then
        echo $DEST exists.
    else
        ln -s $DIR/$FILE $DEST
    fi
done

if [ ! -d ~/.vim/bundle/vundle ]; then
    echo -- Setting up VIM...
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +PluginInstall +qall
fi

