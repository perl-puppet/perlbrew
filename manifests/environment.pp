# Class: perlbrew::environment
#
#   This class will setup a basic perlbrew environment
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class perlbrew::environment {

  group {
    'perlbrew':
      ensure => present,
      gid    => $perlbrew::params::perlbrew_gid,
      system => true,
  }

  user {
    'perlbrew':
      ensure => present,
      home   => $perlbrew::params::perlbrew_root,
      uid    => $perlbrew::params::perlbrew_uid,
      gid    => 'perlbrew',
      system => true,
  }

  # TODO: mark using stdlib's helpers
  if !defined (Package['build-essential'])
  { package
    { 'build-essential':ensure => present, }
  }

  if !defined (Package['wget'])
  { package
    { 'wget':ensure => present, }
  }

}
