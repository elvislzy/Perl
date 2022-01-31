#!/user/bon/perl -w
use strict;
use POSIX;

my $cur_time = strftime("%m/%d/%Y",localtime());
my $file_name;
my $tab = " "x4;

if(@ARGV == 1) {
    $file_name = $ARGV[0];
}
else {
    &help_message();
}

open(LOG, ">", $file_name) or die "Can't open $file_name for writing!\n";
my $str = "";
$str .= "#!user/bin/perl -w\n";
$str .= "use strict;\n";
$str .= "# -----------------------------------------------------------------\n";
$str .= "# Filename: $file_name                                             \n";
$str .= "# \n";
$str .= "# Company: \n";
$str .= "# Description:                                                     \n";
$str .= "# \n";
$str .= "# \n";
$str .= "#                                                                  \n";
$str .= "# Author: Elvis.Lu<lzyelvis\@gmail.com>                            \n";
$str .= "# Create Date: $cur_time                                           \n";
$str .= "# Comments:                                                        \n";
$str .= "# \n";
$str .= "# -----------------------------------------------------------------\n";

print LOG $str;
close(LOG);

print "\n generated\n\n";

sub help_message {
    print "\n The $0 script used to generate file head\n\n";
    print "Usage: perl $0 file_name\n\n";

    exit;
}