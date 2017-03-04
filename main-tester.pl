#!  /usr/bin/env perl
use strict;
use warnings;
require 'poketwitter.pl';

print "starting up\n";
my $func;
my %testmap;

#SanteePogo
$testmap{"Diglett"} = ["100.0", <<EOF];
      <div class="dir-ltr" dir="ltr">  unknown: Diglett ♀ 100.0% (15/15/15, Mud Slap/Mud Bomb) til 13:41:43 (29m 43s). <a href="https://t.co/EQyFFdkE53"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=32.80556746543448,-116.96698345052191"data-url="http://maps.google.com/maps?q=32.80556746543448,-116.96698345052191"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=32.80556746543448,-116.96698345052191">maps.google.com/maps?q=32.8055…</a>
EOF
#PokeGo92116
$testmap{"Wobbuffet"} = ["31.1", <<EOF];
      <div class="dir-ltr" dir="ltr">  Wobbuffet (31.1% - Splash/unknown) appeared until 01:23:39pm (29m 45s)! <a href="https://t.co/f2HKe44PuK"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=32.763739780497886,-117.12027076904897"data-url="http://maps.google.com/maps?q=32.763739780497886,-117.12027076904897"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=32.763739780497886,-117.12027076904897">maps.google.com/maps?q=32.7637…</a>
EOF
#OceansidePogo
$testmap{"Chansey"} = ["35.6", <<EOF];
      <div class="dir-ltr" dir="ltr">  Loma Alta: Chansey ♀ 35.6% (9/7/0, Pound/Hyper Beam) til 14:47:10 (22m 35s). <a href="https://t.co/tdycnjSkTh"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=33.19677956038059,-117.35627659706995"data-url="http://maps.google.com/maps?q=33.19677956038059,-117.35627659706995"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=33.19677956038059,-117.35627659706995">maps.google.com/maps?q=33.1967…</a>
EOF
#BalboaParkHills
$testmap{"Totodile"} = ["91.1", <<EOF];
      <div class="dir-ltr" dir="ltr">  Balboa Park: Totodile ♂ 91.1% (11/15/15, Scratch/Aqua Jet) til 14:03:48 (23m 38s). <a href="https://t.co/ntWGiKbPPu"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=32.72636077480753,-117.15418650797359"data-url="http://maps.google.com/maps?q=32.72636077480753,-117.15418650797359"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=32.72636077480753,-117.15418650797359">maps.google.com/maps?q=32.7263…</a>
EOF
#NastyCityPoGo
$testmap{"Chikorita"} = ["91.1", <<EOF];
      <div class="dir-ltr" dir="ltr">  Mount Hope: Chikorita 91.1% (13/15/13, Vine Whip/Grass Knot) til 10:41:13 (16m 19s). <a href="https://t.co/LCfs6ygQLp"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=32.71476163575178,-117.1135604892476"data-url="http://maps.google.com/maps?q=32.71476163575178,-117.1135604892476"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=32.71476163575178,-117.1135604892476">maps.google.com/maps?q=32.7147…</a>
EOF
#LakeElsinoreGO
$testmap{"Larvitar"} = ["33.3", <<EOF];
      <div class="dir-ltr" dir="ltr">  Lake Elsinore: Larvitar♂ 33.3% (2/0/13, Bite/Ancient Power) til 14:35:44 (21m 58s). <a href="https://t.co/Q7IrAcc1iy"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=33.688595206347244,-117.39850594866056"data-url="http://maps.google.com/maps?q=33.688595206347244,-117.39850594866056"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=33.688595206347244,-117.39850594866056">maps.google.com/maps?q=33.6885…</a>
EOF
#BadContent
$testmap{"broken"} = ["33.3", <<EOF];
      <div class="dir-ltr" dir="ltr">  New News! yaya <a href="https://t.co/Q7IrAcc1iy"rel="nofollow noopener"dir="ltr"data-expanded-url="http://maps.google.com/maps?q=33.688595206347244,-117.39850594866056"data-url="http://maps.google.com/maps?q=33.688595206347244,-117.39850594866056"class="twitter_external_link dir-ltr tco-link"target="_blank"title="http://maps.google.com/maps?q=33.688595206347244,-117.39850594866056">maps.google.com/maps?q=33.6885…</a>
EOF

FOREACHLOOP:
foreach my $validName (keys %testmap) {
    my ($name,$iv,$timeuntil) = twitterMatch($testmap{$validName}[1]);
    if (!defined $name) {
        print "no pokemon matched\n";
        next FOREACHLOOP;
    }
    print "$validName :  $name\n";
    print "$testmap{$validName}[0] :  $iv\n";

}
