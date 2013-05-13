# Class: perlbrew::params
#
#   This class contains some sane defintions for variables. This class
#   must not be used directly, it gets loaded by the other classes.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class perlbrew::params {

  $perlbrew_root = '/usr/local/perlbrew'
  $perlbrew_bin  = '/usr/local/bin/perlbrew'
  $cpanm_url     = 'http://github.com/miyagawa/cpanminus/raw/master/cpanm'

  # automatically enable the system perlbrew for all users
  $enable_all_users = true

  # allow the system to choose for us -- less chance of collisions
  $perlbrew_gid = undef
  $perlbrew_uid = undef
}
