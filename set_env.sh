#!/bin/bash

export DO_PAT=`cat ~/Documents/mystuff/do_api_key.txt`
export SSH_FINGERPRINT=`ssh-keygen -E md5 -lf ~/.ssh/id_rsa | awk '{ print $2 }' | sed -e 's/MD5://g'`

set | grep DO_PAT
set | grep FINGER
