#!/user/bin/perl -w
use strict;

$_ = "Fire box hahaha \nFly 123";
if(/fire.*fly/si) { #/s matching \n, /i matching both upper and lower
    print "Matching \"fire.....fly\"\n\n";
}

#Matching position
$_ = "it is just a test";
if(/^just/) {
    print "Matching \"just\" at the begining\n\n";
}

if(/^it.*test$/) {  #^-begining $-end
    print "Matching \"it\" at the begining and \"test\" at the end\n\n";
}

$_ = "called fred and so ...";
if(/\bfred\b/) {  #fred should be a single word("abcfredabc" won't be matched)
    print "Matching \"fred\"\n\n";
}

my $val = "just test it";
if($val =~ /^just.*it$/) {
    print "Matching just it in val\n\n";
}

my $val1 = "just";
my $val2 = "This is just a test";
if($val2 =~ /($val1)/) {
    print "Matching val1 in val2\n\n";
}

#Match the variables
$val = "hello there, neighbor";
if($val =~ /(\w+)\s*(\w+),\s*(\w+)/) {
    print "\n v1 = $1, v2 = $2, v3 = $3\n\n";
    $val2 = $2;
}

$val = "hell world 1000 times";
if($val =~ /(\d+)\s*(\w+)/) {
    print "\n v1 = $1, v2 = $2\n\n";
}

#Named Captures
my $names = 'Fred or Barney';
if($names =~ m/(?<name1>\w+) (?:and|or) (?<name2>\w+)/) {
    print "name1 = $+{name1}, name2 = $+{name2}\n\n";
}

#Automatic Match Variables
if("Hello there, neighbor" =~ /\s(\w+),/) {
    print "Matching ($`)($&)($').\n\n";
}

#Replace s/// 
$_ = "home, sweet home";
s/home/cave/;
print "after replacement: \"$_\"\n\n";

$_ = "home, sweet home";
s/home/cave/g;
print "after globle replacement: \"$_\"\n\n";

$_ = "I saw Barney with Fred";
print "origin: $_\n";
s/(\w+) with (\w+)/\U$2\E with $1/i;
print "after: $_\n\n";

