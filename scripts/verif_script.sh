#!/bin/bash

#verifie si les utilisateurs existent  developer1, developer2, integrator1, integrator2, growthhacker

  if ! id developer1 >/dev/null 2>&1; then
    echo "developer1  n'existe pas "
    exit 1
fi

if ! id developer2 >/dev/null 2>&1; then
    echo "developer2  n'existe pas "
    exit 1
fi

if ! id integrator1 >/dev/null 2>&1; then
    echo "integrator1  n'existe pas "
    exit 1
fi

if ! id integrator2 >/dev/null 2>&1; then
    echo "integrator2  n'existe pas "
    exit 1
fi

if ! id growthhacker >/dev/null 2>&1; then
    echo "growthhacker  n'existe pas "
    exit 1
fi

#verifie si les groupes existent developers, web, marketing, docker, figma, ads

if ! grep -q developers /etc/group; then
    echo "developers  n'existe pas "
    exit 1
fi

if ! grep -q web /etc/group; then
    echo "web  n'existe pas "
    exit 1
fi

if ! grep -q marketing /etc/group; then
    echo "marketing  n'existe pas "
    exit 1
fi

if ! grep -q docker /etc/group; then
    echo "docker  n'existe pas "
    exit 1
fi

if ! grep -q figma /etc/group; then
    echo "figma  n'existe pas "
    exit 1
fi

#verifie si les fichiers existent /development/index.html, /development/index.css

if [ ! -f /development/index.html ]; then
    echo "index.html  n'existe pas "
    exit 1
fi

if [ ! -f /development/index.css ]; then
    echo "index.css  n'existe pas "
    exit 1
fi

#verifie si les fichiers sont bien propriété de leurs utilisateurs respectifs

if [ "$(stat -c '%U' /development/index.html)" != "developer1" ]; then
    echo "index.html n'appartient pas à developer1"
    exit 1
fi

if [ "$(stat -c '%U' /development/index.css)" != "integrator1" ]; then
    echo "index.css  n'appartient pas à integrator1"
    exit 1
fi

#verifie si les fichiers ont les bons droits

if [ "$(stat -c '%a' /development/index.html)" != "750" ]; then
    echo "index.html n'a pas les bons droits"
    exit 1
fi

if [ "$(stat -c '%a' /development/index.css)" != "750" ]; then
    echo "index.css n'a pas les bons droits"
    exit 1
fi

#verifie si les fichiers ont les bons groupes

if [ "$(stat -c '%G' /development/index.html)" != "developers" ]; then
    echo "index.html n'a pas le bon groupe"
    exit 1
fi

if [ "$(stat -c '%G' /development/index.css)" != "web" ]; then
    echo "index.css n'a pas le bon groupe"
    exit 1
fi

#verifie si les fichiers ont les bons droits pour les autres

if [ "$(stat -c '%a' /development/index.html)" != "750" ]; then
    echo "index.html n'a pas les bons droits pour les autres"
    exit 1
fi

if [ "$(stat -c '%a' /development/index.css)" != "750" ]; then
    echo "index.css n'a pas les bons droits pour les autres"
    exit 1
fi