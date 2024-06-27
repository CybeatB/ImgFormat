# Image Formatter

## Usage
Use the `container` script to run build tools & tests.

`container -h` or `container --help` print a help message.

`container command [arg [...]]` runs `command` inside the build container.

Eventually, a Containerfile will be created for deployment.

The container script is set up to use the `elixir:1.16.3-alpine` official image.
It requires either podman or docker to be installed, and prefers podman if both
are available.

The repository is mounted read-write inside the container as `/src`, and
commands in the container will run in this directory.
The container also publishes a TCP port, for testing.
Defaults to 8080, but can be set using the `IMGFORMAT_PORT` environment
variable.

## Background
### Assignment Spec
> Build a service that allows images to be uploaded.
> Once uploaded the image should be encoded and resized in different formats,
> and stored in a database.
> Once those images are ready, they should be accessible in a browser via a URL.

### Requirements
- Inferring from "uploaded" that requests must be accepted over a network
  socket.
- Protocol not specified, but must be supported by browsers.
- Minimum valid requests:
  - Upload image
  - Download image
- Images must be processed & stored in a database when uploaded;
  inferring that the processing of images cannot be deferred until a specific
  resolution & format is requested.
- Supported formats & resolutions are not specified.

### Implementation
- Elixir process management
- Receive requests over HTTP/S; common, well-supported protocol.
- Hosted locally during testing, barebones HTML pages for upload & download
- SQLite database; easy to prototype with, and to swap out for another SQL DB
  if required.
- Technically not storing images themselves in the database; storing them in
  the filesystem, and storing the paths in the database.
  This is more in line with "good practice" for a small web service.
- 2 image formats; JPEG & PNG arbitrarily chosen as suitable.
- Downscale to half- & quarter-resolution, unless image is already smaller than
  4x4 pixels.

