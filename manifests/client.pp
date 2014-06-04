class nfs::client (
    $nfs_mounts = undef,
) {
    package { 'nfs-common':
        ensure  => present
    }

    if $nfs_mounts {
        create_resources(nfs::mount, $nfs_mounts)
    }
}
