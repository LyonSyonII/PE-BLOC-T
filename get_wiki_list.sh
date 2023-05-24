for i in {1..50}; do
    (curl -Ls -o /dev/null -w %{url_effective} https://en.wikipedia.org/wiki/Special:Random >> wiki_list.txt && echo >> wiki_list.txt)
done