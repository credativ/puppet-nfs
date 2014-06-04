define nfs::mount (
    $ensure,
    $mountpoint,
    $share,
    $options='defaults',
    $atboot=true,
    $fstype='nfs'
) {

    mount { $title:
        ensure  => $ensure,
        device  => $share,
        fstype    => $fstype,
        atboot  => $atboot,
        name    => $mountpoint,
    }
}

