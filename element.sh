#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
echo Please provide an element as an argument.
NUMBERS=$($PSQL "SELECT atomic_number FROM elements")
SYMBOLS=$($PSQL "SELECT symbol FROM elements")
NAMES=$($PSQL "SELECT name FROM elements")
if [[ -z $1 ]]
then
 
else
  if echo "$NUMBERS" | grep -qw "$1" || echo "$SYMBOLS" | grep -qw "$1" || echo "$NAMES" | grep -qw "$1" ;
  then
  echo element 
    else 
    echo I could not find that element in the database.
    
  fi
fi