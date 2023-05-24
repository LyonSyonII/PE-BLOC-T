let i=0

cat wiki_list.txt | while read url; do
    links -dump $url > "./Arxius/TEXT/TXT/$i.txt" &
    links -source $url  > "./Arxius/TEXT/HTML/$i.txt" &
    let i=$i+1
done