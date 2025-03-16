ARG BASE_IMAGE=ghcr.io/libvips/build-win64-mxe:latest
FROM $BASE_IMAGE

# Copy the contents of this repository to the container
COPY . /data
WORKDIR /usr/local/mxe

ARG PKGS
ARG MXE_TARGETS
ARG DEBUG
ARG GIT_COMMIT
ARG PLUGIN_DIRS

RUN \
  if [ "$DEBUG" = true ]; then \
    cp -f /data/settings/debug.mk settings.mk; \
  else \
    cp -f /data/settings/release.mk settings.mk; \
  fi

# Build requested packages and gendef (a tool for generating def files from DLLs)
RUN --mount=type=cache,id=mxe-download,target=/usr/local/mxe/pkg \
  make gendef $PKGS \
    MXE_PLUGIN_DIRS="$PLUGIN_DIRS" \
    MXE_TARGETS="$MXE_TARGETS" \
    GIT_COMMIT=$GIT_COMMIT

# The packaging dir is mounted here
WORKDIR /data/packaging

ENTRYPOINT ["/bin/bash", "package.sh"]
