FROM docker.io/library/buildpack-deps:bullseye

RUN apt-get update \
  && apt-get install -y \
    # http://mxe.cc/#requirements-debian
    autopoint bison flex gettext gperf g++-multilib \
    intltool libc6-dev-i386 libtool-bin libxml-parser-perl \
    lzip p7zip-full python-is-python3 python3-mako ruby

# The build dir is mounted at /data, so this runs the build script in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The build dir is mounted here
WORKDIR /data
