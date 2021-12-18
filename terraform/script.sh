#!/bin/bash

apt update && apt upgrade -y && apt install ansible -y && \
  ansible-pull -U https://github.com/sberts/ansible-desktop.git

echo date > /tmp/script.log
