class nfs::client (
    $mounts = undef,
) {
    package { 'nfs-common':
        ensure  => present
    }

    if $mounts {
        create_resources(nfs::mount, $mounts)
    }
}
