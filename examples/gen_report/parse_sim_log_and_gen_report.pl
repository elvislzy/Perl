#!user/bin/perl -w
use strict;
# -----------------------------------------------------------------
# Filename: parse_sim_log_and_gen_report.pl                                             
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
use Getopt::Long;
use Spreadsheet::WriteExcel;

my $log_dir = "./out";
my $report_file = "simulation_report.log";
my $verbose = 0;
my $debug = 0;
my $help = 0;
my $tab = " "x4;
my $excel_en = 0;
my $info = "[INFO]  --";
my $error = "[ERROR]  --";
my @pass_cases;
my @fail_cases;
my @unknow_cases;

#parse input options
GetOptions(
    'log_dir=s'         => \$log_dir,
    'excel!'            => \$excel_en,
    'verbose!'          => \$verbose,
    'debug!'            => \$debug,
    'help!'             => \$help,
);

&help_message if $help;
&parse_sim_logs($log_dir);
&gen_report($report_file);

sub parse_sim_logs {
    my $sim_dir = shift;
    print "\n${info} Start to parse the simulation log files in $sim_dir \n\n";
    my @sim_files;

    opendir DH, $sim_dir or die "Cannot open $sim_dir for reading!\n";
    while(my $name = readdir DH) {
        $name = "${sim_dir}/${name}";
        push(@sim_files, $name) if $name =~ /\.log$/;
    }
    closedir DH;

    if(!defined $sim_files[0] || $sim_files[0] =~ /^\s*$/) {
        print "${error} Do not obtain valid simulation log files. Exiting..\n\n";
        exit;
    }

    foreach my $sim_file (@sim_files) {
        my $case_id;
        my $status;
        open (SIM, "<", $sim_file) or die "Can not open $sim_file for reading~ \n\n";
        while (defined (my $line = <SIM>)) {
            $line =~ s/^\s*|\s*$//g;
            if($line =~ /^#\s*test_id\s*:\s*(\d+)/) {
                $case_id = $1;
            }
            elsif ($line =~ /^#\s*test_status\s*:\s*(\w+)/) {
                $status = $1;
                $status =~ s/^\s*|\s*$//g;
                last;
            }
        }

        if(defined $case_id && defined $status) {
            if($status =~ /^pass$/i) {
                push(@pass_cases, $case_id);
            }
            elsif($status =~ /^fail$/i) {
                push(@fail_cases, $case_id);
            }
            else {
                push(@unknow_cases, $case_id);
            }
        }
        close(SIM);
    }
    print "${info} Complete to parse the simulation log files \n\n";
}

sub gen_report {
    my $out_file = shift;
    if(!$excel_en) {
        &gen_txt_report($out_file);
    }
    else {
        &gen_excel_report($out_file);
    }
    
}

sub gen_txt_report {
    my $out_file = shift;
    my $result = "";
    my $pass_rate;
    my $fail_rate;
    my $pass_num = 0;
    my $fail_num = 0;
    my $unknown_num = 0;
    my $case_num = 0;

    print "${info} Start to generate summary report \n\n";

    $pass_num = @pass_cases if defined $pass_cases[0];
    $fail_num = @fail_cases if defined $fail_cases[0];
    $unknown_num = @unknow_cases if defined $unknow_cases[0];
    $case_num = $pass_num + $fail_num + $unknown_num;
    my $len = length($case_num);

    if($case_num == 0) {
        print "${error} Do not obtain any test cases' result. Exiting...\n\n";
        exit;
    }

    $pass_rate = $pass_num / $case_num;
    $fail_rate = $fail_num / $case_num;

    $result .= "\n";
    $result .= "#"x80 . "\n"; 
    $result .= "# Simulation report for project 1 \n"; 
    $result .= "#"x80 . "\n"; 
    $result .= "${tab}Total cases: $case_num \n"; 
    $result .= "${tab}Passed cases: $pass_num \n"; 
    $result .= "${tab}Failed cases: $fail_num \n"; 
    $result .= "${tab}Pass rate = " . sprintf("%${len}d", $pass_num) . " / $case_num "; 
    $result .= "= " . sprintf("%4.2f", $pass_rate) . "\n"; 
    $result .= "${tab}Fail rate = " . sprintf("%${len}d", $fail_num) . " / $case_num "; 
    $result .= "= " . sprintf("%4.2f", $fail_rate) . "\n"; 
    $result .= "\n"; 

    if($pass_num > 0) {
        $result .= "${tab}The following $pass_num test cases passed:\n";
        $result .= &print_array_by_len(\@pass_cases, 15);
        $result .= "\n";
    }

    if($fail_num > 0) {
        $result .= "${tab}The following $fail_num test cases failed:\n";
        $result .= &print_array_by_len(\@fail_cases, 15);
        $result .= "\n";
    }

    if($unknown_num > 0) {
        $result .= "${tab}The following $unknown_num test cases failed:\n";
        $result .= &print_array_by_len(\@unknow_cases, 15);
        $result .= "\n";
    }

    open (OUT, ">", $out_file) or die "Can not open $out_file for writing!\n";
    print OUT $result;
    close(OUT);

    print $result;

    print "${info} Report has been written into $out_file \n\n";

}

sub print_array_by_len {
    my ($ref, $len) = @_;
    my $str = "${tab}${tab}";
    my $num = 0;

    foreach my $item (@$ref) {
        if($num > 0 && $num % $len == 0) { #$len element each line
            $str .= "\n${tab}${tab}";
            $num = 0;
        }

        $str .= "${item} ";
        $num += 1;

    }

    $str .= "\n\n";
    return $str;

}

sub help_message{
    print "\nUsage: perl $0 OPTIONS\n";
    print "OPTIONS:\n";
    print "-"x50 . "\n";
    print "${tab}-log_dir dir_name  --  specify the dir that save the simulation log files.\n";
    print "${tab}                       Default is ./out\n";
    print "${tab}-excel             --  generate excel report.\n";
    print "${tab}                       Default is txt report\n";
    print "${tab}-help              --  print help message\n";
    print "${tab}-debug/-verbose    --  control to output debug information\n\n";
    print "-"x50 . "\n";
    print "Author:\n";
    print "${tab}Elvis.Lu<lzyelvis\@gmail.com>\n\n";
    exit;

}

sub gen_excel_report {
    my $out_name = shift;
    print "${info} Start to generate excel report\n\n";

    $out_name =~ s/^(.*)\.\w+$/${1}\.xls/; # ${1} = x, when  original file name is x.log
    my $excel_out = Spreadsheet::WriteExcel->new($out_name);
    my $worksheet = $excel_out->add_worksheet();
    my $format = $excel_out->add_format();

    my %col;

    $format->set_bold();
    $format->set_color('red');
    $format->set_align('center');

    my $red_format = $excel_out->add_format (
        color => 'red',
        align => 'vcenter',
    );

    my $gre_format = $excel_out->add_format (
        color => 'green',
        align => 'vcenter',
    );

    my $head_format = $excel_out->add_format (
        bold => 1,
        size => 12,
        color => 'blue',
        align => 'vcenter',
    );

    $col{"case_id"}     = 0;
    $col{"description"} = 1;
    $col{"note"}        = 2;
    $col{"test_status"} = 3;

    foreach my $key (keys %col) {
        my $col_num = $col{"$key"};
        $worksheet->write(0, $col_num, $key, $head_format);
    }

    my $row_num = 1;
    if(@pass_cases > 0) {
        foreach my $case (@pass_cases) {
            $case = "case_${case}" if $case =~ /^\d+$/;
            $worksheet->write($row_num, $col{"case_id"}, $case);
            $worksheet->write($row_num, $col{"test_status"}, "PASS", $gre_format);
            $row_num ++;
        }
    }

    if(@fail_cases > 0) {
        foreach my $case (@fail_cases) {
            $case = "case_${case}" if $case =~ /^\d+$/;
            $worksheet->write($row_num, $col{"case_id"}, $case);
            $worksheet->write($row_num, $col{"test_status"}, "FAIL", $red_format);
            $row_num ++;
        }
    }

    if(@unknow_cases > 0) {
        foreach my $case (@unknow_cases) {
            $case = "case_${case}" if $case =~ /^\d+$/;
            $worksheet->write($row_num, $col{"case_id"}, $case);
            $worksheet->write($row_num, $col{"test_status"}, "UNKNOW", $red_format);
            $row_num ++;
        }
    }

    print "${info} Excel report has been generated\n\n";    

}