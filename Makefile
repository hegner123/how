TESTS_INIT=tests/minimal_init.lua
TESTS_DIR=tests/
LOG_FILE=logs/test_output.log
PLUGIN_NAME=how
NVIM_CONFIG_DIR=$(HOME)/.config/nvim
NVIM_DATA_DIR=$(HOME)/.local/share/nvim

.PHONY: test install help

help:
	@echo "Available targets:"
	@echo "  test     - Run tests using plenary.nvim"
	@echo "  install  - Copy plugin to Neovim plugin directories"
	@echo "  help     - Show this help message"

install:
	@echo "Installing $(PLUGIN_NAME) plugin to Neovim directories..."
	@mkdir -p $(NVIM_CONFIG_DIR)/pack/plugins/start/$(PLUGIN_NAME)
	@cp -r lua/ $(NVIM_CONFIG_DIR)/pack/plugins/start/$(PLUGIN_NAME)/
	@echo "Plugin installed to $(NVIM_CONFIG_DIR)/pack/plugins/start/$(PLUGIN_NAME)"

test:
	@mkdir -p $(dir ${LOG_FILE})
	@nvim \
		--headless \
		--noplugin \
		-u ${TESTS_INIT} \
		-c "PlenaryBustedDirectory ${TESTS_DIR} { minimal_init = '${TESTS_INIT}' }" \
		> ${LOG_FILE} 2>&1
	@cat ${LOG_FILE}
