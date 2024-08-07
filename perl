#!/usr/bin/perl -w

package main;

use warnings;
use strict;
use CAM::PDF;
use Getopt::Long;
use Pod::Usage;
use English qw(-no_match_vars);

our $VERSION = '1.60';

my %opts = (
            density    => undef,
            xdensity    => undef,
            ydensity    => undef,
            check      => 0,
            renderer   => 'CAM::PDF::Renderer::Dump',
            verbose    => 0,
            help       => 0,
            version    => 0,
            );

Getopt::Long::Configure('bundling');
GetOptions('r|renderer=s' => \$opts{renderer},
           'd|density=f'  => \$opts{density},
           'x|xdensity=f' => \$opts{xdensity},
           'y|ydensity=f' => \$opts{ydensity},
           'c|check'      => \$opts{check},
           'v|verbose'    => \$opts{verbose},
           'h|help'       => \$opts{help},
           'V|version'    => \$opts{version},
           ) or pod2usage(1);
if ($opts{help})
{
   pod2usage(-exitstatus => 0, -verbose => 2);
}
if ($opts{version})
{
   print "CAM::PDF v$CAM::PDF::VERSION\n";
   exit 0;
}

if (defined $opts{density})
{
   $opts{xdensity} = $opts{ydensity} = $opts{density};
}
if (defined $opts{xdensity} || defined $opts{ydensity})
{
   if (!eval "require $opts{renderer}")  ## no critic (StringyEval)
   {
      die $EVAL_ERROR;
   }
   if (defined $opts{xdensity})
   {
      no strict 'refs'; ## no critic(ProhibitNoStrict)
      my $varname = $opts{renderer}.'::xdensity';
      ${$varname} = $opts{xdensity};
   }
   if (defined $opts{ydensity})
   {
      no strict 'refs'; ## no critic(ProhibitNoStrict)
      my $varname = $opts{renderer}.'::ydensity';
      ${$varname} = $opts{ydensity};
   }
}

if (@ARGV < 1)
{
   pod2usage(1);
}

my $file = shift;
my $pagelist = shift;

my $doc = CAM::PDF->new($file) || die "$CAM::PDF::errstr\n";

foreach my $p ($doc->rangeToArray(1, $doc->numPages(), $pagelist))
{
   my $tree = $doc->getPageContentTree($p, $opts{verbose});
   if ($opts{check})
   {
      print "Checking page $p\n";
      if (!$tree->validate())
      {
         print "  Failed\n";
      }
   }
   $tree->render($opts{renderer});
}