class locales::params {

  include locales::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $locales_ensure = hiera('locales_ensure', $locales::default::locales_ensure)
    $locales        = hiera('locales', $locales::default::locales)
  }
  else {
    $locales_ensure = $locales::default::locales_ensure
    $locales        = $locales::default::locales
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_locales_package     = 'locales'

      $os_config_file         = '/etc/locale.gen'
      $os_locale_gen_command  = '/usr/sbin/locale-gen'

      $os_locale_gen_template = 'locales/locale.gen.erb'
    }
    default: {
      fail("The locales module is not currently supported on ${::operatingsystem}")
    }
  }
}
