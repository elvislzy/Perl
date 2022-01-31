#!/user/bin/perl -w
use strict;
use Getopt::Long;

my $old = "log";
my $new = "txt";
my $dir = "./";
my $help = 0;
my $tab = " "x4;

GetOptions(
    'dir=s'             => \$dir,
    'old=s'             => \$old,
    'new=s'             => \$new,
    'help'              => \$help,
);

&help_message if $help;

opendir DH, $dir or die "Can not open $dir for reading!\n";
while(my $file = readdir DH) {
    print $file;
    my $newfile = $file;
    $newfile =~ s/\.$old$/\.$new/;
    if (-e $newfile) {
        print "can't fine file\n";
    }
    elsif (rename $file, $newfile) {
        print "rename successfully\n\n";
    }
}


# foreach my $file (glob "*.$old") {
#     my $newfile = $file;
#     $newfile =~ s/\.$old$/.$new/;
#     if (-e $newfile) {
#         print "can't fine file\n";
#     }
#     elsif (rename $file, $newfile) {
#         print "rename successfully\n\n";
#     }
# }

sub help_message {
    print "\nUsage: perl $0 OPTIONS\n";
    print "OPTIONS:\n";
    print "-"x50 . "\n";
    print "${tab}-dir dir_name      --  specify the dir that save the files.\n";
    print "${tab}                       Default is ./\n";
    print "${tab}-old               --  specify the original file extentions.\n";
    print "${tab}                       Default is txt\n";
    print "${tab}-new               --  specify the new file extentions.\n";
    print "${tab}                       Default is log\n";
    print "${tab}-help              --  print help message\n";
    print "-"x50 . "\n";
    print "Example:\n";
    print "${tab}perl $0 ./out -old txt -new log\n";    
    print "Author:\n";
    print "${tab}Elvis.Lu<lzyelvis\@gmail.com>\n\n";
    exit;

}