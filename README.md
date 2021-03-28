# build-win64-mxe

Experiment with building a libvips binary for Windows with [MXE](https://github.com/mxe/mxe).

## libvips-web dependencies

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [cairo]         | 1.17.4    | Mozilla Public License 2.0                                   |
| [dav1d]         | 0.8.2     | BSD 2-Clause + [Alliance for Open Media Patent License 1.0]  |
| [expat]         | 2.2.10    | MIT Licence                                                  |
| [fontconfig]    | 2.13.93   | [fontconfig Licence] (BSD-like)                              |
| [freetype]      | 2.10.4    | [freetype Licence] (BSD-like)                                |
| [fribidi]       | 1.0.10    | LGPLv3                                                       |
| [gdk-pixbuf]    | 2.42.2    | LGPLv3                                                       |
| [giflib]        | 5.1.4     | MIT Licence                                                  |
| [glib]          | 2.67.4    | LGPLv3                                                       |
| [harfbuzz]      | 2.7.4     | MIT Licence                                                  |
| [lcms]          | 2.12      | MIT Licence                                                  |
| [libexif]       | 0.6.22    | LGPLv3                                                       |
| [libffi]        | 3.3       | MIT Licence                                                  |
| [libgsf]        | 1.14.47   | LGPLv3                                                       |
| [libheif]       | 1.11.0    | LGPLv3                                                       |
| [libjpeg-turbo] | 2.0.6     | [zlib License, IJG License]                                  |
| [libpng]        | 1.6.37    | [libpng License version 2]                                   |
| [librsvg]       | 2.51.0    | LGPLv3                                                       |
| [libspng]       | 0.6.2     | BSD 2-Clause                                                 |
| [libtiff]       | 4.2.0     | [libtiff License] (BSD-like)                                 |
| [libvips]       | 8.10.5    | LGPLv3                                                       |
| [libwebp]       | 1.2.0     | New BSD License                                              |
| [libxml2]       | 2.9.10    | MIT Licence                                                  |
| [orc]           | 0.4.32    | [orc License] (BSD-like)                                     |
| [pango]         | 1.48.2    | LGPLv3                                                       |
| [pixman]        | 0.40.0    | MIT Licence                                                  |
| [rav1e]         | 0.4.0     | BSD 2-Clause + [Alliance for Open Media Patent License 1.0]  |
| [zlib]          | 1.2.11    | [zlib Licence]                                               |

[Alliance for Open Media Patent License 1.0]: https://aomedia.org/license/patent-license/
[cairo]: https://gitlab.freedesktop.org/cairo/cairo
[dav1d]: https://code.videolan.org/videolan/dav1d
[expat]: https://github.com/libexpat/libexpat
[fontconfig]: https://gitlab.freedesktop.org/fontconfig/fontconfig
[fontconfig Licence]: https://gitlab.freedesktop.org/fontconfig/fontconfig/blob/master/COPYING
[freetype]: https://git.savannah.gnu.org/cgit/freetype/freetype2.git
[freetype Licence]: https://git.savannah.gnu.org/cgit/freetype/freetype2.git/tree/docs/FTL.TXT
[fribidi]: https://github.com/fribidi/fribidi
[gdk-pixbuf]: https://gitlab.gnome.org/GNOME/gdk-pixbuf
[giflib]: https://sourceforge.net/projects/giflib/
[glib]: https://gitlab.gnome.org/GNOME/glib
[harfbuzz]: https://github.com/harfbuzz/harfbuzz
[lcms]: https://github.com/mm2/Little-CMS
[libexif]: https://github.com/libexif/libexif
[libffi]: https://github.com/libffi/libffi
[libgsf]: https://gitlab.gnome.org/GNOME/libgsf
[libheif]: https://github.com/strukturag/libheif
[libjpeg-turbo]: https://github.com/libjpeg-turbo/libjpeg-turbo
[zlib License, IJG License]: https://github.com/libjpeg-turbo/libjpeg-turbo/blob/master/LICENSE.md
[libpng]: https://github.com/glennrp/libpng
[libpng License version 2]: https://github.com/glennrp/libpng/blob/master/LICENSE
[librsvg]: https://gitlab.gnome.org/GNOME/librsvg
[libspng]: https://github.com/randy408/libspng
[libtiff]: https://gitlab.com/libtiff/libtiff
[libtiff License]: https://libtiff.gitlab.io/libtiff/misc.html
[libvips]: https://github.com/libvips/libvips
[libwebp]: https://github.com/webmproject/libwebp
[libxml2]: https://gitlab.gnome.org/GNOME/libxml2
[orc]: https://gitlab.freedesktop.org/gstreamer/orc
[orc License]: https://gitlab.freedesktop.org/gstreamer/orc/blob/master/COPYING
[pango]: https://gitlab.gnome.org/GNOME/pango
[pixman]: https://gitlab.freedesktop.org/pixman/pixman
[rav1e]: https://github.com/xiph/rav1e
[zlib]: https://github.com/madler/zlib
[zlib Licence]: https://github.com/madler/zlib/blob/master/zlib.h

## libvips-all dependencies

Same as libvips-web + these extra dependencies:

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [cfitsio]       | 3.49      | BSD-like                                                     |
| [fftw]          | 3.3.9     | GPLv2                                                        |
| [hdf5]          | 1.12.0    | BSD-like                                                     |
| [imagemagick]   | 6.9.11-62 | [ImageMagick License] (GPL-like)                             |
| [matio]         | 1.5.19    | BSD 2-Clause                                                 |
| [nifticlib]     | 2.0.0     | Public domain                                                |
| [openexr]       | 2.5.5     | BSD 3-Clause                                                 |
| [openjpeg]      | 2.4.0     | BSD 2-Clause                                                 |
| [openslide]     | 3.4.1     | LGPLv3                                                       |
| [poppler]       | 21.02.0   | GPLv2                                                        |
| [sqlite]        | 3.34.1    | Public domain                                                |

[cfitsio]: https://heasarc.gsfc.nasa.gov/fitsio/
[hdf5]: https://www.hdfgroup.org/solutions/hdf5/
[fftw]: https://github.com/FFTW/fftw3
[imagemagick]: https://github.com/ImageMagick/ImageMagick6
[ImageMagick License]: https://www.imagemagick.org/script/license.php
[matio]: https://github.com/tbeu/matio
[nifticlib]: https://nifti.nimh.nih.gov/
[openexr]: https://github.com/AcademySoftwareFoundation/openexr
[openjpeg]: https://github.com/uclouvain/openjpeg
[openslide]: https://github.com/openslide/openslide
[poppler]: https://gitlab.freedesktop.org/poppler/poppler
[sqlite]: https://www.sqlite.org/

## MozJPEG

MozJPEG is a libjpeg-turbo fork that provides increased compression for JPEG images
(at the expense of compression performance). The above variants can optionally be built
with MozJPEG instead of libjpeg-turbo. This can be turned on with the `--with-mozjpeg`
argument. For example:

```bash
./build.sh --with-mozjpeg
```

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [mozjpeg]       | 4.0.0     | [zlib License, IJG License]                                  |

[mozjpeg]: https://github.com/mozilla/mozjpeg

## aom

aom is the reference implementation (encoder and decoder) of the AV1 codec. Since this
is the former research codec, it has the advantage to cover all use cases, but at the
general cost of performance. The above variants can optionally be built with aom instead
of dav1d and rav1e. This can be turned on with the `--with-aom` argument. For example:

```bash
./build.sh --with-aom
```

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [aom]           | 2.0.2     | BSD 2-Clause + [Alliance for Open Media Patent License 1.0]  |

[aom]: https://aomedia.googlesource.com/aom/

## HEVC-related dependencies

The above "all" variant can optionally be built with libde265 and x265 to process
HEIC/HEIF images. This can be turned on with the `--with-hevc` argument. For example:

```bash
./build.sh all --with-hevc
```

These dependencies include HEVC-related logic and are therefore not included in the
prebuilt binaries while it is patent-encumbered.

| Dependency      | Version   | Used under the terms of                                      |
|-----------------|-----------|--------------------------------------------------------------|
| [libde265]      | 1.0.8     | LGPLv3                                                       |
| [x265]          | 3.4       | GPLv2                                                        |

[libde265]: https://github.com/strukturag/libde265
[x265]: https://bitbucket.org/multicoreware/x265_git/wiki/Home
