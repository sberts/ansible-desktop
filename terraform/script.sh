#!/bin/bash

apt update && apt upgrade && ansible-pull -U https://github.com/sberts/ansible-desktop.git
