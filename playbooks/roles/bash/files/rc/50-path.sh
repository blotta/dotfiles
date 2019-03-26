# Golang env
[ -z "$GOPATH" ] && GOPATH="${HOME}/go" && mkdir -p $GOPATH

# Golang bin path
add_to_path "${GOPATH}/bin"

# Ruby local path
#add_to_path "$HOME/.gem/ruby/2.5.0/bin"

# Perl 5
# perl -V | head -1 | grep "revision 5" >&2 >/dev/null && [ -d "$HOME/perl5/bin" ] && add_to_path "$HOME/perl5/bin" prepend

# Node.js
[ -d "$HOME/.node_modules_global" ] && add_to_path "$HOME/.node_modules_global/bin"

# My Scripts
mkdir -p ${HOME}/bin && add_to_path "${HOME}/bin" prepend

