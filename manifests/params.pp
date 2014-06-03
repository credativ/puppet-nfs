class nfs::params {
    $ensure         = 'present'
    $ensure_running = true
    $ensure_enabled = true
    $manage_config      = true
    $config_file        = '/etc/exports'
    $config_template    = undef
    $config_source      = undef
    $disabled_hosts     = []
}

