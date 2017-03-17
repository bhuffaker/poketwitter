#!  /usr/bin/env perl
use strict;
use warnings;
$func = sub {
    my %hash = @_;

    my $name = $hash{name};
    my $vi = $hash{vi};
    my $twitter = $hash{twitter};
    my $timeuntil = $hash{timeuntil};

    $name =~ y/A-Z/a-z/;
    $twitter =~ y/A-Z/a-z/;

    return unless (defined $name);

    my %name_always = BradMap(qw(
	mewtwo
	ho-oh
        Lugia
	Suicune
	Entei
	Raikou
	Zapdos
	Moltres
	Celebi
	Mew
	Articuno
	Venusaur

	NINETALES
	FARFETCHD
	POLIWRATH
	MUK
	KANGASKHAN
	ELECTRODE
	HITMONLEE
	POLIWRATH
	KOFFING
	WEEZING
	STARMIE
	MR-MIME
	JYNX

	FLAAFFY
	BELLOSSOM
	POLITOED
	JUMPLUFF
	SUNFLORA
	UNOWN
	GIRAFARIG
	Steelix
	SCIZOR
	HERACROSS
	Corsola
	Delibird
	Kingdra
	Smeargle
	Tyrogue

	
        Blissey
	Snorlax
        Rhydon
	Alakazam
	Gyarados
	Vaporeon Espeon
        Tyranitar

	Heracross
	Exeggutor
	Golem
	Flareon

	meganium
	
        ));
#    my %name_ignore = map { $_ => 1 } qw(Arcanine Bellsprout Cubone Diglett Doduo Exeggcute Makey Nidoqueen NidoranFemale NidoranMale Nidorino♂ Nidoran♀ Parasect Pidgeot Ponyta Primeape Sandshrew);
    my %name_ignore = BradMap(qw( Machop Magikarp Pidgeo parasect ));
    my %twitter = BradMap(qw(PoGoUTC PoGoLaJolla PoGoGaslamp SeaportDowntown Laprasnado));

    return 1 if ($vi >= 100 && $name_always{$name});
    return unless ($twitter{$twitter});
    return 1 if ($name_always{$name});
    return if (defined $name_ignore{$name});
    return 1 if ($vi >= 97 or $vi == 0);
    return;
};

sub BradMap {
    my @keys = @_;
    my %hash;
    foreach my $key (@keys) {
	$key =~ y/A-Z/a-z/;
	$hash{$key} = 1;
    }
    return %hash;
}
