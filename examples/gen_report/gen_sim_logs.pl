#!user/bin/perl -w
use strict;
# -----------------------------------------------------------------
# Filename: gen_sim_logs.pl                                             
# 
# Company: 
# Description:                                                     
# 
# 
#                                                                  
# Author: Elvis.Lu<lzyelvis@gmail.com>                            
# Create Date: 01/28/2022                                           
# Comments:                                                        
# 
# -----------------------------------------------------------------

my $ref_log_file = "ref_simv.log";
my $ref_log = "";
my $out_dir = "./out";
my $log_num = 50;
my $tab = " "x4;
my $verbose = 0;
my $debug = 0;
my $info = "[INFO]  --";

print "\n";

&obtain_ref_log($ref_log_file);

&gen_log_files($ref_log, $log_num, $out_dir);

sub obtain_ref_log {
    my $file = shift;
    open (LOG, "<", $file) or die "Can not open $file for reading!\n";

    while(defined(my $line = <LOG>)) {
        $ref_log .= $line;
    }
    close(LOG);

    print "${info}Finished reading reference log file\n\n";
}

sub gen_log_files {
    my ($log, $num, $dir) = @_;
    my $start_val = 2000;
    my $max_val = 500;
    my @cases;
    my $count = 0;

    print "${info} Start to generate $num log files\n\n";

    &adjust_out_dir($dir);

    while($count < ($num +1)) {
        my $case_id = $start_val + int(rand($max_val));

        if(! (grep{$case_id =~ /^$_$/} @cases)) {
            push(@cases, $case_id);
            $count ++;
            &gen_one_log_file($case_id, $log, $dir);
        }
    }

    print "${info}Finished to generate $num log files into $dir\n\n";
}

sub gen_one_log_file {
    my ($id, $log, $dir) = @_;
    my $sim_file = "${dir}/sim_${id}.log";
    my $result = $log;
    my $status;
    my $max_val = 4000;
    my $rand_val = int(rand($max_val));

    $status = "Pass" if ($rand_val > ($max_val / 5));
    $status = "Fail" if ($rand_val <= ($max_val / 5));

    $result .= "\n";
    $result .= "# " . "="x30 . "\n";
    $result .= "# test_id       : $id\n";
    $result .= "# test_status   : $status\n";
    $result .= "# " . "="x30 . "\n";

    open (OUT, ">", $sim_file) or die "Can not open $sim_file for writing~\n";

    print OUT $result;
    close(OUT);

}

sub adjust_out_dir {
    my $dir_ref = shift;

    if(-e $dir_ref) {
        unlink glob("$dir_ref/*");
        # system("rm -rf $dir_ref/*");
    }
    else {
        mkdir "$dir_ref", 0755 or die "Can not create $dir_ref dir!\n";
        print "${tab}Created dir $dir_ref\n\n";
    }
}