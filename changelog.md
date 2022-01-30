# Changelog

## (TBD)

* New environment variables:
  * `GID`: The user used to run Transmission's daeamon will be added to this group;
  * `RPC_HOST_WHITELIST`: Hostnames through wuth the RPC can be accessed;
  * `RESTART`: Restart policy for the container
* Added github action for automatic image building and publishing o dockerhub.
* Dockerfile: explicitly create volume dirs, fix image error depending on build environment.

## alpine-3.15

* Initial release
