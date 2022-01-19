# included by all scripts

vips_package=vips
vips_version=8.12
vips_patch_version=1
#vips_pre_version=rc1

if [ "$NIGHTLY" = "true" ]; then
  vips_version=nightly
  vips_patch_version=
  vips_pre_version=
fi

# build-win64-mxe/build dir we are building
work_dir=$(pwd)

# MXE specific
mxe_dir=$work_dir/mxe
mxe_prefix=$mxe_dir/usr

repackage_dir=$vips_package-dev-$vips_version
