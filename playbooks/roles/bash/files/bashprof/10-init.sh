# Host specific init (no X related tasks, since it's not started yet)
mkdir -p $HOME/hostscripts

for s in $( find $HOME/hostscripts/ -type f ) ; do
	$s
done