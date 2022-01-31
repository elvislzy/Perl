#!/user/bin/perl -w
use strict;

#split
my @fields = split /:/, "abc:def:g:h";
print "obtained list = @fields\n\n";

#join
my $x = join ":", 4, 6, 8, 10, 12;
print "join \"$x\"\n";

my @values = split /:/, $x;
print "split \"@values\"\n\n";

my $test = "Hello there, neighor";
my($first, $second, $third) = $test =~ (/(\S+) (\S+), (\S+)/);
print "first = $first, second = $second, third = $third\n\n";

#unless   execute when falie condition
my $fred = "45";
unless ($fred =~ /^[A-Z_]\w*$/i) { #A-Z_ at begin  w* at the end
    print "\ndoesn't matched\n\n";
}

#until      execute until condition true
my $j = 1;
my $i = 20;
until ($j > $i) {
    $j *= 2;
    print "j = $j\n\n";
}

#elsif = else if in c   

#for
for (my $i =0; $i < 2; $i++) {
    print "i = $i \n";
    for(2..4) {
        last if ($_ == 3);
        print "i = $i, j = $_\n";
    }
}

#label
print "\n===========================\n";
FOR_LOOP: for (my $i =0; $i < 2; $i++) {
    print "i = $i \n";
    for(2..4) {
        last FOR_LOOP if ($_ == 3);
        print "i = $i, j = $_\n";
    }
}

