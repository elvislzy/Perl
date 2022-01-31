#!/user/bin/perl -w
use strict;

$_ = "a";
if(/.?/) {
    print "\nMatching character 0 or 1 time except enter\n\n"
}

$_ = "\\\\\"Matching\"";
print "$_\n\n";

if(/\\+/) {
    print "Matching \"\\\\\" at least once\n\n"
}

if(/\\{2,}/) {
    print "Matching \"\\\\\" at least twice\n\n"
}

$_ = "goodgoodgoodbadbad";
if(/(good){2,4}/) {
    print "Matching \"good\" twice to forth\n\n";
}

if(/(bye)*/) {
    print "Matching \"bye\" any times\n\n";
}

$_ = "yabba dabba doc";
if(/y(....) d\1/) {                         #y(....)匹配y后面任意四个字符
    print "Matching \"yabba dabba\"\n\n";   #\1/反向引用，表示之前匹配的字符串 
}

$_ = "aa11bb";
if(/(.)\g{1}11/) {                  #g{1}=\1    
    print "Matching \"aa11\"\n\n";
}

#character string
$_ = "just for test";
if(/[a-zA-Z]/) {
    print "Matching \"a-z A-Z\"\n\n";
}

if(/[0-9]/) {
    print "Matching \"0-9\"\n\n";
}

if(/[^0-9]/) {
    print "Matching any character except 0-9\n\n";
}

if(/\w+\s+\w+\s+\w/) {
    print "Matching word + blank + word + blank + word\n\n";
}

#/[\dA-Fa-f]/  0-9 A-F a-f matching hex

print "1 or 2?\n\n";
chomp($_ = <STDIN>);
if(/1/i) {
    print "111\n\n";
}

















