#!/bin/bash


# nahradim dolary zavinacema protoze dolary zlobi a upravim vstup -> kazda radka zacina zavinacem a prikazama potom
lines=$( tr "$" "@" < vstup7 | tr "\n" " " | tr "@" "\n" | sed "1d" | sed "s/^ /@/g" )

while read -r line; do
  # radka obsahuje / => udelam "korenovy" adresar
  if [[ "$line" =~ / ]]; then
    mkdir first
    cd first

  # radka obsahuje ls
  elif [[ "$line" =~ "@ls".* ]]; then
    # radka vypada napriklad takto: @ls dir a 14848514 b.txt 8504156 c.dat dir d, tak to dam do radku a odstranim @ls

    # shellcheck disable=SC2086
    echo ${line} | tr " " "\n" | sed "1d" | while read -r info; read -r file; do
      # vytvorim slozku jmenem $file
      if [[ "${info}" == "dir" ]]; then
        mkdir "${file}"
      # vytvorim soubor $file o velikosti $info
      else
        head -c "${info}" /dev/zero > "${file}"
      fi
    done

  # radka obsahuje cd .. tak to udelam
  else
    eval "$( tr -d "@" <<< "$line" )"

  fi
done <<< "$lines"

# tedka mam ve slozce first vsechny soubory a slozky a uz jenom spocitam jejich velikost

# path to dir first
p=$( pwd | sed "s/\(.*\)first.*/\1/" )
# vratim se tam kde jsem zacinala
cd "$p"

# ls -lR first | grep "first" | tr -d ":" gives list of all folders
ls -lR first | grep "first" | tr -d ":" | while read -r folder; do
  # najdu vsechny soubory a podsoubory a spocitam jejich velikost
  ls -lR "$folder" | grep "\-rw\-rw\-r\-\-" | tr -s " " | cut -d " " -f 5 | tr "\n" "+" | sed "s/+$/\n/" | bc
done >> results

# sectu jen ty radky co jsou mensi jak 100001
awk '{ if ($0 < 100001) print $0}' < results | tr "\n" "+" | sed "s/+$/\n/" | bc
echo

# druha cast
total=$( sort -rn < results | head -n 1 )
total=$(( 30000000 - 70000000 + "$total" ))

sort -n < results | while read -r line; do
  if [ "$total" -le "$line"  ]; then
    echo "$line"
    break
  fi
done

rm results
rm -rf first