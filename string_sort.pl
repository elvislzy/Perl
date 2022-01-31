#!/user/bin/perl -w
use strict;

#index
my $stuff = "Howdy world!";
my $where = index($stuff, "wor"); # 6
print "\ninput string = \"$stuff\", where \"wor\" = $where\n";

my $where1 = index($stuff, "w"); #2
my $where2 = index($stuff, "w", $where1+1); #start from 2+1=3  6
my $where3 = index($stuff, "w", $where2+1); #start from 6+1=7 none -1

my $fred = "Yabba cabba doo!"; 
$where1 = rindex($fred, "abba"); #fine the last one 7
$where2 = index($fred, "abba", $where1-1); #start from 7-1=6 to 0 1
$where3= index($fred, "abba", $where2-1); #start from 1-1=0 to 0 none -1

#substr
my $mineral = substr("Fred J. Flintstone", 8, 5); #start from 8, length 5
my $long = "some very long string";
my $out = substr($long, -3, 2); #start from last 3 , length 2 "in"
my $right = substr($long, index($long, "l")) ; #index = 16, str 16-end

my $string = "Hello, world!";
substr($string, 0, 5) = "Goodbye"; #replace
print "\n$string\n\n";

substr($string, 0, 7) =~ s/goodbye/ByeBye/gi;
print "$string\n\n";

#sort
my @data_arrays = qw(4 2 10 23 7 40 30 20);
my @rise_arrays = sort {$a <=> $b} @data_arrays;
my @fall_arrays = sort {$b <=> $a} @data_arrays;
print "\n@data_arrays\n\n";
print "\n@rise_arrays\n\n";
print "\n@fall_arrays\n\n";

