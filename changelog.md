# Changelog

## alpine-3.15-i3  -  2022-01-31

* Fix CI pattern for release tags.

## alpine-3.15-i2  -  2022-01-31

* New environment variables:
  * `GID`: The user used to run Transmission's daeamon will be added to this group;
  * `RPC_HOST_WHITELIST`: Hostnames through wuth the RPC can be accessed;
  * `RESTART`: Restart policy for the container
  * `TAG`: Container's image tag
* Added github action for automatic image building and publishing o dockerhub.
* Dockerfile: explicitly create volume dirs, fix image error depending on build environment.

## alpine-3.15

* Initial release
