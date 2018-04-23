#!/bin/bash

# only do this if the current user is root (and no RUN_AS_ROOT env)
if [ $(id -u) = 0 -a -z "$RUN_AS_ROOT" ] ; then

   # read ID/names from environment or fallback to defaults
   USER_ID=${LOCAL_USER_ID:-1001}
   GROUP_ID=${LOCAL_GROUP_ID:-1001}
   USER_NAME=${LOCAL_USER_NAME:-vdasari}
   GROUP_NAME=${LOCAL_GROUP_NAME:-vdasari}

   # create group/user in the container (do not create home directory since we're volume
   # mapping /home in already)
   groupadd -g $GROUP_ID $GROUP_NAME
   useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -M $USER_NAME
   export HOME="/home/$USER_NAME"

   exec /usr/local/bin/gosu $USER_NAME:$GROUP_NAME "$@"
else
   # run command as existing user
   exec "$@"
fi
