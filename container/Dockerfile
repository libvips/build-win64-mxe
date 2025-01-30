ARG BASE_IMAGE=ghcr.io/libvips/build-win64-mxe:latest
FROM $BASE_IMAGE

# Copy the contents of this repository to the container
COPY . /data
WORKDIR /usr/local/mxe

ARG DEPS
ARG TARGET
ARG DEBUG
ARG GIT_COMMIT
ARG PLUGIN_DIRS

RUN \
  if [ "$DEBUG" = "true" ]; then \
    cp -f /data/settings/debug.mk settings.mk; \
  else \
    cp -f /data/settings/release.mk settings.mk; \
  fi

# Build gendef (a tool for generating def files from DLLs)
# and libvips (+ dependencies)
RUN --mount=type=cache,id=mxe-download,target=/usr/local/mxe/pkg \
  make gendef vips-$DEPS \
    MXE_PLUGIN_DIRS="$PLUGIN_DIRS" \
    MXE_TARGETS=$TARGET.$DEPS \
    GIT_COMMIT=$GIT_COMMIT

# Build GTK4 apps if requested
RUN --mount=type=cache,id=mxe-download,target=/usr/local/mxe/pkg \
  if [ "${TARGET#*.gtk4}" != "$TARGET" ]; then \
    make vipsdisp nip4 \
      MXE_PLUGIN_DIRS="$PLUGIN_DIRS" \
      MXE_TARGETS=$TARGET.$DEPS; \
  fi

# Build and bundle llvm-mingw tests when debugging
RUN --mount=type=cache,id=mxe-download,target=/usr/local/mxe/pkg \
  if [ "$DEBUG" = "true" ]; then \
    make test-llvm-mingw \
      MXE_PLUGIN_DIRS="$PLUGIN_DIRS" \
      MXE_TARGETS=$TARGET.$DEPS; \
  fi

# The packaging dir is mounted here
WORKDIR /data/packaging

ENTRYPOINT ["/bin/bash", "package.sh"]
