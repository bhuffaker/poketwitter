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

    my %name_always;
    my %name_ignore = map { $_ => 1 } qw(Ponyta Venonat Hypno Machop Rhyhorn Chansey Exeggcute Exeggutor Ditto Charmander Primeape Arbok Nidorina Pidgeot Omastar Omanyte Bellsprout Jigglypuff Weepinbell Clefable Psyduck Drowzee Seel Kakuna Butterfree Parasect Staryu Starmie Pidgeotto Krabby Metapod Tentacool Horsea Marowak Raticate Caterpie Golbat Diglett Nidoran♂ Mankey Ekans Paras Growlithe Sandshrew Spearow Zubat Cubone Clefairy Voltorb Doduo Pidgey Golem Geodude Nidoran? Eevee Pinsir Rattata Abra Graveler Nidoran♀ Slowpoke Slowbro);

    return 1 if ($name_always{$name});
    return if ($name_ignore{$name});
    #return 1 if ($vi >= 100 or $vi <= 0);
    return 1 if ($vi >= 100);
    return;
};
