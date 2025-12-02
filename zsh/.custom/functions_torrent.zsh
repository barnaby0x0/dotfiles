## TORRENT
function rename_torrent () {
    rename "s/ /_/g" ./*.torrent
    rename "s/'/_/g" ./*.torrent
    rename "s/é/e/g" ./*.torrent
    rename "s/è/e/g" ./*.torrent
    rename "s/\[//g" ./*.torrent
    rename "s/]//g" ./*.torrent
    rename "s/\)//g" ./*.torrent
    rename "s/\(//g" ./*.torrent
}

