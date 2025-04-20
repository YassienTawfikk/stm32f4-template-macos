set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(ARM_TOOLCHAIN_DIR "/usr/local/bin")

if (MINGW OR CYGWIN OR WIN32)
    set(Extension .exe)
endif ()

set(TOOLCHAIN_PREFIX arm-none-eabi-)


set(C_FLAGS "-fdata-sections -ffunction-sections -fsigned-char -fmessage-length=0 -ffreestanding")
set(CPP_FLAGS "-fno-rtti -fno-exceptions -fno-threadsafe-statics")

# Define compiler settings
set(CMAKE_C_COMPILER ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}gcc${Extension} ${C_FLAGS})
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}g++${Extension} ${C_FLAGS} ${CPP_FLAGS})
set(CMAKE_LINKER ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}ld${Extension})
set(CMAKE_OBJCOPY ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}objcopy${Extension})
set(CMAKE_SIZE ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}size${Extension})

set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")

