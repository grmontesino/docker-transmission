# Changelog

## alpine-3.21.2-i1 - 2025-01-15

* Base image update

## alpine-3.20.2-i1 - 2024-08-14

* Base image update

## alpine-3.19.1-i1 - 2024-03-28

* Base image update

## alpine-3.19.0-i1 - 2023-12-09

* Base image update

## alpine-3.18.4-i1 - 2023-10-05

* Base image update

## aplpine 3.17.0-i1 - 2022-12-12

* Base image update
* CI: github actions update

## alpine-3.15.1-i1 - 2022-03-18

* Base image update

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
