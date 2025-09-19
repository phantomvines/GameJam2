#!/bin/sh
printf '\033c\033]0;%s\a' Rund um die Welten
base_path="$(dirname "$(realpath "$0")")"
"$base_path/rund-um-die-welten.x86_64" "$@"
