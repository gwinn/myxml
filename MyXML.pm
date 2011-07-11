#####################################################
#
# Author: alex@lushpai.org
#
#####################################################

package MyXML;

use strict;

BEGIN {
	our $VERSION = 1.0.21;
	require MyXML::Generator;
	require MyXML::Excel;
	require MyXML::Parser;
}

sub GXMW {
	#generate XML header for web
	my ($self,$ver,$enc,$xsl) = (shift,shift,shift,shift);
	my $header = {
		'header' => 'Content-type: text/xml; charset=utf-8',
		'declaration' => '<?xml version="'.$ver.'" encoding="'.$enc.'"?>',
		'stylesheet' => '<?xml-stylesheet type="text/xsl" href="/files/xsl/'.$xsl.'.xsl"?>',
		};
	bless $header, $self;
	return $header;
};

sub GXMF {
	#generate XML header for file
	my ($self,$ver,$enc) = (shift,shift,shift);
	my $header = {
		'declaration' => '<?xml version="'.$ver.'" encoding="'.$enc.'"?>',
		};
	bless $header, $self;
	return $header;
};

1;
