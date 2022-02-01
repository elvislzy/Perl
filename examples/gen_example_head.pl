#!/user/bon/perl -w
use strict;
use POSIX;

my $cur_time = strftime("%m/%d/%Y",localtime());
my $file_name;
my $tab = " "x4;
my $comment = "#";

if(@ARGV == 1) {
    $file_name = $ARGV[0];
    if($file_name =~ /\.v$/i) {
        $comment = "//";
    }
}
else {
    &help_message();
}

my $name = $file_name;
$name =~ s/^(.*)\.\w+$/${1}/;

open(LOG, ">", $file_name) or die "Can't open $file_name for writing!\n";
my $str = "";

if ($file_name =~ /\.pl$/i) {
    $str .= "#!user/bin/perl -w\n";
    $str .= "use strict;\n";
}

$str .= "${comment} -----------------------------------------------------------------\n";
$str .= "${comment} Filename: $file_name                                             \n";
$str .= "${comment} \n";
$str .= "${comment} Company: \n";
$str .= "${comment} Description:                                                     \n";
$str .= "${comment} \n";
$str .= "${comment} \n";
$str .= "${comment}                                                                  \n";
$str .= "${comment} Author: Elvis.Lu<lzyelvis\@gmail.com>                            \n";
$str .= "${comment} Create Date: $cur_time                                           \n";
$str .= "${comment} Comments:                                                        \n";
$str .= "${comment} \n";
$str .= "${comment} -----------------------------------------------------------------\n";
$str .= "\n\n";

if($file_name =~ /\.v$/i) {
    $str .= "module $name(\n\n\n\n);";
    $str .= "\n\n\n\n\n\n\n\n\n\n\n\n";
    $str .= "endmodule";
}

print LOG $str;
close(LOG);

print "\n generated $file_name\n\n";

sub help_message {
    print "\n The $0 script used to generate file head\n\n";
    print "Usage: perl $0 file_name\n\n";

    exit;
}