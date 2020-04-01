#!/usr/bin/perl -I/home/phil/perl/cpan/GitHubCrud/lib
#-------------------------------------------------------------------------------
# Upload the out folder to GitHub
# Philip R Brenan at gmail dot com, Appa Apps Ltd, 2020
#-------------------------------------------------------------------------------
# pp -I /home/phil/perl/cpan/GitHubCrud/lib uploadOut.pl; mv a.out uploadOut.perl
use v5.16;
use warnings FATAL => qw(all);
use strict;
use GitHub::Crud;

if (my $dir = $ARGV[1])                                                         # Mirror named folder on GitHub
 {GitHub::Crud::writeFolderUsingSavedToken
   (q(philiprbrenan), q(vita), $dir, $dir, $ENV{GITHUB_TOKEN});
 }
