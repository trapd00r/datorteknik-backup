#!/bin/sh

     BACKUP_DIR=${HOME}
BACKUP_LOCATION=${HOME}/backup
       FILENAME="$(date +%Y%m%d_%H%M%S).tar.gz"

# Se till så att katalogen existerar
mkdir -p ${BACKUP_LOCATION}

# För att inte råka ut för bekymmer om filnamn innehåller konstiga
# tecken så som whitespace eller '-' som annars kan tolkas som en
# flagga, ser vi till att find genererar en lista på filnamn
# terminerade med ASCII NULL: \0 . Vi talar sedan också om för tar att
# den skall expecta just \0 som line terminator istället för \n.

# Hitta alla *filer* i $BACKUP_DIR med filändelse .conf och ignorera case.
# Ett gzippat tar-arkiv skapas med resultaten.
find $BACKUP_DIR -type f -iname '*.conf' -print0 \
  | tar -czf ${BACKUP_LOCATION}/${FILENAME} --null -T -
