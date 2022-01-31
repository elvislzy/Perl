#!/usr/bin/perl


# if(-e $ARGV[0])
# {
#     $cmd = "copy $ARGV[0] $ARGV[0].bak";
#     # `$cmd`;
#     system($cmd);
# }
# else
# {
#     print "File does not exist.\n";
#     exit;
# }

# open(INPUT, "$ARGV[0].bak") or die "Cannot open file: $!\n";

# open(OUTPUT, '>$ARGV[0]');


# while(INPUT){

#     $_ =~ s/$ARGV[1]/$ARGV[2]/g;
#     print $_;
#     print OUTPUT $_;
# }

# close INPUT;
# close OUTPUT;


# command
# perl '-pi.bak' -e "s/1111111/7777777/gi" ./info.log        # replace 1111111 to 7777777 and generate .bak
# find ./ -name "*.txt" | xargs perl -pi.bak -e "s/aaa/bbb/giw