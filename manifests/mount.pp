define nfs::mount (
    $ensure,
    $mountpoint,
    $share,
    $options='defaults',
    $atboot=true,
    $fstype='nfs'
) {

    File <| path == $mountpoint |> -> Mount[$mountpoint]

    mount { $title:
        ensure  => $ensure,
        device  => $share,
        fstype  => $fstype,
        atboot  => $atboot,
        options => $options,
        name    => $mountpoint,
    }
}

