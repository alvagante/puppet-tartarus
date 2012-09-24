define tartarus::job (
  $directory,
  $storage_method       = 'ftp',
  $storage_ftp_server   = '',
  $storage_ftp_user     = '',
  $storage_ftp_password = '',
  $compression_method   = 'bzip2',
  $schedule             = '',
  $template_file        = 'tartarus/job.conf',
  $ensure               = 'present',
  ) {

  include tartarus

  file { "/etc/tartarus/${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => $tartarus::user,
    group   => $tartarus::group,
    content => template($template_file),
  }

  if ( $schedule ) {
    file { "tartarus_backup_${name}":
      path    => "/etc/cron.d/tartarus_backup_${name}",
      ensure  => $ensure,
      mode    => '0644',
      owner   => "root",
      group   => "root",
      content => template("tartarus/cron.erb"),
    }
  }

}
