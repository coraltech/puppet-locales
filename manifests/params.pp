
class locales::params inherits locales::default {

  $package             = module_param('package')
  $ensure              = module_param('ensure')

  #---

  $config_file         = module_param('config_file')

  #---

  $locale_gen_command  = module_param('locale_gen_command')
  $locale_gen_template = module_param('locale_gen_template')

  $locales             = module_array('locales')
}
