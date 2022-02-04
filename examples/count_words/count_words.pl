#!user/bin/perl -w
use strict;
# -----------------------------------------------------------------
# Filename: count_words.pl                                             
# 
# Company: 
# Description:                                                     
# 
# 
#                                                                  
# Author: Elvis.Lu<lzyelvis@gmail.com>                            
# Create Date: 02/03/2022                                           
# Comments:                                                        
# 
# -----------------------------------------------------------------
my $file_name = "words.txt";
my @all_lines;
my @list;
my %dict;

open (IN, "<", "$file_name") or die "Can not open $file_name for reading!\n";

while(defined(my $line = <IN>)) {
    chomp($line);
    push(@all_lines, $line);
}

foreach(@all_lines) {
    $_ =~ tr/a-zA-Z/ /cs;
    $_ =~ s/^\s+//;
    $_ =~ s/\s+$//;
    @list = split(/\s+/, $_);

    foreach my $word (@list) {
        $dict{lc($word)}++;
    }
}

close(IN);

foreach my $a(sort keys %dict){
    print "$a: $dict{$a} \n";
}

# $string =~ tr/\d/ /c;     # 把所有非数字字符替换为空格
# $string =~ tr/\t //d;     # 删除tab和空格
# $string =~ tr/0-9/ /cs    # 把数字间的其它字符替换为一个空格。

# print "$array[0]"


