#!/user/bin/perl -w
use strict;
use Data::Dumper;

my %scores = ("a", 78, "b", 98, "c", 89, "d", 90);
print Data::Dumper->Dump([\%scores], ['scores']);

my $val1 = $scores{'a'};
print "a = $val1\n\n";
print "b = $scores{'b'}\n\n";

#print "current env path = $ENV{PATH}\n\n";

#keys
my @names = keys %scores;
print "names = @names\n\n";
#values
my @values = values %scores;
print "values = @values\n\n";
#each
my $sum = 0;
while(my ($name, $score) = each %scores){
    print "name = $name\nscore = $score\n\n";
    $sum += $score;
}
#average
my $num = @names;
my $average = $sum/$num;
print "average = $average\n\n";
#exists
my $person = "a";
if (exists $scores{$person}) {
    print "$person is in the list\n\n";
}
#delete
delete $scores{$person};
print Data::Dumper->Dump([\%scores], ['scores']);








