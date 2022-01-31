#!/user/bin/perl -w
use strict;

my $a = 1;
my $b = 2;
print "$a";

# ----------------------------
my $start_val = 100;
my $max_val = 20;
my @cases;
my $count = 0;
my $num = 10;

while($count < ($num + 1)) {
    my $case_id = $start_val + int(rand($max_val));
    print "\n case_id = $case_id \n";
    print "cases = @cases\n";
    print "count = $count\n";
    if(!(grep{$case_id =~ /^$_$/} @cases)) {    #grep expression list (search exp in list)
        push(@cases, $case_id);
        $count++;
    }
}

my @fruits = ("apple","a","apple","ab","aaa","aaaa","apple");
my $num_apple = grep{/^apple$/i} @fruits;
my $match_str = "apple";
my $num_apple2 = grep{$match_str =~ /^$_$/} @fruits;
my $num_apple3 = grep{/^$match_str$/} @fruits;
print "fruits = @fruits \n";
print "num1 = $num_apple\n";
print "num2 = $num_apple2\n";
print "num3 = $num_apple3\n";

# my $dir = "./example";
# my $out_dir = \$dir;
# $$out_dir =~ s/\$|/$//g;
# print $$out_dir;


my $folder = "./example";

if (-e $folder)
{
	printf "exist";
}
else
{
	printf "not exist";
}





