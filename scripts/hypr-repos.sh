#!/bin/bash

# Lista de repositorios COPR
 REPOS=(
     "sdegler/hyprland"
         "peterwu/rendezvous"
             "wef/cliphist"
                 "tofik/nwg-shell"
                     "che/nerd-fonts"
                         "erikreider/SwayNotificationCenter"
                         )

                         echo "--- Habilitando repositorios COPR ---"

                         for repo in "${REPOS[@]}"; do
                             echo "Habilitando: $repo..."
                                 sudo dnf copr enable --assumeyes "$repo"
                                 done

                                 echo "--- Proceso finalizado ---"

