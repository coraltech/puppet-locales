
class locales::default {

  $ensure  = 'present'
  $locales = [ 'en_US.UTF-8 UTF-8' ]

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $package             = 'locales'

      $config_file         = '/etc/locale.gen'

      $locale_gen_command  = '/usr/sbin/locale-gen'
      $locale_gen_template = 'locales/locale.gen.erb'
    }
    default: {
      fail("The locales module is not currently supported on ${::operatingsystem}")
    }
  }
}
