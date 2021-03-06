#!/usr/bin/env bash
set -e

clone() {
  url="$1"
  directory="${2:-.}"
  git clone "$1" "$2"
}

clone_frontend() {
  test -d ./frontend || clone https://github.com/Razz/Project_Organizer_FrontEnd ./frontend
}

clone_backend() {
  test -d ./backend || clone https://github.com/Razz/Project_Organizer_BackEnd ./backend
}

initialize_backend() {
  docker-compose run --rm backend-init
}

start_app() {
  docker-compose up database frontend backend
}

for app in docker-compose git
do
  if ! &>/dev/null which "$app"
  then
    >&2 echo "ERROR: Ensure that you have '$app' installed on your machine."
    exit 1
  fi
done

clone_frontend &&
  clone_backend &&
  initialize_backend &&
  start_app
