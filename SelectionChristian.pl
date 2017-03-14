#!  /usr/bin/env perl
use strict;
use warnings;
$func = sub {
    my %hash = @_;

    my $name = $hash{name};
    my $vi = $hash{vi};
    my $twitter = $hash{twitter};

    $name =~ y/A-Z/a-z/;
    $twitter =~ y/A-Z/a-z/;

    return unless (defined $name);

    my %name_always = ChrisMap(qw(
        mewtwo
        ho-oh
        Lugia
        Entei
        Raikou
        Zapdos
        Moltres
        Celebi
        Mew
        Articuno

        Unown
        ));
    my %name_ignore = ChrisMap (qw());
    my %twitters = ChrisMap (qw(PoGoRanchoPQ RanchoHillsHood));

    return unless (defined $twitters{$twitter});
    return if ($name_ignore{$name});
    return 1 if (defined $name_always{$name});
    return 1 if ($vi >= 100);
    return;
};

sub ChrisMap {
    my @keys = @_;
    my %hash;
    foreach my $key (@keys) {
        $key =~ y/A-Z/a-z/;
        $hash{$key} = 1;
    }
    return %hash;
}
