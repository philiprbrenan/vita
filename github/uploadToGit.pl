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

my $home = q(/home/phil/vita/minimum);                                          # Home folder
my $perl = fpd($home, qw(github));                                              # Upload to github
my $p1   = fpe($perl, qw(uploadOut pl));
my $pa   = fpe($perl, qw(a out));
my $p2   = fpe($perl, qw(uploadOut perl));

lll qx(pp -I /home/phil/perl/cpan/GitHubCrud/lib $p1; mv $pa $p2);              # Package uploader

my @f = searchDirectoryTreesForMatchingFiles($home, qw(.py .pl .perl .yml));    # Files we want to upload
lll "Files:\n", dump([@f]);
for my $f(@f)
 {lll qx(git add $f);
 }

my $title = q(Vita).dateTimeStampName;                                          # Name for commit

lll qx(git commit -m "$title");
lll qx(git push -u origin master);                                              # Push to GitHub via SSH
