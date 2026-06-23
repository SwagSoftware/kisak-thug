
FILE(GLOB QMAKE_SRCS "*.cpp")

source_group("Sources" FILES ${QMAKE_SRCS})
add_executable(QMake ${QMAKE_SRCS})
set_property(TARGET QMake PROPERTY CXX_STANDARD 98)
target_compile_definitions(QMake PRIVATE __INLINE_MEMGLOBALS__ __PLAT_TOOL__ __PLAT_WIN32__ __LINUX__)
INSTALL(TARGETS QMake)