#!  /usr/bin/env perl
use strict;
use warnings;
$func = sub {
    my %hash = @_;

    my $name = $hash{name};
    my $vi = $hash{vi};
    my $twitter = $hash{twitter};
    my $timeuntil = $hash{timeuntil};

    return unless (defined $name);

    my %name_always = map { $_ => 1 } qw(
	Mewtwo
	Ho-Oh
        Lugia
	Entei
	Raikou
	Zapdos
	Moltres
	Celebi
	Mew
	Articuno

        Blissey
	Snorlax
        Rhydon
	Alakazam
	Gyarados
	Vaporeon Espeon
        Dratini Dragonair Dragonite
        Larvitar Pupitar Tyranitar

	Donphan
	Heracross
	Exeggutor
	Golem
	Flareon
	
        );
#    my %name_ignore = map { $_ => 1 } qw(Arcanine Bellsprout Cubone Diglett Doduo Exeggcute Makey Nidoqueen NidoranFemale NidoranMale Nidorino♂ Nidoran♀ Parasect Pidgeot Ponyta Primeape Sandshrew);
    my %name_ignore;
    my %twitter = map { $_ => 1 } qw(PoGoUTC PoGoLaJolla PoGoGaslamp SeaportDowntown Laprasnado);
    
    return unless ($twitter{$twitter});
    return 1 if ($name_always {$name});
    return 1 if (($vi >= 100 or $vi == 0) and !defined $name_ignore{$name});
    return;
};
