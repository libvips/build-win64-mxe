# build-win64-mxe

Experiment with building a libvips binary for 64-bit Windows with [MXE](https://github.com/mxe/mxe).

## Dependencies updates
| Name | [MXE](https://github.com/mxe/mxe) version | [build-win64](https://github.com/jcupitt/build-win64) version | New version | &#x1F53A;/&#x1F537;/&#x1F53B; | Notes
| --- | --- | --- | --- | --- | --- |
| [expat](https://github.com/libexpat/libexpat) | [2.2.5](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/expat.mk#L7) | [2.2.5](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L261) | 2.2.5 | &#x1F537; | -
| [fftw](https://github.com/FFTW/fftw3) | [3.3.6-pl1](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/fftw.mk#L6) | [3.3.7](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L481) | 3.3.8 | &#x1F53A; | -
| [giflib](https://sourceforge.net/projects/giflib/) | [5.1.4](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/giflib.mk#L6) | [5.1.4](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L387) | 5.1.4 | &#x1F537; | -
| [glib](https://github.com/GNOME/glib) | [2.50.2](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/glib.mk#L7) | [2.54.2](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L760) | 2.54.2 | &#x1F537; | -
| [imagemagick](https://github.com/ImageMagick/ImageMagick6) | [6.9.0-0](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/imagemagick.mk#L7) | [6.8.9](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L663) | 6.9.10-4 | &#x1F53A; | -
| [lcms](https://github.com/mm2/Little-CMS) | [2.9](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/lcms.mk#L6) | [2.9](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L494) | 2.9 | &#x1F537; | -
| [libexif](https://github.com/libexif/libexif) | - | [0.6.21](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L601) | 0.6.21 | &#x1F537; | + shutter speed math exception patch.
| [libgsf](https://github.com/GNOME/libgsf) | [1.14.30](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libgsf.mk#L6) | [1.14.42](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L865) | 1.14.42 | &#x1F537; | -
| [libjpeg-turbo](https://libjpeg-turbo.org/) | [1.5.3](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libjpeg-turbo.mk#L6) | [1.5.3](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L580) | 1.5.3 | &#x1F537; | Replaced [this patch](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/patches/libjpeg-turbo-bool.patch) with [this one](https://github.com/Alexpux/MINGW-packages/blob/65b698ce5ddc501b9aa9fb649b640f44284eb6df/mingw-w64-libjpeg-turbo/0001-header-compat.mingw.patch).
| [libpng](https://github.com/glennrp/libpng) | [1.6.34](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libpng.mk#L6) | [1.6.30](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L368) | 1.6.34 | &#x1F53A; | -
| [librsvg](https://github.com/GNOME/librsvg) | [2.40.5](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/librsvg.mk#L6) | [2.40.19](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L420) | 2.43.1 | &#x1F53A; | Requires the Rust toolchain + added patch for 'librsvg_internals' linking.
| [libwebp](https://github.com/webmproject/libwebp) | [0.4.4](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libwebp.mk#L6) | [0.6.1](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L720) | 1.0.0 | &#x1F53A; | -
| [matio](https://github.com/tbeu/matio) | [1.5.2](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/matio.mk#L6) | [1.5.6](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L940) | 1.5.12 | &#x1F53A; | -
| [openslide](https://github.com/openslide/openslide) | - | [3.4.1](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L552) | 3.4.1 | &#x1F537; | Added some MXE specific patches.
| [pango](https://www.pango.org/) | [1.37.4](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/pango.mk#L7) | [1.40.14](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L821) | 1.42.1 | &#x1F53A; | -
| [poppler](https://poppler.freedesktop.org/) | [0.51.0](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/poppler.mk#L6) | [0.46.0](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L462) | 0.66.0 | &#x1F53A; | Switched to CMake.
| [tiff](http://www.simplesystems.org/libtiff/) | [4.0.9](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/tiff.mk#L7) | [4.0.9](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L627) | 4.0.9 | &#x1F537; | -

## Sub-dependencies updates
| Name | [MXE](https://github.com/mxe/mxe) version | [build-win64](https://github.com/jcupitt/build-win64) version | New version | &#x1F53A;/&#x1F537;/&#x1F53B; | Notes
| --- | --- | --- | --- | --- | --- |
| [cairo](https://cairographics.org/) | [1.15.4](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/cairo.mk#L6) | [1.14.12](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L799) | 1.15.12 | &#x1F53A; | -
| [fontconfig](https://www.fontconfig.org/) | [2.12.6](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/fontconfig.mk#L6) | [2.12.6](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L329) | 2.12.6 | &#x1F537; | -
| [freetype](https://www.freetype.org/) | [2.9.1](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/freetype.mk#L6) | [2.9](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L276) | 2.9.1 | &#x1F53A; | -
| [fribidi](https://github.com/fribidi/fribidi) | [0.19.6](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/fribidi.mk#L7) | - | 0.19.7 | &#x1F53A; (new) | -
| [gdk-pixbuf](https://github.com/GNOME/gdk-pixbuf) | [2.32.3](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/gdk-pixbuf.mk#L7) | [2.36.0](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L847) | 2.36.12 | &#x1F53A; | Thumbnailer cross-compile failure patch added.
| [gettext](https://www.gnu.org/software/gettext/) | [0.19.8.1](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/gettext.mk#L6) | [0.19.8](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L248) | 0.19.8.1 | &#x1F53A; | -
| [harfbuzz](https://github.com/harfbuzz/harfbuzz) | [1.7.6](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/harfbuzz.mk#L7) | [1.7.6](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L295) | 1.7.6 | &#x1F537; | -
| [hdf5](https://www.hdfgroup.org/solutions/hdf5/) | [1.8.12](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/hdf5.mk#L7) | - | 1.8.12 | &#x1F53A; (new) | -
| [libcroco](https://github.com/GNOME/libcroco) | [0.6.2](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libcroco.mk#L7) | [0.6.12](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L400) | 0.6.12 | &#x1F537; | -
| [libffi](https://sourceware.org/libffi/) | [3.2.1](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libffi.mk#L6) | [3.2.1](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L736) | 3.2.1 | &#x1F537; | -
| [libiconv](https://www.gnu.org/software/libiconv/) | [1.15](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libiconv.mk#L6) | [1.15](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L237) | 1.15 | &#x1F537; | -
| [libxml2](https://github.com/GNOME/libxml2) | [2.9.4](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/libxml2.mk#L6) | [2.9.8](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L350) | 2.9.8 | &#x1F537; | -
| [openjpeg](http://www.openjpeg.org/) | [2.3.0](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/openjpeg.mk#L8) | [2.1](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L520) | 2.3.0 | &#x1F53A; | -
| [pixman](http://www.pixman.org/) | [0.33.6](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/pixman.mk#L6) | [0.34.0](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L776) | 0.33.6 | &#x1F53B; | Couldn't find a tarball for version 0.34.0 [here](https://cairographics.org/snapshots/).
| [sqlite](https://www.sqlite.org/) | [3.24.0](https://github.com/mxe/mxe/blob/d6abd58b848ea228f10a994f7d5847d0c3fe83b6/src/sqlite.mk#L7) | [3.22.0](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L538) | 3.24.0 | &#x1F53A; | -
| [zlib](https://zlib.net/) | [1.2.11](https://github.com/mxe/mxe/blob/5d4c388be33414e7a802c4959d3d22f759840587/src/zlib.mk#L6) | [1.2.11](https://github.com/jcupitt/build-win64/blob/c5d82ef4d6caf9f58956ba9d666d42805454d67e/8.6/vips.modules#L225) | 1.2.11 | &#x1F537; | + libz.dll naming patch & switched to CMake.

## Dependencies overview
<details>
 <summary>libvips-web</summary>

```
libvips-42.dll
└───libcairo-2.dll
│   └───libgcc_s_seh-1.dll
│   └───libfontconfig-1.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libexpat-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libfreetype-6.dll
│   │   └───libharfbuzz-0.dll  
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libpixman-1-0.dll
│   │   └───libgcc_s_seh-1.dll
│   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libz1.dll
└───libexif-12.dll
│   └───libintl-8.dll
│       └───libiconv-2.dll
└───libexpat-1.dll
└───libfftw3-3.dll
└───libgif-7.dll
└───libglib-2.0-0.dll
│   └───libintl-8.dll
│       └───libiconv-2.dll
└───libgmodule-2.0-0.dll
│   └───libglib-2.0-0.dll
│       └───libintl-8.dll
└───libgobject-2.0-0.dll
│   └───libglib-2.0-0.dll
│   │   └───libintl-8.dll
│   └───libffi-6.dll
└───libgsf-1-114.dll
│   └───libgio-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgmodule-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   │   └───libz1.dll
│   └───libglib-2.0-0.dll
│   │   └───libintl-8.dll
│   └───libgobject-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libffi-6.dll
│   └───libintl-8.dll
│   │   └───libiconv-2.dll
│   └───libxml2-2.dll
│   │   └───libz1.dll
│   │   └───libiconv-2.dll
│   └───libz1.dll
└───libintl-8.dll
│   └───libiconv-2.dll
└───libjpeg-62.dll
└───liblcms2-2.dll
└───libpango-1.0-0.dll
│   └───libfribidi-0.dll
│   │   └───libglib-2.0-0.dll
│   └───libglib-2.0-0.dll
│   │   └───libintl-8.dll
│   └───libgobject-2.0-0.dll
│       └───libglib-2.0-0.dll
│       └───libffi-6.dll
└───libpangoft2-1.0-0.dll
│   └───libpango-1.0-0.dll
│   │   └───libfribidi-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   └───libfontconfig-1.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libexpat-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libfreetype-6.dll
│   │   └───libharfbuzz-0.dll  
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libglib-2.0-0.dll
│   │   └───libintl-8.dll
│   └───libgobject-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libffi-6.dll
│   └───libharfbuzz-0.dll 
│       └───libgcc_s_seh-1.dll
│       └───libfreetype-6.dll
│       └───libglib-2.0-0.dll
└───libpng16-16.dll
│   └───libz1.dll
└───librsvg-2-2.dll
│   └───libcairo-2.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libfontconfig-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpixman-1-0.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libcroco-0.6-3.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libxml2-2.dll
│   └───libfontconfig-1.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libexpat-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libgdk_pixbuf-2.0-0.dll
│   │   └───libgio-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   │   └───libintl-8.dll
│   │   └───libjpeg-62.dll
│   │   └───libpng16-16.dll
│   │   └───libtiff-5.dll
│   └───libgio-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgmodule-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   │   └───libz1.dll
│   └───libglib-2.0-0.dll
│   │   └───libintl-8.dll
│   └───libgobject-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libffi-6.dll
│   └───libpango-1.0-0.dll
│   │   └───libfribidi-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   └───libpangocairo-1.0-0.dll
│   │   └───libpango-1.0-0.dll
│   │   └───libpangoft2-1.0-0.dll
│   │   └───libpangowin32-1.0-0.dll
│   │   └───libcairo-2.dll
│   │   └───libfontconfig-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   └───libpangoft2-1.0-0.dll
│   │   └───libpango-1.0-0.dll
│   │   └───libfontconfig-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   │   └───libharfbuzz-0.dll 
│   └───libxml2-2.dll
│       └───libz1.dll
│       └───libiconv-2.dll
└───libtiff-5.dll
│   └───libz1.dll
│   └───libjpeg-62.dll
└───libwebp-7.dll
└───libwebpmux-3.dll
│   └───libwebp-7.dll
└───libz1.dll
```
</details>

<details>
 <summary>libvips-all</summary>
Same as libvips-web + these extra dependencies:

```
libvips-42.dll
└───libMagickCore-6.Q16-6.dll
│   └───libcairo-2.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libfontconfig-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpixman-1-0.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libfftw3-3.dll
│   └───libfontconfig-1.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libexpat-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libgobject-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libffi-6.dll
│   └───libjpeg-62.dll
│   └───liblcms2-2.dll
│   └───libopenjp2.dll
│   └───libpango-1.0-0.dll
│   │   └───libfribidi-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   └───libpangocairo-1.0-0.dll
│   │   └───libpango-1.0-0.dll
│   │   └───libpangoft2-1.0-0.dll
│   │   └───libpangowin32-1.0-0.dll
│   │   └───libcairo-2.dll
│   │   └───libfontconfig-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   └───libpng16-16.dll
│   └───libtiff-5.dll
│   │   └───libz1.dll
│   │   └───libjpeg-62.dll
│   └───libwebp-7.dll
│   └───libwebpmux-3.dll
│   │   └───libwebp-7.dll
│   └───libxml2-2.dll
│   │   └───libz1.dll
│   │   └───libiconv-2.dll
│   └───libz1.dll
└───libmatio-4.dll
│   └───libz1.dll
│   └───libhdf5-8.dll
│       └───libz1.dll
└───libopenslide-0.dll
│   └───libcairo-2.dll
│   │   └───libgcc_s_seh-1.dll
│   │   └───libfontconfig-1.dll
│   │   └───libfreetype-6.dll
│   │   └───libpixman-1-0.dll
│   │   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libgdk_pixbuf-2.0-0.dll
│   │   └───libgio-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   │   └───libintl-8.dll
│   │   └───libjpeg-62.dll
│   │   └───libpng16-16.dll
│   │   └───libtiff-5.dll
│   └───libgio-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libgmodule-2.0-0.dll
│   │   └───libgobject-2.0-0.dll
│   │   └───libz1.dll
│   └───libglib-2.0-0.dll
│   │   └───libintl-8.dll
│   └───libgobject-2.0-0.dll
│   │   └───libglib-2.0-0.dll
│   │   └───libffi-6.dll
│   └───libjpeg-62.dll
│   └───libopenjp2.dll
│   └───libpng16-16.dll
│   │   └───libz1.dll
│   └───libsqlite3-0.dll
│   └───libtiff-5.dll
│   │   └───libz1.dll
│   │   └───libjpeg-62.dll
│   └───libxml2-2.dll
│   │   └───libz1.dll
│   │   └───libiconv-2.dll
│   └───libz1.dll
└───libpoppler-glib-8.dll
    └───libpoppler-77.dll
    │   └───libstdc++-6.dll
    │   └───liblcms2-2.dll
    │   └───libopenjp2.dll
    │   └───libjpeg-62.dll
    │   └───libpng16-16.dll
    │   └───libtiff-5.dll
    │   └───libz1.dll
    └───libstdc++-6.dll
    └───libcairo-2.dll
    │   └───libgcc_s_seh-1.dll
    │   └───libfontconfig-1.dll
    │   └───libfreetype-6.dll
    │   └───libpixman-1-0.dll
    │   └───libpng16-16.dll
    │   └───libz1.dll
    └───libfreetype-6.dll
    │   └───libharfbuzz-0.dll  
    │   └───libpng16-16.dll
    │   └───libz1.dll
    └───libgio-2.0-0.dll
    │   └───libglib-2.0-0.dll
    │   └───libgmodule-2.0-0.dll
    │   └───libgobject-2.0-0.dll
    │   └───libz1.dll
    └───libglib-2.0-0.dll
    │   └───libintl-8.dll
    └───libgobject-2.0-0.dll
        └───libglib-2.0-0.dll
        └───libffi-6.dll
```
</details>

## TODO
- [ ] Try to build with [orc](https://github.com/GStreamer/orc).
- [ ] Add [cfitsio](https://heasarc.gsfc.nasa.gov/fitsio/) to the 'all target'. MXE already has [this dependency](https://github.com/mxe/mxe/blob/master/src/cfitsio.mk).
- [ ] Add [OpenEXR](https://github.com/openexr/openexr) to the 'all target'. MXE already has [this dependency](https://github.com/mxe/mxe/blob/master/src/openexr.mk).
- [X] Try to update ImageMagick6 to the latest version (latest versions of ImageMagick are continuous fuzzed by [OSS-Fuzz](https://github.com/google/oss-fuzz), so it'll reduce the attack surface).
- [ ] Try to build libvips as static library.
  - [ ] Does it violate the LGPL license? libvips has a lot of LGPL dependencies.
    - [ ] "[Provide everything that allow the user to relink the application with a different version of the LGPL source code](https://www.gnu.org/licenses/gpl-faq.html#LGPLStaticVsDynamic)".
  - [ ] librsvg can't be build statically ([it's broken on 2.42](https://gitlab.gnome.org/GNOME/librsvg/issues/159), stick with 2.40.20 if we need to build statically).
  - [ ] GObject (libgobject-2.0-0.dll) and GLib (libglib-2.0-0.dll) needs to be build shared (for the libvips bindings).
- [ ] Let Travis build libvips with pre-compiled dependencies.
  - [ ] Wait for: https://github.com/mxe/mxe/issues/2021.
- [ ] Do we need to add `libvipsCC-42.dll` and `libvips-cpp-42.dll`? For NetVips this isn't necessary.
- [ ] Should we include the `etc`, `include`, `lib` and `share` folders? Also this isn't necessary for NetVips.
- [ ] `AUTHORS`, `ChangeLog`, `COPYING` and `README.md` needs to be added.
- [ ] Incorporate all new dependencies and patches into [MXE](https://github.com/mxe/mxe).
  - [ ] Should we also add libvips-web?
  - [ ] Not sure about `librsvg`, because v2.42.0+ requires the Rust toolchain.
- [ ] Do we need to add `expat`, `zlib`, `gettext` to `vips-all_DEPS` and `vips-web_DEPS`?
- [ ] Try to update Pixman to 0.34.0.
