#!/usr/bin/env bash

# Test the bootstrap script with pre-filled answers
cd /Users/derry/Sites/ghub/rdbl

# Feed answers to the bootstrap script
/Users/derry/Sites/ghub/pip/bin/bootstrap.sh <<EOF
rdbl
Reading & blogging platform
product
y
y
y
y
n
n
y
n
y
n
y
y
EOF
