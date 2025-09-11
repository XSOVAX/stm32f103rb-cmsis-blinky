BUILD_DIR := build
TARGET := stm32f103rb_cmsis_blinky

.PHONY: all build flash clean size rebuild hex bin

all: build hex bin

build:
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/arm-gcc.cmake -DSTM32F103xB=1 .. && make -j$(shell nproc) 2>/dev/null
	@echo "✅ Build complete: $(BUILD_DIR)/$(TARGET).elf"

hex:
	@cd $(BUILD_DIR) && make ${TARGET}.hex
	@echo "✅ HEX generated: $(BUILD_DIR)/$(TARGET).hex"

bin:
	@cd $(BUILD_DIR) && make ${TARGET}.bin
	@echo "✅ BIN generated: $(BUILD_DIR)/$(TARGET).bin"

flash: build hex
	@echo "🔌 Flashing via ST-Link..."
	@cd $(BUILD_DIR) && make flash

size: build
	@cd $(BUILD_DIR) && make size

clean:
	@rm -rf $(BUILD_DIR)
	@echo "🧹 Cleaned build directory"

rebuild: clean build hex bin
	@echo "🔄 Full rebuild complete"
