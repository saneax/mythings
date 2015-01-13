#!/usr/bin/expect -f
set host [lindex $argv 0]
spawn scp -o stricthostkeychecking=no -o PubkeyAuthentication=no xyz.txt $host:/tmp/
expect "password: "
send "onevision\r"
wait
