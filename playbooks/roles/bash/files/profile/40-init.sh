## Initialization tasks ##
##########################

echo "bash_profile init ran $(date)" >> /tmp/dotfiles_init

# X Settings
##############
# If on X and DE or WM doesn't easily support keyboard layout switch
# setxkbmap -model logitech_g15 -layout us,br -variant ,abnt2 -option grp:alt_shift_toggle