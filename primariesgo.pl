#!/usr/bin/perl -w

use strict;
use LWP::Simple;

use LWP::Simple;

my $command = shift;

if ($command eq 'config') {
  print <<EOF;
graph_title Prima de Riesgo
graph_vlabel prima
graph_category Economy
francia.label Francia
italia.label Italia
espana.label España
grecia.label Grecia
irlanda.label Irlanda
portugal.label Portugal
EOF
exit(0);
}

my @content = split(/\n/,get 'http://www.laprimaderiesgo.com/');
exit(1) unless @content;

for (@content) {
  if (/^.h2.([0-9]+)/i){
    print "espana.value $1\n";
  }
}

my @stuff = grep { /14px/ } grep { !/%/ } @content;

for (@stuff){
  s/\.//;
  s/^.*\s([a-zA-Z]+):\s+([0-9\.]+).*$/$1.value $2/;
  print lc;
  print "\n";
}

