#!/usr/bin/env bash

# Project:    Gruvbox Light tmux
# Repository: https://github.com/gvdenbro/gruvbox-light-tmux
# License:    MIT
# References:
#   https://tmux.github.io

GRUVBOX_LIGHT_TMUX_COLOR_THEME_FILE=src/gruvbox-light.conf
GRUVBOX_LIGHT_TMUX_VERSION=0.0.1
GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_FILE="src/gruvbox-light-status-content.conf"
GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_NO_PATCHED_FONT_FILE="src/gruvbox-light-status-content-no-patched-font.conf"
GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_OPTION="@GRUVBOX_LIGHT_TMUX_show_status_content"
GRUVBOX_LIGHT_TMUX_NO_PATCHED_FONT_OPTION="@GRUVBOX_LIGHT_TMUX_no_patched_font"
_current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

__cleanup() {
  unset -v GRUVBOX_LIGHT_TMUX_COLOR_THEME_FILE GRUVBOX_LIGHT_TMUX_VERSION
  unset -v GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_FILE GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_NO_PATCHED_FONT_FILE
  unset -v GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_OPTION GRUVBOX_LIGHT_TMUX_NO_PATCHED_FONT_OPTION
  unset -v _current_dir
  unset -f __load __cleanup
}

__load() {
  tmux source-file "$_current_dir/$GRUVBOX_LIGHT_TMUX_COLOR_THEME_FILE"

  local status_content=$(tmux show-option -gqv "$GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_OPTION")
  local no_patched_font=$(tmux show-option -gqv "$GRUVBOX_LIGHT_TMUX_NO_PATCHED_FONT_OPTION")

  if [ "$status_content" != "0" ]; then
    if [ "$no_patched_font" != "1" ]; then
      tmux source-file "$_current_dir/$GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_FILE"
    else
      tmux source-file "$_current_dir/$GRUVBOX_LIGHT_TMUX_STATUS_CONTENT_NO_PATCHED_FONT_FILE"
    fi
  fi
}

__load
__cleanup
