# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi



# Host specific init (no X related tasks, since it's not started yet)
mkdir -p $HOME/hostscripts

for s in $( find $HOME/hostscripts/ -type f ) ; do
	$s
done



# Automatically start the X session when logged in
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 && -e "$HOME/.xinitrc" ]]; then
    exec startx ~/.xinitrc i3
fi
# Nothing gets executed after exec