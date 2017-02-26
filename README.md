# poketwitter
############
# Don't Send SMS
############
If you create a dont_sms file in the director, it will print to STDOUT
matches, but will not send a sms message

############
# file:twitters.txt
# This file contains the list of twitters to follow
############
# format: twitterName 
PoGoGoLand
PoGoGoLander

############
# file:selectors.txt
# This file contains the list of files with selection functions 
# and the contact that matches them.
############
# format: filename | contact
SelectionJohnSmith.pl | John Smith

##############
# file: SelectionName.pl
# This contains selection code.  It can really be named anything.
# The filename does not need to contain the contact
##############
$func = sub {
    my %hash = @_;

    my $name = $hash{name};
    my $vi = $hash{vi};
    my $twitter = $hash{twitter};
    my $timeuntil = $hash{timeuntil};

    ##### Do something ####
};
