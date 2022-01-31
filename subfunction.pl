#!/user/bin/perl -w
use strict;

sub display{
    print "sub function display\n\n";
}

&display();

&display;

my $val1 = 10;
my $val2 = 19;
my $max = &get_max_val($val1, $val2);
print "val1 = $val1 val2 = $val2 max = $max\n\n";

$max = &get_max_val(my $n, my $m);

sub get_max_val{
    my ($val1, $val2) = @_;
    if(!defined $val1 || !defined $val2){
        print "input undefined";
        exit;
    }
    return $val1 if ($val1 >= $val2);
    return $val2 if ($val1 < $val2);
}