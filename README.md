# 🚀 STM32F103RB CMSIS Bare-Metal Project — No HAL, No IDE

> ✅ Чистый embedded на регистрах — без HAL, без CubeMX, без GUI-IDE  
> ✅ Сборка через CMake + Make  
> ✅ Прошивка через OpenOCD  
> ✅ Готов к CI/CD, Docker, Jenkins  
> ✅ Минимальный, масштабируемый, контролируемый

---

## 📦 Что умеет проект

- Мигает светодиодом LD2 (PA5) на плате **Nucleo-F103RB**
- Использует **регистры напрямую** — без HAL, без CubeMX
- Собирается **из консоли** — одной командой
- Прошивается **через ST-Link** — без GUI
- Генерирует `.hex`, `.bin`, `.map`
- Готов к расширению: UART, SPI, I2C, FreeRTOS

---

## 📂 Откуда файлы

| Компонент | Источник | Примечание |
|-----------|----------|------------|
| **CMSIS-Core** | [ARM-software/CMSIS_5](https://github.com/ARM-software/CMSIS_5) | Заголовки ядра Cortex-M3 (`core_cm3.h`, `cmsis_gcc.h`) |
| **CMSIS-Device (STM32F1)** | [STMicroelectronics/cmsis_device_f1](https://github.com/STMicroelectronics/cmsis_device_f1) | Заголовки периферии (`stm32f103xb.h`), `system_stm32f1xx.c`, startup-файлы |
| **Startup-файл** | `cmsis/device/Source/Templates/gcc/startup_stm32f103xb.s` | Версия для GCC (не для Keil!) |
| **Линкер-скрипт** | Написан вручную — `linker/STM32F103RB_FLASH.ld` | Распределение FLASH/RAM, стек, `.data`, `.bss` |

---

## 🛠 Поддерживаемые сборки

| Сборка | Команда | Описание |
|--------|---------|----------|
| **Debug** | `make` | Сборка с отладочной информацией (`-g -O0`) |
| **Release** | `make release` | Оптимизация по размеру (`-Os -DNDEBUG`) |
| **Прошивка** | `make flash` | Прошивка через ST-Link + OpenOCD |
| **Размер** | `make size` | Показывает размер прошивки |
| **Очистка** | `make clean` | Удаляет папку `build/` |
| **Полная пересборка** | `make rebuild` | `clean` + `build` + `hex` + `bin` |

---

## ⚙️ Требования

- **ОС**: Linux (Manjaro, Ubuntu), WSL2
- **Компилятор**: `arm-none-eabi-gcc`
- **Инструменты**: `cmake`, `make`, `openocd`
- **Плата**: Nucleo-F103RB (или совместимая)
- **Программатор**: ST-Link (встроен в Nucleo)


