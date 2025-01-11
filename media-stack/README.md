# Media Server

## Pre-requisite

### Docker network
The stack is communicating using an internal docker network, hence the network must exist before running docker compose.

```bash
docker network create entertainment
```

### External storage
The downloaded files are pointed to a docker volume named `torrent-downloads`, it is encouraged to mount an external storage.

```yml
volumes:
  torrent-downloads:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /path/to/the/storage
```

If external storage isn't necessary, simply remove the lines from `driver: local` to `device: /path/to/the/storage`.
Having `torrent-downloads:` alone is sufficient - docker knows where to create the directory.

## Installation

Following the guide at https://github.com/navilg/media-stack/blob/main/README.md.

Go with the version without VPN. And nginx setup isn't necessary.

## Post installation

### Mapping the correct path
It wasn't covered in the tutorial on how to get qBittorrent to place the downloaded files in the respective directory, from sonarr or radarr.

1. Fire up qbittorent at port 5080.
1. Go to Options > Downloads (tab) > Saving Management (section)
1. Change the value for the option **Default Torrent Management Mode:** to **Automatic**
1. In the home screen, on the left pane, scroll to **Categories** and locate `radarr` and `tv-sonarr`
1. Right click on them, select "Edit category..."
1. Specify the full directory under **Save path:**, e.g. `/downloads/movies`
