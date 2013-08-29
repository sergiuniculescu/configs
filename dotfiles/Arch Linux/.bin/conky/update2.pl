#!/usr/bin/perl
use strict;
use warnings;

use Xyne::Arch::Bauerbill;

my $n_threads = 1;

my $bb = Xyne::Arch::Bauerbill->new({autoload=>1});
$bb->{AUR}->{CALLBACK}->{QUIET} = 1;
$bb->{PowerpillConf}->set_value('Threads', $n_threads);
$bb->{AUR}->{THREADS} = $n_threads;

my @repopkgs = sort $bb->get_upgradable_pkgnames();
my @aurpkgs = sort $bb->{AUR}->get_upgradable();

my %versions;
$versions{$_} = ($bb->{AUR}->get_versions($_))[0] foreach @aurpkgs;
$versions{$_} = $bb->get_sync_db_pkg_ver($_) foreach @repopkgs;

my $groups = $bb->group_pkgnames_by_repo(@repopkgs);

foreach my $reponame ($bb->get_repo_list)
{
  if (ref($groups->{$reponame}) eq 'ARRAY')
  {
    &display($reponame, @{$groups->{$reponame}});
  }
  else
  {
    &display($reponame);
  }
}

if (@aurpkgs)
{
  &display('AUR',@aurpkgs);
}
                                                                                                                                                                                   
                                                                                                                                                                                   
sub display                                                                                                                                                                        
{
  my ($name,@pkgs) = @_;
  my $msg;
  if (@pkgs)
  {
    my $n = scalar(@pkgs);
    $msg = ($n > 1) ? "$n new pkgs" : '1 new pkg';
  }
  else
  {
    $msg = "up-to-date";
  }
  print '${color1}[${color1}'.$name.'${color1}]${alignr}${color1}'.$msg.'${voffset 0}${color1}'."\n";
}