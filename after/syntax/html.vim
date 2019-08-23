"NBO ADDITION: modifying syntax of html.vim so that content between html marks can be
"folded and not only html tag itself.
"see:
"https://stackoverflow.com/questions/7148270/how-to-fold-unfold-html-tags-with-vim
syntax region htmlFold start="<\z(\<\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|para\|source\|track\|wbr\>\)\@![a-z-]\+\>\)\%(\_s*\_[^/]\?>\|\_s\_[^>]*\_[^>/]>\)" end="</\z1\_s*>" fold transparent keepend extend containedin=htmlHead,htmlH\d
