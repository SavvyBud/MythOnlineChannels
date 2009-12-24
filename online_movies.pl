#!/usr/bin/perl -w
#####################################################################
#
# download html from the following URL and parse for mms content and
# then build the online_movies.xml from it.
#
# 1. http://onlinevideochannel.blogspot.com/
#####################################################################
use strict;
package OnlineMovies;
use base "HTML::Parser";
use Data::Dumper;


sub text {
	my ($self,$text) = @_;
	#print $text;
}

sub start {
	my ($self, $tag, $attr, $attrseq, $origtext) = @_;
	if ($tag eq "a"){
		my $channel = $attr->{'channel'};
		if( $channel ) {
			my $href = $attr->{"href"};
			print $channel,",",$href , "\n";
		}
	}
}

sub end {
	my($self, $tag, $origtext) = @_;
	#print $tag;
}

my $p = new OnlineMovies;
$p->parse_file("/tmp/index.html");

