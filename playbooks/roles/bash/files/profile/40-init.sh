## Initialization tasks ##
##########################

# Host specific init
mkdir -p $HOME/hostscripts

for s in $( find $HOME/hostscripts/ -type f ) ; do
	$s
done

# X Settings
##############
# If on X and DE or WM doesn't easily support keyboard layout switch
# setxkbmap -model logitech_g15 -layout us,br -variant ,abnt2 -option grp:alt_shift_toggle