#!/bin/sh
cd "$(dirname "$0")"


# Make symbolik link for sqlite
echo 'setup sqlite'

if [[ 'Darwin' == $(uname -s) ]]; then
    sqlite_folder='sqlite-tools-osx-x86-3130000'
elif [[ 'GNU/Linux' == $(uname -s) ]]; then
    sqlite_folder='sqlite-tools-linux-x86-3130000'
else
    echo 'Unhandled platform for sqlite'
    exit 1
fi

unzip -oq backends/$sqlite_folder.zip -d backends/

rm sqlite3
ln -s backends/$sqlite_folder/sqlite3 sqlite3


# Make symbolik link for rclone
echo 'setup rclone'

if [[ 'Darwin' == $(uname -s) ]]; then
    os=osx
elif [[ 'GNU/Linux' == $(uname -s) ]]; then
    os=linux
else
    echo "Unhandled platform for rclone"
    exit 1
fi

if [[ 'i386' == $(uname -m) ]]; then
    cpu=386
elif [[ 'x86_64' == $(uname -m) ]]; then
    cpu=amd64
else
    echo "Unhandled platform for rclone"
    exit 1
fi  
rclone_folder=rclone-v1.32-$os-$cpu

unzip -oq backends/$rclone_folder.zip -d backends/

rm rclone
ln -s backends/$rclone_folder/rclone rclone


# Reset db
echo 'Reset sqlite database'
rm sclone.db
./sqlite3 sclone.db < sclone.sql

# Set up rclone remote
echo 'configure rclone - see http://rclone.org for help'
./rclone config

