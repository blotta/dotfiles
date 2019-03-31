function add_to_path() {
    [ -z "$1" ] && return 1
    local path="$1"
    paths=($(echo_paths))
    for p in ${paths[@]}; do
        [ $path == $p ] && return
    done

    if [ -n "$2" ] && [ $2 == 'prepend' ]; then
        export PATH="${path}:${PATH}"
    else
        export PATH="${PATH}:${path}"
    fi
}