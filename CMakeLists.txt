cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

project(ffmpeg VERSION 7.1.1)

option(FFMPEG_INSTALL "Install ffmpeg library" OFF)

add_library(ffmpeg::avutil SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avutil PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/avutil-59.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/avutil.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

add_library(ffmpeg::swresample SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::swresample PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/swresample-5.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/swresample.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil"
)

add_library(ffmpeg::avcodec SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avcodec PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/avcodec-61.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/avcodec.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::swresample"
)

add_library(ffmpeg::avformat SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avformat PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/avformat-61.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/avformat.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::avcodec"
)

add_library(ffmpeg::postproc SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::postproc PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/postproc-58.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/postproc.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil"
)

add_library(ffmpeg::swscale SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::swscale PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/swscale-8.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/swscale.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil"
)

add_library(ffmpeg::avfilter SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avfilter PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/avfilter-10.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/avfilter.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::avcodec;ffmpeg::avformat;ffmpeg::swscale;ffmpeg::postproc;ffmpeg::swresample"
)

add_library(ffmpeg::avdevice SHARED IMPORTED GLOBAL)
set_target_properties(ffmpeg::avdevice PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/avdevice-61.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/avdevice.lib"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
    INTERFACE_LINK_LIBRARIES "ffmpeg::avutil;ffmpeg::avcodec;ffmpeg::avformat;ffmpeg::avfilter"
)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/ParseDependTargets.cmake)

include(GNUInstallDirs)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR} COMPONENT ffmpegDev FILES_MATCHING PATTERN "*")
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib/ DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT ffmpegDev FILES_MATCHING PATTERN "*")
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/ DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT ffmpegRuntime FILES_MATCHING PATTERN "*")
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/presets/ DESTINATION presets COMPONENT ffmpegRuntime FILES_MATCHING PATTERN "*")
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ffmpegTargets.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ffmpeg COMPONENT ffmpegDev)

include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ffmpegConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/ffmpegConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ffmpeg
)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/cmake/ffmpegConfig.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ffmpeg COMPONENT ffmpegDev)

include(InstallRequiredSystemLibraries)

set(CPACK_PACKAGE_NAME "ffmpeg")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_VENDER "xqliang")
set(CPACK_PACKAGE_CONTACT "hicacheus@outlook.com")
set(CPACK_GENERATOR "ZIP")
include(CPack)