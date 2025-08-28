
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

if(_IMPORT_PREFIX STREQUAL "/")
    set(_IMPORT_PREFIX "")
endif()

add_library(ffmpeg::avutil SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avutil PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/avutil-59.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/avutil.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)

add_library(ffmpeg::swresample SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::swresample PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/swresample-5.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/swresample.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil"
)

add_library(ffmpeg::avcodec SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avcodec PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/avcodec-61.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/avcodec.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::swresample"
)

add_library(ffmpeg::avformat SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avformat PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/avformat-61.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/avformat.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::avcodec"
)

add_library(ffmpeg::postproc SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::postproc PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/postproc-58.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/postproc.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil"
)

add_library(ffmpeg::swscale SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::swscale PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/swscale-8.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/swscale.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil"
)

add_library(ffmpeg::avfilter SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avfilter PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/avfilter-10.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/avfilter.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::avcodec;ffmpeg::avformat;ffmpeg::swscale;ffmpeg::postproc;ffmpeg::swresample"
)

add_library(ffmpeg::avdevice SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avdevice PROPERTIES
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/avdevice-61.dll"
    IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/avdevice.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::avcodec;ffmpeg::avformat;ffmpeg::avfilter"
)

set(_IMPORT_PREFIX)
