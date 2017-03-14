#!  /usr/bin/env perl
use strict;
use warnings;
use DB_File;

my $dont_message_file = "dont_message";
my $twitters_file = "twitters.txt";
my $pokedex_file = "pokedex.txt";
my $selector_file = "selectors.txt";
my $five_minutes = 3*60;
require 'pokedex.pl';


my @pokedex = pokedex();
#my @typedefs = qw(@pokedex);
my @regexes = map { qr{$_} } @pokedex;

sub mainfunc {
print "Starting up\n";
while (1) {
    my %seen;
    my %contact_selector;
    LoadSelectors($selector_file, \%contact_selector);
    
    my @twitters = LoadTwitters($twitters_file);
    foreach my $twitter (@twitters) {
        tie %seen, "DB_File", "seen.db";
        my $twitter_url = "https://mobile.twitter.com/$twitter";
        print "$twitter_url\n";
        open (IN, "wget -qO- $twitter_url |");
        while (<IN>) {
            my $fullMessage = $_;
            $fullMessage =~ s|<.+?>||g;
            my ($name,$vi,$timeuntil) = (undef, 0,0,0);

            ($name,$vi,$timeuntil) = twitterMatch($_);
	    if (defined $name && /url="https?:\/\/(maps.google.com[^\"]+)/) {
	        my $url = $1;
            if (!defined $name) {
                #no pokemon found, but a map link found. warn JOEY
                my @warningContact;
                push @warningContact, 'Joey Elwell';
                SMS("no pokemon match found $fullMessage", @warningContact);

            }
		$name =~ s/[^A-Za-z]//g;
                my %pokemon = %{{
                    "name" => $name,
                    "vi" => $vi,
                    "twitter" => $twitter,
                    "url" => $url
                    }};
		if (!defined $vi) {
		    my $message = "$fullMessage is broken";
		    unless (defined $seen{$message}) {
			my @errorContacts;
                        push @errorContacts, 'Joey Elwell';
        		SMS("$fullMessage is broken", @errorContacts);
        		$seen{$message} = 1;
		    }
		}
		else {
		    my $message = "$name $vi% $url";
		    unless (defined $seen{$message}) {
			$seen{$message} = 1;
			print "    $name $vi\n";
			my @contacts;
			foreach my $contact (keys %contact_selector) {
			    if ($contact_selector{$contact}->(%pokemon)) {
				push @contacts, $contact;
			    }
			}
			if ($#contacts >= 0) {
			    SMS("$message $fullMessage", @contacts);
			}
		    }
		}
	    }
	}
	close IN;
        untie %seen;
    }
    sleep($five_minutes);
}

}

sub twitterMatch {
    my ($line) = @_;
    REGEX:
foreach my $regex (@regexes) {
    my $iv = undef;
  if ($line =~ $regex) {
    # found a pokemon so stop looking
    #  print "matched to $regex";
    if ($line =~ /(\d+\.\d+)\%/) {
        $iv = $1;
    }
    my $pokemon = $regex;
    $pokemon =~ s/[^A-Za-z]//g;
#    last REGEX; # Stop looking
    return ($pokemon, $iv, 0);
  }
}
return (undef, undef, undef);
}

sub SMS {
    my ($message,@contacts) = @_;
#    my ($sec, $min, $hour, $day, $mon, $year) = localtime(time);
#    if ($hour < 7) {
#        print "      sleeping hour < 7\n";
#        return;
#    }

    print "        message: $message\n";
    $message =~ s/'/"/g;
#    system("osascript mail.scpt '$message' ".join(" ",@emails));
#    my $buddy = "Joey Elwell";
    unless (-f $dont_message_file) {
        foreach (@contacts)
        {
            system("osascript -e 'tell application \"Messages\" to send \"$message\" to buddy \"$_\"'");
            print("osascript -e 'tell application \"Messages\" to send \"$message\" to buddy \"$_\"'\n");
        }
    } else {
        print "        ",join(",",@contacts),": found $dont_message_file file, will not send message\n";
    }
}

sub LoadTwitters {
    my ($file) = @_;
    open (IN, "<$file") || die("Unable to open $file:$!");
    my @twitters;
    while (<IN>) {
        chop;
        push @twitters, split /\s+/;
    }
    return @twitters;
}

sub LoadSelectors {
    my ($file, $selectors) = @_;
    open (SELECTOR, "<$file") || die("Unable to open $file:$!");
    while (<SELECTOR>) {
        chop;
        next if (/#/);
        my ($file, $contact) = split /\s*\|\s*/;
        LoadFunction($file, $contact, $selectors);
    }
    close SELECTOR;
}

sub LoadFunction {
    my ($file, $sms_name, $selectors) = @_;
    return unless (-f $file);
    open (FUNC, "<$file") || die("Unable to open $file:$!");
    my $buffer = "";
    while (<FUNC>) {
        $buffer .= $_;
    }
    close FUNC;
    my $func;
    eval $buffer;
    unless (defined $func) {
        print STDERR "ERROR $file $@\n";
    } else {
        $selectors->{$sms_name} = $func;
    }
}
