cmake_minimum_required(VERSION 3.30)
include(cmake/ArmToolchain.cmake)

project(stm32-template C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
enable_language(ASM)

set(PROJECT_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(cmake/Device.cmake)
include(cmake/SourceList.cmake)
include(cmake/IncludeList.cmake)

set(LINKER_SCRIPTS_BASE_DIR ${PROJECT_PATH}/STM32-base/linker/)
set(STARTUP_BASE_DIR ${PROJECT_PATH}/STM32-base/startup/)
set(EXECUTABLE ${CMAKE_PROJECT_NAME})

# ✅ Build executable
add_executable(${EXECUTABLE}
        ${SOURCE_LIST}
        ${STARTUP_BASE_DIR}/${SERIES_FOLDER}/${MAPPED_DEVICE}.s
)

# ✅ Linker flags (NO libc, NO startup, use our Reset_Handler)
set_target_properties(${EXECUTABLE} PROPERTIES
        LINK_FLAGS "-nostartfiles -nostdlib -Wl,--gc-sections -Wl,-Map=${PROJECT_NAME}.map -Wl,--entry=Reset_Handler"
)

# ✅ Compiler config
target_include_directories(${EXECUTABLE} PUBLIC ${INCLUDE_LIST})
target_compile_definitions(${EXECUTABLE} PUBLIC ${COMPILER_DEFINE})
target_compile_options(${EXECUTABLE} PUBLIC
        ${CPU_PARAMETERS}
        -Wall
        -Wpedantic
        -Wno-unused-parameter
)

# ✅ Post-build: size and .hex/.bin
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
        COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>
)
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.hex
)
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.bin
)
