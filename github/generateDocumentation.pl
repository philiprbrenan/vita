#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Use pycco to create some documentation
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2020
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);

my $home    = q(/home/phil/vita/minimum/);                                      # Home folder
my $modules = fpd($home, q(modules));                                           # Modules folder
my $tests   = fpd($home, q(tests));                                             # Test programs
my $docs    = fpd($home, q(docs));                                              # Output documentation

makePath($docs);
clearFolder($docs, 99);

my @files = searchDirectoryTreesForMatchingFiles($modules, $tests, qw(.py));    # Modules to document
my $files = join ' ', @files;

say STDERR qx(/home/phil/.local/bin/pycco -d $docs -ie $files);
