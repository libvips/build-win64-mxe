# build-win64-mxe

Experiment with building a libvips binary for Windows with [MXE](https://github.com/mxe/mxe).

## libvips-web dependencies
| Dependency      | Version   | Used under the terms of         |
|-----------------|-----------|---------------------------------|
| [cairo]         | 1.17.2    | Mozilla Public License 2.0      |
| [expat]         | 2.2.9     | MIT Licence                     |
| [fontconfig]    | 2.13.92   | [fontconfig Licence] (BSD-like) |
| [freetype]      | 2.10.1    | [freetype Licence] (BSD-like)   |
| [fribidi]       | 1.0.8     | LGPLv3                          |
| [gdk-pixbuf]    | 2.40.0    | LGPLv3                          |
| [gettext]       | 0.20.1    | LGPLv3                          |
| [giflib]        | 5.1.4     | MIT Licence                     |
| [glib]          | 2.63.3    | LGPLv3                          |
| [harfbuzz]      | 2.6.4     | MIT Licence                     |
| [lcms]          | 2.9       | MIT Licence                     |
| [libexif]       | 0.6.21    | LGPLv3                          |
| [libffi]        | 3.3       | MIT Licence                     |
| [libgsf]        | 1.14.46   | LGPLv3                          |
| [libiconv]      | 1.16      | LGPLv3                          |
| [libjpeg-turbo] | 2.0.3     | [zlib License, IJG License]     |
| [libpng]        | 1.6.37    | [libpng License version 2]      |
| [librsvg]       | 2.47.1    | LGPLv3                          |
| [libtiff]       | 4.1.0     | [libtiff License] (BSD-like)    |
| [libvips]       | 8.8.4     | LGPLv3                          |
| [libwebp]       | 1.0.3     | New BSD License                 |
| [libxml2]       | 2.9.10    | MIT Licence                     |
| [orc]           | 0.4.31    | [orc License] (BSD-like)        |
| [pango]         | 1.44.7    | LGPLv3                          |
| [pixman]        | 0.38.4    | MIT Licence                     |
| [zlib]          | 1.2.11    | [zlib Licence]                  |

[cairo]: https://cairographics.org/
[expat]: https://libexpat.github.io/
[fontconfig]: https://www.fontconfig.org/
[fontconfig Licence]: https://gitlab.freedesktop.org/fontconfig/fontconfig/blob/master/COPYING
[freetype]: https://www.freetype.org/
[freetype Licence]: http://git.savannah.gnu.org/cgit/freetype/freetype2.git/tree/docs/FTL.TXT
[fribidi]: https://github.com/fribidi/fribidi
[gdk-pixbuf]: https://gitlab.gnome.org/GNOME/gdk-pixbuf
[gettext]: https://www.gnu.org/software/gettext/
[giflib]: https://sourceforge.net/projects/giflib/
[glib]: https://gitlab.gnome.org/GNOME/glib
[harfbuzz]: https://github.com/harfbuzz/harfbuzz
[lcms]: https://github.com/mm2/Little-CMS
[libexif]: https://github.com/libexif/libexif
[libffi]: https://sourceware.org/libffi/
[libgsf]: https://gitlab.gnome.org/GNOME/libgsf
[libiconv]: https://www.gnu.org/software/libiconv/
[libjpeg-turbo]: https://github.com/libjpeg-turbo/libjpeg-turbo
[zlib License, IJG License]: https://github.com/libjpeg-turbo/libjpeg-turbo/blob/master/LICENSE.md
[libpng]: https://github.com/glennrp/libpng
[libpng License version 2]: http://www.libpng.org/pub/png/src/libpng-LICENSE.txt
[librsvg]: https://gitlab.gnome.org/GNOME/librsvg
[libtiff]: https://libtiff.gitlab.io/libtiff/
[libtiff License]: https://libtiff.gitlab.io/libtiff/misc.html
[libvips]: https://github.com/libvips/libvips
[libwebp]: https://github.com/webmproject/libwebp
[libxml2]: https://gitlab.gnome.org/GNOME/libxml2
[orc]: https://gitlab.freedesktop.org/gstreamer/orc
[orc License]: https://gitlab.freedesktop.org/gstreamer/orc/blob/master/COPYING
[pango]: https://www.pango.org/
[pixman]: http://www.pixman.org/
[zlib]: https://zlib.net/
[zlib Licence]: https://github.com/madler/zlib/blob/master/zlib.h

## libvips-all dependencies
Same as libvips-web + these extra dependencies:

| Dependency      | Version   | Used under the terms of          |
|-----------------|-----------|----------------------------------|
| [cfitsio]       | 3.470     | BSD-like                         |
| [fftw]          | 3.3.8     | GPLv2                            |
| [hdf5]          | 1.10.6    | BSD-like                         |
| [imagemagick]   | 6.9.10-80 | [ImageMagick License] (GPL-like) |
| [libde265]      | 1.0.4     | LGPLv3                           |
| [libheif]       | 1.6.1     | LGPLv3                           |
| [matio]         | 1.5.17    | BSD 2-Clause                     |
| [nifticlib]     | 2.0.0     | Public domain                    |
| [openexr]       | 2.4.0     | BSD 3-Clause                     |
| [openjpeg]      | 2.3.1     | BSD 2-Clause                     |
| [openslide]     | 3.4.1     | LGPLv3                           |
| [poppler]       | 0.83.0    | GPLv2                            |
| [sqlite]        | 3.30.1    | Public domain                    |
| [x265]          | 3.2.1     | GPLv2                            |

[cfitsio]: https://heasarc.gsfc.nasa.gov/fitsio/
[hdf5]: https://www.hdfgroup.org/solutions/hdf5/
[fftw]: https://github.com/FFTW/fftw3
[imagemagick]: https://github.com/ImageMagick/ImageMagick6
[ImageMagick License]: https://www.imagemagick.org/script/license.php
[libde265]: https://github.com/strukturag/libde265
[libheif]: https://github.com/strukturag/libheif
[matio]: https://github.com/tbeu/matio
[nifticlib]: https://nifti.nimh.nih.gov/
[openexr]: https://github.com/AcademySoftwareFoundation/openexr
[openjpeg]: http://www.openjpeg.org/
[openslide]: https://github.com/openslide/openslide
[poppler]: https://poppler.freedesktop.org/
[sqlite]: https://www.sqlite.org/
[x265]: http://x265.org/

## MozJPEG
MozJPEG is a libjpeg-turbo fork that provides increased compression for JPEG images
(at the expense of compression performance). The above variants can optionally be built
with MozJPEG instead of libjpeg-turbo. This can be turned on with the `--with-mozjpeg`
argument. For example:

```bash
./build.sh --with-mozjpeg
```

| Dependency      | Version   | Used under the terms of          |
|-----------------|-----------|----------------------------------|
| [mozjpeg]       | 68564c0¹  | [zlib License, IJG License]      |

¹ MozJPEG is built from master to maintain binary compatibility with libjpeg-turbo.

[mozjpeg]: https://github.com/mozilla/mozjpeg
