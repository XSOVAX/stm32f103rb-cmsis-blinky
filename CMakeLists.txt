
cmake_minimum_required(VERSION 3.20)

project(stm32f103rb_cmsis_blinky C ASM)

# Определяем макрос устройства, если задан
if(STM32F103xB)
    add_definitions(-DSTM32F103xB)
endif()



# Явно указываем исходники
file(GLOB_RECURSE SOURCES
    "src/*.c"
    "startup/*.s"
    "cmsis/device/Source/Templates/system_stm32f1xx.c"
)

# Указываем пути для заголовков
include_directories(
    inc
    cmsis/core
    cmsis/device/Include
)

# Создаём исполняемый файл .elf
add_executable(${PROJECT_NAME}.elf ${SOURCES})

# Указываем линкер-скрипт
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/linker/STM32F103RB_FLASH.ld)


# Флаги линковки
target_link_options(${PROJECT_NAME}.elf PRIVATE
    -T${LINKER_SCRIPT}
    -nostdlib
    -lc
    -lgcc
    -Wl,--gc-sections
    -Wl,-Map=${PROJECT_NAME}.map
)

# Генерация .hex
add_custom_target(${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O ihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex
    DEPENDS ${PROJECT_NAME}.elf
    COMMENT "Generating HEX file"
)

# Генерация .bin
add_custom_target(${PROJECT_NAME}.bin
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    DEPENDS ${PROJECT_NAME}.elf
    COMMENT "Generating BIN file"
)

# Цель: прошивка через OpenOCD
add_custom_target(flash
    COMMAND openocd
        -f interface/stlink.cfg
        -f target/stm32f1x.cfg
        -c "init"
        -c "reset halt"
        -c "flash write_image erase ${PROJECT_NAME}.hex"
        -c "reset run"
        -c "shutdown"
    DEPENDS ${PROJECT_NAME}.hex
    COMMENT "Flashing STM32 via ST-Link"
)

# Цель: показать размер прошивки
add_custom_target(size
    COMMAND ${CMAKE_SIZE_UTIL} ${PROJECT_NAME}.elf
    DEPENDS ${PROJECT_NAME}.elf
    COMMENT "Showing firmware size"
)
