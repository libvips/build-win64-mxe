# included by all scripts

vips_package=vips
vips_version=8.7
vips_micro_version=0

# build-win64/x.xx dir we are building
work_dir=$(pwd)

# MXE specific
mxe_dir=$work_dir/mxe
mxe_prefix=$mxe_dir/usr

repackage_dir=$vips_package-dev-$vips_version
