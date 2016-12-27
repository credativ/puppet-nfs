# = Class: nfs
#
# Module to manage nfs
#
# == Requirements:
#
# - This module makes use of the example42 functions in the puppi module
#   (https://github.com/credativ/puppet-example42lib)
#
# == Parameters:
#
# [* ensure *]
#   What state to ensure for the package. Accepts the same values
#   as the parameter of the same name for a package type.
#   Default: present
#
# [* ensure_running *]
#   Weither to ensure running nfs or not.
#   Default: running
#
# [* ensure_enabled *]
#   Weither to ensure that nfs is started on boot or not.
#   Default: true
#
# [* config_source *]
#   Specify a configuration source for the configuration. If this
#   is specified it is used instead of a template-generated configuration
#
# [* config_template *]
#   Override the default choice for the configuration template
#
# [* disabled_hosts *]
#   A list of hosts whose nfs will be disabled, if their
#   hostname matches a name in the list.
#
#

class nfs (
    $ensure             = $::nfs::params::ensure,
    $ensure_running     = $::nfs::params::ensure_running,
    $ensure_enabled     = $::nfs::params::ensure_enabled,
    $manage_config      = $::nfs::params::manage_config,
    $config_file        = $::nfs::params::config_file,
    $config_source      = $::nfs::params::config_source,
    $config_template    = $::nfs::params::config_template,
    $disabled_hosts     = $::nfs::params::disabled_hosts,
    $exports            = $::nfs::params::exports,
    $role               = $::nfs::params::role,
    $mounts             = $::nfs::params::mounts,
    ) inherits nfs::params {

    if $role == 'auto' {
        case $::hostname {
            /nfs/: {
                $real_role = 'server'
            }
            default: {
                $real_role = 'client'
            }
        }
    } else {
        $real_role = $role
    }

    if $real_role == 'server' {
        class { 'nfs::server':
            ensure          => $ensure,
            ensure_running  => $ensure_running,
            ensure_enabled  => $ensure_enabled,
            manage_config   => $manage_config,
            config_file     => $config_file,
            config_source   => $config_source,
            config_template => $config_template,
            disabled_hosts  => $disabled_hosts,
            exports         => $exports,
        }
    } else {
        class { 'nfs::client':
            mounts  => $mounts
        }
    }

}

