# build-win64-mxe

libvips and its dependencies cross-compiled for all supported Windows architectures (`x86_64`,
`i686` and `aarch64`).

Uses [MXE](https://github.com/mxe/mxe) as base environment. A custom plugin based upon the
[llvm-mingw](https://github.com/mstorsjo/llvm-mingw) repository is used to swap GCC and binutils
with Clang and other LLVM-based tools.

## Creating a zipball

Most people will not need to do this; proceed with caution.

Run the top-level [build script](build.sh) with the `--help` parameter for help.

## libvips-web dependencies

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [aom]           | 3.12.1    | BSD 2-Clause + [Alliance for Open Media Patent License 1.0]  |
| [cairo]         | 1.18.4    | Mozilla Public License 2.0                                   |
| [cgif]          | 0.5.0     | MIT Licence                                                  |
| [expat]         | 2.7.1     | MIT Licence                                                  |
| [fontconfig]    | 2.17.1    | [fontconfig Licence] (BSD-like)                              |
| [freetype]      | 2.13.3    | [freetype Licence] (BSD-like)                                |
| [fribidi]       | 1.0.16    | LGPLv3                                                       |
| [glib]          | 2.85.1    | LGPLv3                                                       |
| [harfbuzz]      | 11.2.1    | MIT Licence                                                  |
| [highway]       | 1.2.0     | Apache-2.0 License, BSD 3-Clause                             |
| [lcms]          | 2.17      | MIT Licence                                                  |
| [libarchive]    | 3.8.1     | BSD 2-Clause                                                 |
| [libexif]       | 0.6.25    | LGPLv3                                                       |
| [libffi]        | 3.5.1     | MIT Licence                                                  |
| [libheif]       | 1.20.1    | LGPLv3                                                       |
| [libimagequant] | 2.4.1¹    | BSD 2-Clause                                                 |
| [libpng]        | 1.6.50    | [libpng License version 2]                                   |
| [librsvg]       | 2.60.0    | LGPLv3                                                       |
| [libspng]       | 0.7.4     | BSD 2-Clause                                                 |
| [libtiff]       | 4.7.0     | [libtiff License] (BSD-like)                                 |
| [libvips]       | 8.17.1    | LGPLv3                                                       |
| [libwebp]       | 1.5.0     | New BSD License                                              |
| [libxml2]       | 2.14.4    | MIT Licence                                                  |
| [mozjpeg]       | 4.1.5     | [zlib License, IJG License, BSD-3-Clause]                    |
| [pango]         | 1.56.4    | LGPLv3                                                       |
| [pixman]        | 0.46.2    | MIT Licence                                                  |
| [proxy-libintl] | 0.4       | LGPLv3                                                       |
| [zlib-ng]       | 2.2.4     | [zlib-ng Licence]                                            |

¹ [A fork](https://github.com/lovell/libimagequant) of the BSD 2-Clause licensed libimagequant v2.4.1 is used.  

[aom]: https://aomedia.googlesource.com/aom/
[Alliance for Open Media Patent License 1.0]: https://aomedia.org/license/patent-license/
[cairo]: https://gitlab.freedesktop.org/cairo/cairo
[cgif]: https://github.com/dloebl/cgif
[expat]: https://github.com/libexpat/libexpat
[fontconfig]: https://gitlab.freedesktop.org/fontconfig/fontconfig
[fontconfig Licence]: https://gitlab.freedesktop.org/fontconfig/fontconfig/blob/main/COPYING
[freetype]: https://gitlab.freedesktop.org/freetype/freetype
[freetype Licence]: https://gitlab.freedesktop.org/freetype/freetype/blob/master/docs/FTL.TXT
[fribidi]: https://github.com/fribidi/fribidi
[glib]: https://gitlab.gnome.org/GNOME/glib
[harfbuzz]: https://github.com/harfbuzz/harfbuzz
[highway]: https://github.com/google/highway
[lcms]: https://github.com/mm2/Little-CMS
[libarchive]: https://github.com/libarchive/libarchive
[libexif]: https://github.com/libexif/libexif
[libffi]: https://github.com/libffi/libffi
[libheif]: https://github.com/strukturag/libheif
[libimagequant]: https://github.com/lovell/libimagequant
[libpng]: https://github.com/pnggroup/libpng
[libpng License version 2]: https://github.com/pnggroup/libpng/blob/master/LICENSE
[librsvg]: https://gitlab.gnome.org/GNOME/librsvg
[libspng]: https://github.com/randy408/libspng
[libtiff]: https://gitlab.com/libtiff/libtiff
[libtiff License]: https://gitlab.com/libtiff/libtiff/blob/master/LICENSE.md
[libvips]: https://github.com/libvips/libvips
[libwebp]: https://github.com/webmproject/libwebp
[libxml2]: https://gitlab.gnome.org/GNOME/libxml2
[mozjpeg]: https://github.com/mozilla/mozjpeg
[zlib License, IJG License, BSD-3-Clause]: https://github.com/mozilla/mozjpeg/blob/master/LICENSE.md
[pango]: https://gitlab.gnome.org/GNOME/pango
[pixman]: https://gitlab.freedesktop.org/pixman/pixman
[proxy-libintl]: https://github.com/frida/proxy-libintl
[zlib-ng]: https://github.com/zlib-ng/zlib-ng
[zlib-ng Licence]: https://github.com/zlib-ng/zlib-ng/blob/develop/LICENSE.md

## libvips-all dependencies

Same as libvips-web + these extra dependencies:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [brotli]        | 1.1.0     | MIT Licence                                                  |
| [cfitsio]       | 4.6.2     | BSD-like                                                     |
| [fftw]          | 3.3.10    | GPLv2                                                        |
| [gdk-pixbuf]    | 2.43.3    | LGPLv3                                                       |
| [imagemagick]   | 6.9.13-25 | [ImageMagick License] (Apache-2.0-like)                      |
| [imath]         | 3.1.9     | BSD 3-Clause                                                 |
| [libdicom]      | 1.2.0     | MIT Licence                                                  |
| [libjxl]        | 0.11.1    | BSD 3-Clause                                                 |
| [matio]         | 1.5.28    | BSD 2-Clause                                                 |
| [nifticlib]     | 3.0.1     | Public domain                                                |
| [openexr]       | 3.1.11    | BSD 3-Clause                                                 |
| [openjpeg]      | 2.5.3     | BSD 2-Clause                                                 |
| [openslide]     | 4.0.0     | LGPLv3                                                       |
| [poppler]       | 25.07.0   | GPLv2                                                        |
| [sqlite]        | 3.50.1    | Public domain                                                |

[brotli]: https://github.com/google/brotli
[cfitsio]: https://github.com/HEASARC/cfitsio
[fftw]: https://github.com/FFTW/fftw3
[gdk-pixbuf]: https://gitlab.gnome.org/GNOME/gdk-pixbuf
[imagemagick]: https://github.com/ImageMagick/ImageMagick6
[ImageMagick License]: https://github.com/ImageMagick/ImageMagick6/blob/main/LICENSE
[imath]: https://github.com/AcademySoftwareFoundation/Imath
[libdicom]: https://github.com/ImagingDataCommons/libdicom
[libjxl]: https://github.com/libjxl/libjxl
[matio]: https://github.com/tbeu/matio
[nifticlib]: https://github.com/NIFTI-Imaging/nifti_clib
[openexr]: https://github.com/AcademySoftwareFoundation/openexr
[openjpeg]: https://github.com/uclouvain/openjpeg
[openslide]: https://github.com/openslide/openslide
[poppler]: https://gitlab.freedesktop.org/poppler/poppler
[sqlite]: https://sqlite.org/

## libjpeg-turbo

libvips does not use any of MozJPEG's improvements by default unless explicitly set,
yet one can still choose to build the above variants with [libjpeg-turbo] instead of
[MozJPEG][mozjpeg]. This can be accomplished with the `--with-jpeg-turbo` argument.
For example:

```bash
./build.sh --with-jpeg-turbo
```

In that case, the following version of libjpeg-turbo is built:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [libjpeg-turbo] | 3.1.0     | [zlib License, IJG License]                                  |

[libjpeg-turbo]: https://github.com/libjpeg-turbo/libjpeg-turbo
[zlib License, IJG License]: https://github.com/libjpeg-turbo/libjpeg-turbo/blob/main/LICENSE.md

## jpegli

[jpegli] is an improved JPEG encoder and decoder implementation, fully compatible with
the API/ABI of libjpeg62. It leverages many of the insights from related projects like
[guetzli](https://github.com/google/guetzli), [butteraugli](
https://github.com/google/butteraugli), and [JPEG XL][libjxl] to achieve a higher
quality-per-byte for JPEG images. To enable this, use the `--with-jpegli` argument when
building. For example:

```bash
./build.sh --with-jpegli
```

In that case, the following version of jpegli is built:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [jpegli]        | [5126d62] | BSD 3-Clause                                                 |

[5126d62]: https://github.com/google/jpegli/commit/5126d62d24d368f0ceadd53454653edeb9086386

[jpegli]: https://github.com/google/jpegli

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
| [zlib]          | 1.3.1     | [zlib Licence]                                               |

[zlib]: https://github.com/madler/zlib
[zlib Licence]: https://github.com/madler/zlib/blob/develop/LICENSE

## HEVC-related dependencies

The above variants can optionally be built with [libde265] and [x265] to process
HEIC images. This can be turned on with the `--with-hevc` argument. For example:

```bash
./build.sh --with-hevc
```

These dependencies include HEVC-related logic and are therefore not included in the
prebuilt binaries while it is patent-encumbered.

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [libde265]      | 1.0.16    | LGPLv3                                                       |
| [x265]          | 4.1       | GPLv2                                                        |

[libde265]: https://github.com/strukturag/libde265
[x265]: https://bitbucket.org/multicoreware/x265_git/wiki/Home
