#!user/bin/perl -w
use strict;
# -----------------------------------------------------------------
# Filename: gen_area_report.pl                                             
# 
# Company: 
# Description:                                                     
# 
# 
#                                                                  
# Author: Elvis.Lu<lzyelvis@gmail.com>                            
# Create Date: 01/30/2022                                           
# Comments:                                                        
# 
# -----------------------------------------------------------------

my $file = "sim_log.txt";
my @all_lines;
my @alu_lines;
my @ram_lines;

my @element;
my $total_area = 0;
my $total_power = 0;
my $result = "";
my $out_file = "area_report.log";


open (LOG, "<", $file) or die "Can not open $file\n\n";

while(defined(my $line = <LOG>)) {
    chomp($line);
    push(@all_lines, $line);

    if($line =~ /^ALU/) {
        push(@alu_lines, $line);
    }
    if($line =~ /^RAM/) {
        push(@ram_lines, $line);
    }
}
close(LOG);

foreach(@all_lines) {
    print "$_\n";
    $result .= "$_\n";
    @element = split(/\s+/, $_);
    $total_area = $total_area + $element[1]*$element[2];
    $total_power = $total_power + $element[1]*$element[3];
}

my $ram_area = 0;
foreach(@ram_lines) {
    my @ram = split(/\s+/, $_);
    $ram_area = $ram_area + $ram[1]*$ram[2];
}


my $alu_power = 0;
foreach(@alu_lines) {
    my @alu = split(/\s+/, $_);
    $alu_power = $alu_power + $alu[1]*$alu[3];
}

my $ram_area_per = $ram_area / $total_area * 100;
my $alu_power_per = $alu_power / $total_power * 100;

print "total area: $total_area\n";
print "total power: $total_power\n";

print "ram area: $ram_area($ram_area_per%)\n";
print "alu power: $alu_power($alu_power_per%)\n";

$result .= "total area: $total_area\n";
$result .= "total power: $total_power\n";
$result .= "ram area: $ram_area($ram_area_per%)\n";
$result .= "alu power: $alu_power($alu_power_per%)\n";

open (IN , ">", $out_file) or die "Can not open $out_file for writing!\n";

print IN $result;

close(IN);

print "Finished";


# $str="test function of chomp\n";
# chomp($str);#去掉结尾的\n

# split(/\s+/,line)表示把字符串line,按空格为界分开
