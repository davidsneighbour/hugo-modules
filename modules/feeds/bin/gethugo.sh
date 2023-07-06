#!/bin/bash

# TODO don't re-download already loaded binaries

RELEASES="etc/releases"
URLSTANDARD="https://github.com/gohugoio/hugo/releases/download/v%s/hugo_%s_Linux-64bit.tar.gz"
URLEXTENDED="https://github.com/gohugoio/hugo/releases/download/v%s/hugo_extended_%s_Linux-64bit.tar.gz"

PS3='Please choose which version to download: '
options=("Standard" "Extended" "Both")
select opt in "${options[@]}" # $REPLY $opt
do
    case $opt in
        "Standard")
            VERSIONSTANDARD=true
            VERSIONEXTENDED=false
            break
            ;;
        "Extended")
            VERSIONSTANDARD=false
            VERSIONEXTENDED=true
            echo "you chose choice 2"
            break
            ;;
        "Both")
            VERSIONSTANDARD=true
            VERSIONEXTENDED=true
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# deciding which release list to use
if [[ ! -f $RELEASES ]]
then
  DOWNLOADLIST="etc/.releases.dist"
else
  DOWNLOADLIST=$RELEASES
fi

# going into the binaries folder
cd bin || exit

# iterate over the versions
while IFS= read -r line; do

  if [[ $VERSIONSTANDARD == true ]]
  then
    echo "Downloading ${line}-standard..."
    template=$URLSTANDARD
    template="${template/\%s/$line}"
    template="${template/\%s/$line}" # I know... one day I'll find how to do it properly
    wget --continue --quiet $template
    FILENAME="${template##*/}"
    mkdir -p temp
    tar -xzf "$FILENAME" -C temp
    version="${line/\./_}"
    version="${version/\./_}"
    # tar --extract --file="hugo/hugo_${version}" hugo # todo check how to do this properly
    cp temp/hugo "hugo/hugo_${version}"
    rm -rf temp
    rm "${FILENAME}"
    echo "done."
  fi

  if [[ $VERSIONEXTENDED == true ]]
  then
    echo "Downloading ${line}-extended..."
    template=$URLEXTENDED
    template="${template/\%s/$line}"
    template="${template/\%s/$line}" # I know... one day I'll find how to do it properly
    wget --continue --quiet $template
    FILENAME="${template##*/}"
    mkdir -p temp
    tar -xzf "$FILENAME" -C temp
    version="${line/\./_}"
    version="${version/\./_}"
    # tar --extract --file="hugo/hugo_extended_${version}" hugo # todo check how to do this properly
    cp temp/hugo "hugo/hugo_extended_${version}"
    rm -rf temp
    rm "${FILENAME}"
    echo "done."
  fi

done < $DOWNLOADLIST
