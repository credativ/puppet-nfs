define nfs::mount (
    $ensure,
    $mountpoint,
    $share,
    $options='defaults',
    $atboot=true,
) {

    mount { $title:
        ensure  => $ensure,
        atboot  => $atboot,
        device  => $share,
        name    => $mountpoint,
        path    => $path,
    }
}

