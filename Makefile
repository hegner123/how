TESTS_INIT=tests/minimal_init.lua
TESTS_DIR=tests/
LOG_FILE=logs/test_output.log
.PHONY: test

test:
	@mkdir -p $(dir ${LOG_FILE})
	@nvim \
		--headless \
		--noplugin \
		-u ${TESTS_INIT} \
		-c "PlenaryBustedDirectory ${TESTS_DIR} { minimal_init = '${TESTS_INIT}' }" \
		> ${LOG_FILE} 2>&1
