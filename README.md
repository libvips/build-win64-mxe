# build-win64-mxe

libvips and its dependencies cross-compiled for all four Windows architectures (`i686`, `x86_64`,
`armv7` and `arm64`).

Uses [MXE](https://github.com/mxe/mxe) as base environment. A custom plugin based upon the
[llvm-mingw](https://github.com/mstorsjo/llvm-mingw) repository is used to swap GCC and binutils
with Clang and other LLVM-based tools.

## Creating a zipball

Most people will not need to do this; proceed with caution.

Run the top-level [build script](build.sh) with the `--help` parameter for help.

## libvips-web dependencies

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [aom]           | 3.1.1     | BSD 2-Clause + [Alliance for Open Media Patent License 1.0]  |
| [cairo]         | 1.17.4    | Mozilla Public License 2.0                                   |
| [expat]         | 2.4.1     | MIT Licence                                                  |
| [fontconfig]    | 2.13.94   | [fontconfig Licence] (BSD-like)                              |
| [freetype]      | 2.10.4    | [freetype Licence] (BSD-like)                                |
| [fribidi]       | 1.0.10    | LGPLv3                                                       |
| [gdk-pixbuf]    | 2.42.6    | LGPLv3                                                       |
| [glib]          | 2.69.0    | LGPLv3                                                       |
| [harfbuzz]      | 2.8.2     | MIT Licence                                                  |
| [lcms]          | 2.12      | MIT Licence                                                  |
| [libexif]       | 0.6.22    | LGPLv3                                                       |
| [libffi]        | 3.4.2     | MIT Licence                                                  |
| [libgsf]        | 1.14.47   | LGPLv3                                                       |
| [libheif]       | 1.12.0    | LGPLv3                                                       |
| [libimagequant] | 2.4.1¹    | BSD 2-Clause                                                 |
| [libpng]        | 1.6.37    | [libpng License version 2]                                   |
| [librsvg]       | 2.51.4    | LGPLv3                                                       |
| [libspng]       | 0.6.3     | BSD 2-Clause                                                 |
| [libtiff]       | 4.3.0     | [libtiff License] (BSD-like)                                 |
| [libvips]       | 8.11.2    | LGPLv3                                                       |
| [libwebp]       | 1.2.0     | New BSD License                                              |
| [libxml2]       | 2.9.12    | MIT Licence                                                  |
| [mozjpeg]       | 4.0.3     | [zlib License, IJG License, BSD-3-Clause]                    |
| [orc]           | 0.4.32    | [orc License] (BSD-like)                                     |
| [pango]         | 1.48.7    | LGPLv3                                                       |
| [pixman]        | 0.40.0    | MIT Licence                                                  |
| [zlib-ng]       | 2.0.5     | [zlib-ng Licence]                                            |

¹ [A fork](https://github.com/lovell/libimagequant) of the BSD 2-Clause licensed libimagequant v2.4.1 is used.  

[aom]: https://aomedia.googlesource.com/aom/
[Alliance for Open Media Patent License 1.0]: https://aomedia.org/license/patent-license/
[cairo]: https://gitlab.freedesktop.org/cairo/cairo
[expat]: https://github.com/libexpat/libexpat
[fontconfig]: https://gitlab.freedesktop.org/fontconfig/fontconfig
[fontconfig Licence]: https://gitlab.freedesktop.org/fontconfig/fontconfig/blob/master/COPYING
[freetype]: https://git.savannah.gnu.org/cgit/freetype/freetype2.git
[freetype Licence]: https://git.savannah.gnu.org/cgit/freetype/freetype2.git/tree/docs/FTL.TXT
[fribidi]: https://github.com/fribidi/fribidi
[gdk-pixbuf]: https://gitlab.gnome.org/GNOME/gdk-pixbuf
[glib]: https://gitlab.gnome.org/GNOME/glib
[harfbuzz]: https://github.com/harfbuzz/harfbuzz
[lcms]: https://github.com/mm2/Little-CMS
[libexif]: https://github.com/libexif/libexif
[libffi]: https://github.com/libffi/libffi
[libgsf]: https://gitlab.gnome.org/GNOME/libgsf
[libheif]: https://github.com/strukturag/libheif
[libimagequant]: https://github.com/lovell/libimagequant
[libpng]: https://github.com/glennrp/libpng
[libpng License version 2]: https://github.com/glennrp/libpng/blob/master/LICENSE
[librsvg]: https://gitlab.gnome.org/GNOME/librsvg
[libspng]: https://github.com/randy408/libspng
[libtiff]: https://gitlab.com/libtiff/libtiff
[libtiff License]: https://libtiff.gitlab.io/libtiff/misc.html
[libvips]: https://github.com/libvips/libvips
[libwebp]: https://github.com/webmproject/libwebp
[libxml2]: https://gitlab.gnome.org/GNOME/libxml2
[mozjpeg]: https://github.com/mozilla/mozjpeg
[zlib License, IJG License, BSD-3-Clause]: https://github.com/mozilla/mozjpeg/blob/master/LICENSE.md
[orc]: https://gitlab.freedesktop.org/gstreamer/orc
[orc License]: https://gitlab.freedesktop.org/gstreamer/orc/blob/master/COPYING
[pango]: https://gitlab.gnome.org/GNOME/pango
[pixman]: https://gitlab.freedesktop.org/pixman/pixman
[zlib-ng]: https://github.com/zlib-ng/zlib-ng
[zlib-ng Licence]: https://github.com/zlib-ng/zlib-ng/blob/develop/LICENSE.md

## libvips-all dependencies

Same as libvips-web + these extra dependencies:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [brotli]        | 1.0.9     | MIT Licence                                                  |
| [cfitsio]       | 3.49      | BSD-like                                                     |
| [fftw]          | 3.3.9     | GPLv2                                                        |
| [highway]       | [c7d83de] | Apache-2.0 License                                           |
| [imagemagick]   | 6.9.12-17 | [ImageMagick License] (Apache-2.0-like)                      |
| [imath]         | 3.0.5     | BSD 3-Clause                                                 |
| [libjxl]        | [2db3204] | BSD 3-Clause                                                 |
| [matio]         | 1.5.21    | BSD 2-Clause                                                 |
| [nifticlib]     | 2.0.0     | Public domain                                                |
| [openexr]       | 3.0.5     | BSD 3-Clause                                                 |
| [openjpeg]      | 2.4.0     | BSD 2-Clause                                                 |
| [openslide]     | 3.4.1     | LGPLv3                                                       |
| [poppler]       | 21.07.0   | GPLv2                                                        |
| [sqlite]        | 3.36.0    | Public domain                                                |

[c7d83de]: https://github.com/google/highway/commit/c7d83dee21a55607a3032a751de57eb72eaa4987
[2db3204]: https://github.com/libjxl/libjxl/commit/2db3204b23b96a169ae851faffdef2ae1c41b018

[brotli]: https://github.com/google/brotli
[cfitsio]: https://heasarc.gsfc.nasa.gov/fitsio/
[fftw]: https://github.com/FFTW/fftw3
[highway]: https://github.com/google/highway
[imagemagick]: https://github.com/ImageMagick/ImageMagick6
[ImageMagick License]: https://imagemagick.org/script/license.php
[imath]: https://github.com/AcademySoftwareFoundation/Imath
[libjxl]: https://github.com/libjxl/libjxl
[matio]: https://github.com/tbeu/matio
[nifticlib]: https://nifti.nimh.nih.gov/
[openexr]: https://github.com/AcademySoftwareFoundation/openexr
[openjpeg]: https://github.com/uclouvain/openjpeg
[openslide]: https://github.com/openslide/openslide
[poppler]: https://gitlab.freedesktop.org/poppler/poppler
[sqlite]: https://sqlite.org/

## libjpeg-turbo

libvips does not use any of MozJPEG's improvements by default unless explicitly set,
yet one can still choose to build the above variants with [libjpeg-turbo] instead of
MozJPEG. This can be accomplished with the `--without-mozjpeg` argument. For example:

```bash
./build.sh --without-mozjpeg
```

In that case, the following version of libjpeg-turbo is built:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [libjpeg-turbo] | 2.1.0     | [zlib License, IJG License]                                  |

[libjpeg-turbo]: https://github.com/libjpeg-turbo/libjpeg-turbo
[zlib License, IJG License]: https://github.com/libjpeg-turbo/libjpeg-turbo/blob/master/LICENSE.md

## zlib

By default [zlib-ng] is built. This is a zlib replacement with optimizations for
"next generation" systems. You can use the `--without-zlib-ng` argument during the
build when (vanilla-)[zlib] is preferred. For example:

```bash
./build.sh --without-zlib-ng
```

In that case, the following version of zlib is built:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [zlib]          | 1.2.11    | [zlib Licence]                                               |

[zlib]: https://zlib.net/
[zlib Licence]: https://github.com/madler/zlib/blob/master/zlib.h

## HEVC-related dependencies

The above "all" variant can optionally be built with [libde265] and [x265] to process
HEIC images. This can be turned on with the `--with-hevc` argument. For example:

```bash
./build.sh all --with-hevc
```

These dependencies include HEVC-related logic and are therefore not included in the
prebuilt binaries while it is patent-encumbered.

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [libde265]      | 1.0.8     | LGPLv3                                                       |
| [x265]          | 3.5       | GPLv2                                                        |

[libde265]: https://github.com/strukturag/libde265
[x265]: https://bitbucket.org/multicoreware/x265_git/wiki/Home
