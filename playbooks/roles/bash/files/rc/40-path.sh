# Golang env
[ -z "$GOPATH" ] && \
    GOPATH="${HOME}/go" && \
    mkdir -p $GOPATH

# Golang bin path
[ -n "$GOPATH" ] && add_to_path "${GOPATH}/bin" prepend

# Node.js
[ -d "$HOME/.node_modules_global" ] && add_to_path "$HOME/.node_modules_global/bin" prepend

# My Scripts
mkdir -p ${HOME}/bin && add_to_path "${HOME}/bin" prepend
mkdir -p ${HOME}/.local/bin && add_to_path "${HOME}/.local/bin" prepend