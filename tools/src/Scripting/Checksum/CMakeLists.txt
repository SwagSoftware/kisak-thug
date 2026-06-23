
FILE(GLOB CHECKSUM_SRCS "*.cpp")

source_group("Sources" FILES ${CHECKSUM_SRCS})
add_executable(Checksum ${CHECKSUM_SRCS})
set_property(TARGET Checksum PROPERTY CXX_STANDARD 98)
INSTALL(TARGETS Checksum)