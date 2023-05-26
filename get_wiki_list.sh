for i in {1..50}; do
    PAGE='https://en.wikipedia.org/wiki/Special:Random';
    curl -Ls -o /dev/null -w %{url_effective} $PAGE >> wiki_list.txt && echo >> wiki_list.txt;
done