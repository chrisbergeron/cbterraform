#!/bin/bash

export DO_PAT=`cat ~/Documents/mystuff/do_api_key.txt`
export SSH_FINGERPRINT=`ssh-keygen -E md5 -lf ~/.ssh/id_rsa | awk '{ print $2 }' | sed -e 's/MD5://g'`

export TF_VAR_do_token=`cat ~/Documents/mystuff/do_api_key.txt`
export TF_VAR_ssh_fingerprint=`ssh-keygen -E md5 -lf ~/.ssh/id_rsa | awk '{ print $2 }' | sed -e 's/MD5://g'`

set | grep DO_PAT
set | grep SSH_FINGER
set | grep TF_VAR_do_token
set | grep TF_VAR_ssh_fingerprint
