# grmontesino/transmission image

Docker image for transmission bittorrent client by Gustavo R. Montesino. This image hosts transmission-daemon, which can then be accessed through other containers or by one of the transmission clients (eg transmission-remote) for downloading and/or seeding torrents.

## Disclaimer
This container has been made for myself and is provided as-is, without warranty of any kind, in the hope it can be useful.

While I don't think there is anything particularly novel or copyright-worthy in this repo, feel free to re-use any of this code however you see fit. Please consider linking to the original and/or letting me know if you do use it.

## Usage

### Getting Started

To run this image with the default configurations:

* Clone this repository
* Copy .env.sample to .env
* `docker-compose up`

### Configuration parameters / environment variables

This image has been prepared to allow the most important transmission settings to be defined through environment variables, which we recommend be set through the `.env` file to facilitate future updates.

The available variables can be seen on the provided example file `.env.sample` with their respective defaults and are described below, together with the respective transmission setting, so that more information can also be seen on [transmission's documentation](https://github.com/transmission/transmission/wiki/Editing-Configuration-Files).

| Name            | Transmission Setting | Description |
| :-------------- | :------------------- | :---------- |
| PORT_FORWARDING | port-forwarding-enabled | UPNP / NAT-PNP, doesn't work (by default) on container, so should likely be kept off (false)
| TZ              | - | Timezone |
| UID             | - | User (uid) used to run the daemon. Downloaded files will be owned by this user by default |
| ALLOWED         | rpc-whitelist | Comma-separated list of ips allowed to access the daemon through RPC |
| RPC_PORT        | - | This port will be mapped on the host to the daemon's RPC PORT |
| PEER_PORT_TCP   | - | This port will be mapped on the host to the daemon's TCP peer port |
| PEER_PORT_UDP   | - | This port will be mapped on the host to the daemon's UDP peer port |
| CACHE_SIZE_MB   | cache-size-mb | Size in MB for transmission's memory cache |
| DOWNLOAD_QUEUE | download-queue-size | Max amount of torrents to download in parallel, 0 to disable |
| SEED_QUEUE | seed-queue-size | Max amount of torrents to seed in parallel, 0 to disable |
| SPEED_LIMIT_UP | speed-limit-up | Max upload rate in KB/s, 0 to disable |
| SPEED_LIMIT_DOWN | speed-limit-down | Max download rate in KB/s, 0 to disable |
| PEER_LIMIT_GLOBAL | peer-limit-global | Max amount of peer connections, global |
| PEER_LIMIT_TORRENT | peer-limit-per-torrent | Max amount of peer connections, per torrent |
| EXTRA_ARGS | - | If set, will be passed as-is on the transmission-daemon command line |

### Volumes

This image uses two volumes:

* `/transmission/config`: transmission's config dir, including configuration file, state information and torrent files.
* `/transmission/download`: default location for downloaded files.

If using the supplied compose file, both directories will be bind-mounted to `./config` and `./download` on the dir containing the compose file.

If you want to move this data elsewhere I suggest symlinking to the desired place. For multiple download directories a suggestion is to create the desired tree below `./download` and `mount --bind` the desired destinations.

Editing the compose file directly is also an option, however it'll demand some extra care to not overwrite the changes on updates.

### Tips

* For proper seeding, in a typical network it might be needed to configure port forwarding to the peer port. For the provided compose, traffic to `PEER_PORT_TCP` and `PEER_PORT_UDP` should forwarded to the host's ip address;

* To use an client (such as transmission-remote) to access the container's daemon, it'll be needed to add the connection's origin ip address to `ALLOWED`. For a typical configuration, `172.*` should work to allow access from the docker host;

* To connect to the daemon from another container, if using the provided compose file, such container must be added to the `torrent` network. Once that's done, the container name (`transmission`) should be correctly resolved to the correct ip by docker and can be used as the transmission hostname for connecting. If using docker-compose:

    ```yaml
    services:
      xxx:
        networks:
          - torrent

    (...)

    networks:
      torrent:
        external: true
    ```

## Updating

If there's no customization on the customization file, just read the changelog to see if there are any relevant change/extra steps, `git pull` and restart the container.

In case there is some need to change the compose file, the easiest way is likely to see what changed and apply the changes by hand. An alternative might be to keep the customizations in a separeted git branch and `git merge` the main branch on the custom branch to update.

## Building

No secrets, just `docker-compose build` if desired

## Available tags / versioning

* alpine-[x.y]-i[z]: Stable version based on alpine [x.y], image revision [z].
* edge: Moving tag with latest commit on `develop`. May be broken.
