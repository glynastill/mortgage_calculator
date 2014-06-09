#!/usr/bin/perl

# Glyn Astill <glyn@8kb.co.uk> 11/10/2011

use strict;
use Getopt::Long qw/GetOptions/;
Getopt::Long::Configure('no_ignore_case');

my $debug = 0;
my $USAGE = '-m <mortgage value> -a <arrangement fee> -i <interest rate>';

my $mortgage_value;
my $arrangement_fee;
my $interest_rate;
my $interest_rate_term;
my $monthly_payment;
my $term;
my $interest_rate_increase;
my $cap_rate_increase;
my $monthly_overpayment;

my $year;
my $month;

my $total_mortgage;
my $monthly_interest;
my $month_value;
my $total_paid;
my $interest_accrued;

##http://www.perl.com/doc/manual/html/lib/Getopt/Long.html
use vars qw{%opt};
die $USAGE unless 
	GetOptions(\%opt,
		   'mortgage_value|m=n',
		   'arrangement_fee|a=n',
		   'interest_rate|i=f',
		   'interest_rate_term|it=n',
		   'term|t=n',
		   'interest_rate_increase|ii=f',
		   'cap_rate_increase|ic=f',
		   'monthly_overpayment|o=n',
		   'monthly_payment|p=n',
		   )
	and keys %opt
	and ! @ARGV;
	
## initial call ... $ARGV[0] and $ARGV[1] are the command line arguments

$mortgage_value = $opt{mortgage_value};
$arrangement_fee = ($opt{arrangement_fee} // 0);
$interest_rate = ($opt{interest_rate} // 5);
$interest_rate_term = ($opt{interest_rate_term} // 1);
$monthly_payment = ($opt{monthly_payment} // 0);
$term = ($opt{term} // 25);
$interest_rate_increase = ($opt{interest_rate_increase} // 0);
$cap_rate_increase = $opt{cap_rate_increase};
$monthly_overpayment = ($opt{monthly_overpayment} // 0);

$total_mortgage = $mortgage_value+$arrangement_fee;
$monthly_interest = ($interest_rate/100)/12;

$month_value = $total_mortgage;
if (! $monthly_payment) {
	$monthly_payment = (($month_value*$monthly_interest)/(1-((1+$monthly_interest)**($term*12*-1))));
}

print "\nMortgage value: ",$mortgage_value,"\n";
print "Arrangement fee added on: ",$arrangement_fee, "\n";
print "Term: ", $term, " year(s)\n";
print "Interest rate: ",$interest_rate, "% (Monthly rate = ", $monthly_interest, "%)\n";
print "Interest rate term: ",$interest_rate_term, " years\n";
print "Initial monthly payment: ", sprintf("%.2f", $monthly_payment) ,"\n";
print "After initial term rate jumps by: ",$interest_rate_increase,"%\n";
print "Cap rate jumps at: ",$cap_rate_increase,"%\n" if ($cap_rate_increase);
print "---------------------------------------\n";
print "Total mortgage value: ",$total_mortgage,"\n";
print "---------------------------------------\n\n";

do_it: {
	for ($year = 1; $year < $term; $year++) {
		if ($year > $interest_rate_term) {
			if ((! $cap_rate_increase) || ($interest_rate < $cap_rate_increase)) {
				$interest_rate = $interest_rate + $interest_rate_increase;
			 	if ($interest_rate < 0) {
					$interest_rate=0.0000000001;
				}
				elsif ($cap_rate_increase && ($interest_rate > $cap_rate_increase)) {
					$interest_rate = $cap_rate_increase;
				}	
				$monthly_interest = ($interest_rate/100)/12;
				$monthly_payment = (($month_value*$monthly_interest)/(1-((1+$monthly_interest)**(($term-$year)*12*-1))));
			}
		}

		for ($month = 1; $month <= 12; $month++) {		
			$month_value = $month_value+($month_value*$monthly_interest)-($monthly_payment+$monthly_overpayment);
			$total_paid = $total_paid + $monthly_payment + $monthly_overpayment;
			$interest_accrued = $interest_accrued + ($month_value*$monthly_interest);
			if (($month == 12) || ($month_value <= 0)){
				print "End of year ", pack("A5",$year);
				print "Mortgage: ", pack("A11",sprintf("%.2f", $month_value));
				print "Total paid: ", pack("A11", sprintf("%.2f", $total_paid));
				print "Total interest: ", pack("A11", sprintf("%.2f", $interest_accrued));
				print " (Rate ", $interest_rate, "%, Monthly Payment ", sprintf("%.2f", $monthly_payment);

				if ($monthly_overpayment > 0) {
					print " Overpayment ", sprintf("%.2f", $monthly_overpayment);
				}

				print ")\n";
				
				if ($month_value <= 0) {
					print "Paid off in month ", $month, " of year ", $year, "\n";
					last do_it;
				}

			}
		}
	 }
 }
 
__END__
