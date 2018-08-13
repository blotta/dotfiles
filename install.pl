#!/usr/bin/perl

use 5.18.0;
use strict;
use warnings;

use JSON;
use File::Basename;
use Data::Dumper;

if ($ENV{"LOGNAME"} eq 'root') {
    die "Should not be run as root"
}


sub getConfig {
    my $config_file = shift;

    my $config_txt;
    {
        local $/;
        open my $cfh, "<", $config_file;
        $config_txt = <$cfh>;
        # say $config_txt;
        close $cfh;
    }

    return decode_json($config_txt);
}

my $config = getConfig('config.json');


my $DOTFILEPATH = qx{ dirname `realpath $0` } ;
chomp $DOTFILEPATH;

my $FAKEHOME = $DOTFILEPATH . '/userhome';

my $ISPATH = $DOTFILEPATH . "/install_scripts";
opendir(my $is, $ISPATH) || die "Could not open $ISPATH: $!";
my @scripts;
while (readdir $is) {
    /^\./ && next;
    my $spath = $ISPATH . "/$_";
    if ( -x $spath ) { push @scripts, $spath };
}
closedir $is;

@scripts = sort @scripts;

foreach (@scripts) {
    my $f = fileparse($_, qr/\.[^.]*/);
    my $args = defined $config->{install_scripts}->{$f}->{args} ?
        join(' ', @{ $config->{install_scripts}->{$f}->{args} }) : $FAKEHOME ;

    my $interp = defined $config->{install_scripts}->{$f}->{interpreter} ?
        $config->{install_scripts}->{$f}->{interpreter} : '' ;

    say ( "$interp $_ $args" );
    system ( "$interp $_ $args" );
}
