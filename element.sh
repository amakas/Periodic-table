#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Перевірка, чи введено значення
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  # Перевірка, чи введене значення є числом (atomic_number)
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # Якщо це число, шукаємо за atomic_number
    ELEMENT_INFO=$($PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = '$1'")
  else
    # Якщо це не число, шукаємо за символом або назвою
    ELEMENT_INFO=$($PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id WHERE elements.symbol = '$1' OR elements.name = '$1'")
  fi

  # Перевірка, чи знайдений елемент
  if [[ -z $ELEMENT_INFO ]]
  then
    echo I could not find that element in the database.
  else
    # Парсинг результатів
    ATOMIC_NUMBER=$(echo $ELEMENT_INFO | cut -d'|' -f1)
    NAME=$(echo $ELEMENT_INFO | cut -d'|' -f2)
    SYMBOL=$(echo $ELEMENT_INFO | cut -d'|' -f3)
    TYPE=$(echo $ELEMENT_INFO | cut -d'|' -f4)
    MASS=$(echo $ELEMENT_INFO | cut -d'|' -f5)
    MELTING=$(echo $ELEMENT_INFO | cut -d'|' -f6)
    BOILING=$(echo $ELEMENT_INFO | cut -d'|' -f7)

    # Виведення результату
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi
fi