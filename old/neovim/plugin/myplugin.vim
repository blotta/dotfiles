
echo "runs on init"

" Send text from cursor until end o line to its own line above (alt-enter)
function AltEnter()
    normal d$O
    normal p==
endfunction
