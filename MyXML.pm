#####################################################
#
# Author: alex@lushpai.org
#
#####################################################

package MyXML;

use strict;
use utf8;

BEGIN {
  our $VERSION = 1.0.22;
  require MyXML::Generator;
}

sub gen_header {
  #generate XML header for web
  my ($self, $xslt, $ver, $enc, $xsl) = (shift, shift, shift, shift, shift);
  my $header = {
    'declaration' => '<?xml version="'.$ver.'" encoding="'.$enc.'"?>',
  };

  $header{'header'}     = 'Content-type: text/xml; charset=utf-8' if $xslt;
  $header{'stylesheet'} = '<?xml-stylesheet type="text/xsl" href="/files/xsl/'.$xsl.'.xsl"?>' if $xslt;

  bless $header, $self;
  return $header;
};

1;
