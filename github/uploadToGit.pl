#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Upload all files to GitHub  _
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2020
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);

my $home = q(/home/phil/vita/minimum);

my @f = searchDirectoryTreesForMatchingFiles($home, qw(.py .pl .perl .yml));
lll "Files:\n", dump([@f]);
for my $f(@f)
 {lll qx(git add $f);
 }

my $date = dateTimeStampName;

lll qx(git commit -m "$date");
lll qx(git push -u origin master);
