#!/usr/bin/env bash

#This script was AI made. I don't know about shell scripting. This is my first
# time doing a project likde this. The intention behind this project is to learn
# to manage this kind of things and make them on my own
#The script checks for packages availability on fedora repos.
set -e

PACKAGE_FILE="$1" #This takes a file as an argument. This should be a txt file. 

if [[ -z "$PACKAGE_FILE" ]]; then
  echo "Uso: ./check-packages.sh <archivo-de-paquetes>"
  exit 1
fi

if [[ ! -f "$PACKAGE_FILE" ]]; then
  echo "Archivo no encontrado: $PACKAGE_FILE"
  exit 1
fi

echo "▶ Verificando paquetes en repositorios..."
echo

FOUND=()
MISSING=()

while read -r pkg; do
  [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue

  if dnf repoquery "$pkg" &>/dev/null; then
    echo "✅ $pkg"
    FOUND+=("$pkg")
  else
    echo "❌ $pkg"
    MISSING+=("$pkg")
  fi
done < "$PACKAGE_FILE"

echo
echo "=== Resumen ==="
echo "Disponibles: ${#FOUND[@]}"
echo "No encontrados: ${#MISSING[@]}"

if [[ ${#MISSING[@]} -gt 0 ]]; then
  echo
  echo "⚠ Paquetes faltantes:"
  for pkg in "${MISSING[@]}"; do
    echo " - $pkg"
  done
fi
