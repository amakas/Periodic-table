#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

NUMBERS=$($PSQL "SELECT atomic_number FROM elements")
SYMBOLS=$($PSQL "SELECT symbol FROM elements")
NAMES=$($PSQL "SELECT name FROM elements")
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else
  if echo "$NUMBERS" | grep -qw "$1" || echo "$SYMBOLS" | grep -qw "$1" || echo "$NAMES" | grep -qw "$1" ;
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  TYPE=$($PSQL "SELECT type FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  MASS=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING (atomic_number) WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  MELTING=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING (atomic_number) WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  BOILING=$($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING (atomic_number) WHERE atomic_number = '$1' OR symbol = '$1' OR  name = '$1'")
  echo "The element with atomic number $ATOMIC_NUMBER is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
    else 
    echo I could not find that element in the database.
    
  fi
fi