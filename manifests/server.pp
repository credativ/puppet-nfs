class nfs::server (
    $ensure,
    $ensure_running,
    $ensure_enabled,
    $manage_config,
    $config_file,
    $config_source,
    $config_template,
    $disabled_hosts,
    $exports,
) {
    package { 'nfs-kernel-server':
        ensure => $ensure
    }

    service { 'nfs-kernel-server':
        ensure      => $ensure_running,
        enable      => $ensure_enabled,
        hasrestart  => true,
        hasstatus   => true,
        require     => Package['nfs-kernel-server']
    }

    file { $config_file:
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        tag     => 'nfs_config',
        notify  => Exec['exportfs']
    }

    exec { 'exportfs':
        command     => '/usr/sbin/exportfs -a',
        refreshonly => true
    }

    # Disable service on this host, if hostname is in disabled_hosts
    if $::hostname in $disabled_hosts {
        Service <| title == 'nfs-kernel-server' |> {
            ensure  => 'stopped',
            enabled => false,
        }
    }

    if $manage_config {
        if $config_source {
            File <| tag == 'nfs_config' |> {
                source  => $config_source
            }
        } elsif $config_template {
            File <| tag == 'nfs_config' |> {
                content => template($config_template)
            }
        }
    }

}
