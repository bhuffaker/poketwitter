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

    my %name_always = JoeyMap(qw(mewtwo ho-oh Lugia Entei Raikou Zapdos Moltres Celebi Mew Articuno Unown));

	my %name_ignore = JoeyMap(qw(Charmeleon Poliwag Dunsparce Oddish Pikachu Furret Ariados Magcargo Ledyba Ledian Gastly Gengar Haunter Hoppip Vulpix Ninetails Wobbuffet Chinchou Meowth Weedle Misdreavus Noctowl Nidorino Squirtle Bulbasaur Arcanine Aipom Hoothoot Sentret Totodile Natu Magikarp Teddiursa Marill Houndoom Phanpy Houndour Sudowoodo Sunkern Granbull Snubbull Azumarill Venomoth Spinarak Slugma Shellder Snubbull Shuckle Chikorita Crobat Cyndaquil Murkrow Teddiursa Swinub Ponyta Venonat Hypno Machop Rhyhorn Chansey Exeggcute Exeggutor Ditto Charmander Primeape Arbok Nidorina Pidgeot Omastar Omanyte Bellsprout Jigglypuff Weepinbell Clefable Psyduck Drowzee Seel Kakuna Butterfree
Parasect Staryu Starmie Pidgeotto Krabby Metapod Tentacool Horsea Marowak Raticate Caterpie Golbat Diglett Nidoran♂ Mankey Ekans Paras Growlithe Sandslash Sandshrew Spearow Zubat Cubone Clefairy Voltorb Doduo Pidgey
Golem Geodude Nidoran? Eevee Pinsir Rattata Abra Graveler Nidoran Nidoran♀ Slowpoke Slowbro));

    return 1 if ($name_always{$name});
    return if ($name_ignore{$name});
    #return 1 if ($vi >= 100 or $vi <= 0);
    return 1 if ($vi >= 100);
    return;
};

sub JoeyMap {
    my @keys = @_;
    my %hash;
    foreach my $key (@keys) {
	$key =~ y/A-Z/a-z/;
	$hash{$key} = 1;
    }
    return %hash;
}
