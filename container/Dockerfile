FROM buildpack-deps:bullseye

RUN apt-get update \
  && apt-get install -y \
    # http://mxe.cc/#requirements-debian
    autopoint bison flex gettext gperf g++-multilib \
    intltool libc6-dev-i386 libtool-bin libxml-parser-perl \
    lzip p7zip-full python-is-python3 python3-mako ruby

# gas-preprocessor.pl is required for the ARM/ARM64 builds of libjpeg-turbo
# TODO(kleisauke): This is no longer necessary once mozjpeg merges libjpeg-turbo 2.1.0.
RUN curl -L https://github.com/libav/gas-preprocessor/raw/master/gas-preprocessor.pl -o /usr/bin/gas-preprocessor.pl \
  && chmod +x /usr/bin/gas-preprocessor.pl

# The build dir is mounted at /data, so this runs the build script in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The build dir is mounted here
WORKDIR /data
