# included by all scripts

vips_package=vips
vips_version=8.16
vips_patch_version=0
vips_pre_version=7bc895b-debug

if [ -n "$GIT_COMMIT" ]; then
  vips_version=$GIT_COMMIT
  vips_patch_version=
  vips_pre_version=
fi

# build-win64-mxe/build dir we are building
work_dir=$(pwd)

# MXE specific
mxe_dir=$work_dir/mxe
mxe_prefix=$mxe_dir/usr

repackage_dir=$vips_package-dev-$vips_version
pdb_dir=$vips_package-pdb-$vips_version
