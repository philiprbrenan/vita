#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/ -I/home/phil/perl/cpan/GitHubCrud/lib/
#-------------------------------------------------------------------------------
# Upload all files to GitHub  _
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2020
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use GitHub::Crud;

my $home = q(/home/phil/vita/minimum);                                          # Home folder
my $doc  = fpd($home, qw(doc));                                                 # Documentation
my $perl = fpd($home, qw(github));                                              # Perl to perform upload to github
my $p1   = fpe($perl, qw(uploadOut pl));
my $pa   = fpe($perl, qw(a out));
my $p2   = fpe($perl, qw(uploadOut perl));

my $user =  q(philiprbrenan);
my $repo = qq($user.github.io);
my $docg = fpd(qw(vita));


my @h = qw(.html .css);                                                         # File types we want to upload to web page
my @t = qw(.py .pl .perl .yml);                                                 # File types we want to upload to vita

if (1)                                                                          # Commit to vita repository
 {lll qx(pp -I /home/phil/perl/cpan/GitHubCrud/lib $p1; mv $pa $p2);            # Package uploader
  lll qx(git pull origin master);                                               # Retrieve latest status

  my @f = searchDirectoryTreesForMatchingFiles($home, @h, @t);                  # Files we want to upload
  lll "Files:\n", dump([@f]);
  for my $f(@f)
   {lll qx(git add $f);
   }

  my $title = q(Vita).dateTimeStampName;                                        # Name for commit

  lll qx(git commit -m "$title");
  lll qx(git push -u origin master);                                            # Push to GitHub via SSH
 }

if (1)                                                                          # Upload documentation
 {my @f = searchDirectoryTreesForMatchingFiles($doc, @h);                       # Files we want to upload
  for my $s(@f)
   {my $t = swapFilePrefix($s, $doc, $docg);
    lll $t;
    GitHub::Crud::writeFileFromFileUsingSavedToken($user, $repo, $t, $s);
   }
 }
