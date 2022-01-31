#!/user/bin/perl -w
use strict;

#file handle--"<"read, ">"write
my $file = "info.log";
open (LOG, "<", $file) or die "Can't open file\n";
my $line_num = 0;
while (defined(my $line = <LOG>)) {
    $line_num++;
    next if ($line =~ /^phone/i);
    last if ($line =~ /^version/i);
    print "current line = $line\n\n";
}
close (LOG);

#file classify---------------dir version
my $dir = "./";
opendir DIR, $dir or die "Cannot open\n";
my @files = (readdir DIR);
my @small_files;
foreach my $file (@files) {
    if(! -e $file) {                #if file does not exist
        print "file does not exist\n\n";
    }
    elsif (-s $file < 100_0) {    #file size small than 1kb
        push (@small_files, $file);
    }
}

if (defined $small_files[0]) {
    my $num = @small_files; #num of file in @small_files
    print "The following $num files smaller than 1kb:\n";
    print "-"x40 . "\n";    #-----------------

    foreach my $file(@small_files) {
        if ($file =~ /.pl$/gi) {
            print "$file ";
        }
    }
    print "\n\n";
}
closedir DIR;

#file classify---------------glob version
@small_files = "";
foreach my $file (glob "*.pl") {
    if(! -e $file) {                #if file does not exist
        print "\nfile does not exist\n\n";
    }
    elsif (-s $file < 100_0) {    #file size small than 1kb
        push (@small_files, $file);
    }
}

if (defined $small_files[0]) {
    my $num = @small_files; #num of file in @small_files
    print "\nThe following $num files smaller than 1kb:\n";
    print "-"x40 . "\n";    #-----------------
    print "@small_files";
}


#time
my $local_time = localtime();
my $time = time();
my $gm_time = gmtime();

my($sec, $min, $hour, $day, $mon, $year, $wday, $yday, $isdst) = localtime();
#mon 0-11
#year current-1900
#wday 0-6
$year += 1900;
$mon += 1;

#unlink(delete)

#mkdir(make dir)
#redir(delete dir)


