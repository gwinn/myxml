#####################################################
#
# Author: alex@lushpai.org
#
#####################################################

package MyXML::Generator;

use strict;
use utf8;

BEGIN {
  our $VERSION = 1.0.22;
}

sub gen_pair {
  # generate pair of tags e.g. <tag></tag>, and content between them.
  # optionally generate attributes e.g <tag id="someID">
  our ($self, $tag, $inner, $attr) = (shift, shift, shift, shift);
  our ($start_tag, $attribute, $end_tag, $class) = (
    undef,
    join(' ',  map { $_ } @{$attr}),
    join('', '</', $tag, '>'),
    ref($self) || $self
  );

  if ($attribute ne '') {
    $attribute=~s/\s+$//;
    $start_tag = join('', '<', $tag, ' ', $attribute, '>');
  } else {
    $start_tag = join('', '<', $tag, '>');
  };

  bless my $out = {"result" => join('', $start_tag, $inner, $end_tag)}, $class;

  return $out;

};

sub gen_single {
  # generate empty tag e.g. <tag/>.
  # optionally generate attributes e.g <tag id="someID">
  our ($self, $tag, $attr) = (shift, shift, shift);
  our ($start_tag, $attribute, $class) = (
    undef,
    join(' ',  map { $_ } @{$attr}),
    ref($self) || $self
  );

  if ($attribute ne '') {
    $attribute=~s/\s+$//;
    $start_tag = join('', '<', $tag, ' ', $attribute, '/>');
  } else {
    $start_tag = join('', '<', $tag, '/>');
  };

  bless my $out = {"result" => $start_tag},  $class;

  return $out;

};

1;
