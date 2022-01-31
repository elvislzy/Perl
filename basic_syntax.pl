#!/user/bin/perl -w
use strict;

my @array1 = qw{example for scalar and list context};
print "\narray = @array1 \n\n";

my @sorted = sort @array1;
print "sorted = @sorted \n\n";

print "sorted and scalar = " . scalar @sorted . "\n\n"; #binding use .

my $num = @array1;
print "number of elements = $num\n\n";

my @reversed = reverse @array1;
print "reversed = @reversed\n\n";

my $reverse_str = reverse @array1;
print "reverse_string = $reverse_str\n\n";