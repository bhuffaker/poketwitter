#!  /usr/bin/env perl
use strict;
use warnings;

my %func;
LoadFunction ("SelectionBrad.pl", "Brad", \%func);
LoadFunction ("SelectionJoey.pl", "Joey", \%func);
foreach my $pokemon (
    ["Chansey", "10", "10", "PoGoUTC"],
    ["Makey", "2000", "10", "Nowhere"],
    ["Makey", "2000", "10", "PoGoGaslamp"],
    ["Makey", "200", "100", "PoGoGaslamp"],
    ["Select", "200", "100", "PoGoGaslamp"]
    ) {
    my ($name, $cp, $vi, $twitter) = @$pokemon;
    my %pokemon = %{{
        "name" => $name,
        "cp" => $cp,
        "vi" => $vi,
        "twitter" => $twitter
        }};
    my %contacts;
    foreach my $sms_name (keys %func) {
        if ($func{$sms_name}->(%pokemon)) {
            $contacts{$sms_name} = 1;
        }
    }
    my @contacts = keys %contacts;
    print join(" ", @$pokemon, ":", @contacts),"\n";
}


sub LoadFunction {
    my ($file, $sms_name, $func_hash) = @_;
    return unless (-f $file);
    open (IN, "<$file") || die("Unable to open $file:$!");
    my $buffer = "";
    while (<IN>) {
        $buffer .= $_;
    }
    close IN;
    my $func;
    eval $buffer;
    unless (defined $func) {
        print STDERR "ERROR $file $@\n";
    } else {
        $func_hash->{$sms_name} = $func;
    }
} 

