class nfs::client (
    $mounts = undef,
) {
    package { 'nfs-common':
        ensure  => present
    }

    if $nfs_mounts {
        create_resources(nfs::mount, $mounts)
    }
}
