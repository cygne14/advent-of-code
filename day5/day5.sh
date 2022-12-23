#!/bin/bash


# loading crates into files
j=1
while read -r; do
  if [[ "$REPLY" == *"1"* ]]; then
    break
  fi

  k=1
  # need variable REPLY bcs it preserves spaces => can extract one crate
  for i in $( seq 0 4 "${#REPLY}" ); do
    echo "${REPLY:i:3}" >> "$k".txt
    k=$(( k + 1 ))
  done

  j=$((j + 1))
done < vstup5


commands=$( grep "move" vstup5 )

# delete empty lines
for f in ./*.txt; do
  sed  -i "/[[:space:]]/d" "$f"
done

while read -r line; do

  values=$( echo "$line" | cut -d " " -f 2,4,6 )
  IFS=" " read -r var1 var2 var3 <<< "$values"
  # move var1 from var2 to var3

  # part 1
#  for i in $( seq "$var1" ); do
#    # append first line from "${var2}.txt" to the begining of "${var3}.txt" exactly "$var1"-times
#    head -n 1 < "${var2}.txt" | cat - "${var3}.txt" > temp && mv temp "${var3}.txt"
#    sed -i "1d" "${var2}.txt"
#    echo "moving $i-st time from ${var2} to ${var3}"
#  done

  # part 2
  head -n "$var1" < "${var2}.txt" | cat - "${var3}.txt" > temp && mv temp "${var3}.txt"

  for i in $( seq "$var1" ); do
    sed -i "1d" "${var2}.txt"
  done

done <<< "$commands"

for f in ./*.txt; do
  head -n 1 < "$f" | tr -d "[]" >> "0.txt"
done

tr -d "\n" < "0.txt"
echo

rm [0-9]*.txt