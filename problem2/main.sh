a=$(python3.10 build.py)
unshare --fork --pid --mount-proc --uts --net --root=$a bash -c  "hostname $1 && /bin/bash"
rm -r $a