# Class: perlbrew::install
#
#   This class will install the perlbrew script itself and uses the package
#   manager of the operating system to install the required compiler
#   toolchain. The compiler toolchain is required to compile the Perl
#   interpreter later.
#
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class perlbrew::install {

  file {
    $perlbrew::params::perlbrew_root:
      ensure  => directory,
      mode    => '0755',
      owner   => perlbrew,
      group   => perlbrew,
  }
  -> file {
    $perlbrew::params::perlbrew_bin:
      owner  => root,
      group  => root,
      mode   => '0755',
      source => "puppet:///modules/${module_name}/perlbrew",
      notify => Exec['perlbrew_init'],
  }
  -> exec {
    'perlbrew_init':
      command => "/bin/sh -c 'umask 022; /usr/bin/env PERLBREW_ROOT=${perlbrew::params::perlbrew_root} ${perlbrew::params::perlbrew_bin} init'",
      # XXX the bash scriptie
      creates   => "${perlbrew::params::perlbrew_root}/etc/bashrc",
      user      => 'perlbrew',
      group     => 'perlbrew',
      logoutput => 'on_failure',
  }
  -> file {
    $perlbrew::params::cpanm_bin:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => "puppet:///modules/${module_name}/cpanm-${perlbrew::params::cpanm_version}/cpanm",
  }
  -> anchor { 'perlbrew-installed': }

  # install our shell hooks
  file {
    '/etc/profile.d/00-perlbrew.sh':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "export PERLBREW_ROOT=${perlbrew::params::perlbrew_root}\nsource ${perlbrew::params::perlbrew_root}/etc/bashrc",
  }
  -> Anchor['perlbrew-installed']

}
