set(DEVICE                  STM32F401xE) # Select your device
set(EXTERNAL_CLOCK          8000000)
option(USE_HAL "Enable HAL" OFF) # ON|OFF

set(SERIES_CPU        cortex-m4)
include(cmake/MappedTarget.cmake)

set(CPU_PARAMETERS ${CPU_PARAMETERS}
        -mthumb
        -mcpu=${SERIES_CPU}
        -mfloat-abi=soft
        -O0
        -Wall
        -Wextra
        -g
        -gdwarf-2
)

set(COMPILER_DEFINE ${COMPILER_DEFINE}
        ${MAPPED_DEVICE}
        NDEBUG
        HSE_VALUE=${EXTERNAL_CLOCK}
        CALL_ARM_SYSTEM_INIT
)

if(USE_HAL)
    set(COMPILER_DEFINE  ${COMPILER_DEFINE} USE_HAL_DRIVER)
endif ()