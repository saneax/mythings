class scontrol (
) {

  $sources = hiera ( 'scontrol::sources', {} )
  $e_packages = hiera ( 'enhancer_packages', [] )
  $p_packages = hiera ( 'pip_packages', [] )
  notice ("what do we have as sources\n [$sources]\n [$e_packages]\n [$p_packages]")
  create_resources ( '::apt::source', $sources )


  class { '::sudo':
    purge               => false,
    config_file_replace => false,
  } ->
  class { '::scontrol::accounts': } ->
  class { '::apt':
    purge_sources_list   => true,
    purge_sources_list_d => true,
    purge_preferences_d  => true,
    update_timeout       => 600,
  } ->
  class { "::ntp": } ->
  package { $e_packages:
    ensure => installed,
  } ->
  package { $p_packages:
    ensure => installed,
    provider => pip,
  }
}


