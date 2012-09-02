class tartarus (
  $base_source         = 'http://wertarbyte.de/tartarus/',
  $version             = '0.9.8',
  $install_destination = '/opt',
  $user                = 'root',
  $group               = 'root',
  ) {

  puppi::netinstall { 'netinstall_tartarus':
    url                 => "${tartarus::base_source}/tartarus-${tartarus::version}.tar.bz2",
    destination_dir     => "${tartarus::install_destination}/" ,
    extract_command     => 'tar -jxf',
    postextract_command => "ln -s ${tartarus::install_destination}/tartarus-${tartarus::version} ${tartarus::install_destination}/tartarus",
    extracted_dir       => "tartarus-${tartarus::version}",
  }

  file { '/etc/tartarus':
    ensure => directory,
    mode   => '0750',
    owner  => $tartarus::user,
    group  => $tartarus::group,
  }

}
