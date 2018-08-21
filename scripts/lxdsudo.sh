#!/bin/bash
apt update && apt install python-minimal -y
echo "import pty; pty.spawn('/bin/bash')" > /tmp/lxdsudo.py
python /tmp/lxdsudo.py
