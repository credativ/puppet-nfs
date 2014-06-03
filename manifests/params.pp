class nfs::params {
    $ensure         = 'present'
    $ensure_running = true
    $ensure_enabled = true
    $manage_config      = true
    $config_file        = '/etc/exports'
    $config_template    = 'nfs/exports.erb'
    $config_source      = undef
    $disabled_hosts     = []
}

