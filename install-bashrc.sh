#!/usr/bin/env bash

BIN="`realpath $0 | xargs dirname`/bin"
echo "export PATH=\"${BIN}\":\${PATH}" >> ~/.bashrc