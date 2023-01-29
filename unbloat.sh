#!/bin/bash

# This script delete unused packages. Be vigilant and read carefully what he wants to remove

sudo dnf remove -y $(cat unbloat.txt)

Exit 0
