# Class: locales
#
# This module manages locales
#
# Parameters:
#   [*locales*]
#     Name of locales to generate
#     Default: [ 'en_US.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8', ]
#
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*locale_gen_command*]
#     Command to generate locales.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs locales package and generates specified locales
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'locales':
#     locales => [ 'en_US.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8', 'en_GB.UTF-8 UTF-8', ],
#   }
#
# [Remember: No empty lines between comments and class definition]
class locales (

  $locales             = $locales::params::locales,
  $package             = $locales::params::os_locales_package,
  $ensure              = $locales::params::locales_ensure,
  $config_file         = $locales::params::os_config_file,
  $locale_gen_command  = $locales::params::os_locale_gen_command,
  $locale_gen_template = $locales::params::os_locale_gen_template,

) inherits locales::params {

  #-----------------------------------------------------------------------------
  # Installation

  package { 'locales':
    name   => $package,
    ensure => $ensure,
  }

  #-----------------------------------------------------------------------------
  # Configuration

  file { 'locales-config':
    path    => $config_file,
    content => template($locale_gen_template),
    require => Package['locales'],
    notify  => Exec['locale-gen'],
  }

  exec { 'locale-gen':
    command     => $locale_gen_command,
    refreshonly => true,
    require     => Package['locales'],
  }
}
