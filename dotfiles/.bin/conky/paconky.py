#!/usr/bin/env python3

# Author: Xyne

"""Display information about upgradable packages in Conky.

This script is meant to be customized. The default is just an example.

USAGE
  paconky.py /temporary/database/path

EXAMPLES
  A static path:

      paconky.py ~/.cache/pacman

  Using tmpfs:

      paconky.py /dev/shm/pacman

  If the XDG_CACHE_HOME variable is set with 1 path:

      paconky.py "$XDG_CACHE_HOME"/pacman

  ... or with multiple paths:

      paconky.py "$(echo $XDG_CACHE_HOME | cut -d':' -f1)"/pacman


DEPENDENCIES
  * pyalpm
  * python3-aur


EXAMPLE CONKY CONFIGURATION FILE

  alignment top_left
  gap_x 5
  gap_y 0
  maximum_width 200
  minimum_size 200,1
  own_window yes
  own_window_transparent yes
  own_window_type override
  own_window_hints below

  update_interval 3600
  total_run_times 0
  double_buffer yes

  use_xft yes
  xftfont lime:pixelsize=10
  xftalpha 0.9

  default_color ff0000
  default_outline_color black
  default_shade_color black

  uppercase no
  override_utf8_locale no

  text_buffer_size 4096

  color1 444444
  color2 cccccc
  color3 777777


  TEXT
  ${execp /path/to/paconky.py /tmp/paconky}



"""

import AUR
import pyalpm
import os
import sys

from collections import OrderedDict
from pycman import config, action_sync



def display(upgradable_sync, upgradable_aur):
  """Display the output.

  upgradable_sync: An OrderedDict of sync database names and sets of tuples.
  Each tuple consists of the local package and sync package returned by pyalpm.

  upgradable_aur: A list of tuples. Each tuple consists of the local package
  returned by pyalpm and a dictionary object returned from the AUR.

  """

  # Necessary because of the buggy way conky handles alignr.
  width = 40


  # To change the output, edit these formatting strings.
  # You can change anything except the number of "%s" in each.
  # If you need to insert a percent sign, use "%%".
  header = '${color1}${hr}\n${color1}[${color2}%s${color1}]%s${color3}%s'
  one = '1 new package'
  many = '%d new packages'
  line = '\n%s%s%s'
  footer = '\n${color1}${hr}\n${voffset 10}'

  # Nothing to upgrade.
  if not (upgradable_sync or upgradable_aur):
    hdr = 'local packages'
    msg = 'up-to-date'
    # -2 for brackets
    spacer = ' ' * (width - len(hdr) - len(msg) - 2)
    print(header % (hdr,spacer,msg) + footer);

  else:
    for k, v in upgradable_sync.items():
      hdr = k
      n = len(v)
      if n > 1:
        msg = many % n
      else:
        msg = one

      # -2 for brackets.
      spacer = ' ' * (width - len(hdr) - len(msg) - 2)
      print(header % (hdr,spacer,msg), end='');

      v = sorted(v, key=lambda x: x[0].name)
      for local, sync in v:
        name, version = local.name, sync.version
        spacer = ' ' * (width - len(name) - len(version))
        print(line % (name, spacer, version), end='')

      print(footer)


    if upgradable_aur:
      hdr = 'AUR'
      n = len(upgradable_aur)
      if n > 1:
        msg = many % n
      else:
        msg = one

      # -2 for brackets.
      spacer = ' ' * (width - len(hdr) - len(msg) - 2)
      print(header % (hdr,spacer,msg), end='');

      upgradable_aur.sort(key=lambda x: x[0].name)
      for local, aur in upgradable_aur:
        name, version = local.name, aur['Version']
        spacer = ' ' * (width - len(name) - len(version))
        print(line % (name, spacer, version), end='')

      print(footer)




def main(tmp_db_path):
  # Use a temporary database path to avoid issues caused by synchronizing the
  # sync database without a full system upgrade.

  # See the discussion here:
  #   https://bbs.archlinux.org/viewtopic.php?pid=951285#p951285

  # Basically, if you sync the database and then install packages without first
  # upgrading the system (-y), you can do some damage.


  tmp_db_path = os.path.abspath(tmp_db_path)
  conf = config.PacmanConfig(conf = '/etc/pacman.conf')
  db_path = conf.options['DBPath']
  if tmp_db_path == db_path:
    print("temporary path cannot be %s" % db_path)
    sys.exit(1)
  local_db_path = os.path.join(db_path, 'local')
  tmp_local_db_path = os.path.join(tmp_db_path, 'local')

  # Set up the temporary database path
  if not os.path.exists(tmp_db_path):
    os.makedirs(tmp_db_path)
    os.symlink(local_db_path, tmp_local_db_path)
  elif not os.path.islink(tmp_local_db_path):
    # Move instead of unlinking just in case.
    os.rename(tmp_local_db_path, tmp_local_db_path + '.old')
    os.symlink(local_db_path, tmp_local_db_path)


  # Redirect the stdout messages download messages to stderr.
  with open(os.devnull, 'w') as f:
    sys.stdout = f
    action_sync.main(('-b', tmp_db_path, '-y'))
    sys.stdout = sys.__stdout__

  installed = set(p for p in pyalpm.get_localdb().pkgcache)
  upgradable = OrderedDict()

  syncdbs = pyalpm.get_syncdbs()
  for db in syncdbs:
    # Without "list" the set cannot be altered with "remove" below.
    for pkg in list(installed):
      pkgname = pkg.name
      syncpkg = db.get_pkg(pkgname)
      if syncpkg:
        if pyalpm.vercmp(syncpkg.version, pkg.version) > 0:
          try:
            upgradable[db.name].add((pkg, syncpkg))
          except KeyError:
            upgradable[db.name] = set(((pkg, syncpkg),))
        installed.remove(pkg)

  foreign = dict([(p.name,p) for p in installed])

  try:
    aur = AUR.AUR(threads=10)
    aur_pkgs = aur.info(foreign.keys())
  except AUR.AURError as e:
    sys.stderr.write(str(e))
    sys.exit(1)

  upgradable_aur = list()
  for aur_pkg in aur_pkgs:
    installed_pkg = foreign[aur_pkg['Name']]
    if pyalpm.vercmp(aur_pkg['Version'], installed_pkg.version) > 0:
      upgradable_aur.append((installed_pkg, aur_pkg))
    installed.remove(installed_pkg)

  display(upgradable, upgradable_aur)



if __name__ == "__main__":
  if sys.argv[1:]:
    main(sys.argv[1])
  else:
    print("no temporary path given")
    sys.exit(1)
