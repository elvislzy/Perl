#!/user/bin/perl -w
use strict;


my $opt = 0;
my $localtime;
if (@ARGV >0) { #command parameter
    $opt = $ARGV[0];
}
else {
    print "Usage: perl $0 opt \n";
    print "Where opt = 0 or 1 \n";
    exit;
}

if ($opt == 1) {
    defined(my $pid = fork()) or die "Fork failured: $!\n";
    unless($pid) {
        print "This is child process.\n\n";
        $localtime = localtime();
        print "child: $localtime \n\n";
        sleep(3);
        print "close child after 3s\n\n";
        exit();
    }
    print "This is parent process.\n\n";
    waitpid($pid, 0); #wait until child process done
    $localtime = localtime();
    print "parent: $localtime \n\n";
    print "exit parent process \n\n";

}
else {
    defined(my $pid1 = fork()) or die "Fork failured: $!\n";
    unless($pid1) {
        print "This is child process.\n\n";
        $localtime = localtime();
        print "child: $localtime \n\n";
        sleep(3);
        print "close child after 3s\n\n";
        exit();
    }
    print "This is parent process.\n\n";
    $localtime = localtime();
    print "parent: $localtime \n\n";
    print "exit parent process \n\n";
}