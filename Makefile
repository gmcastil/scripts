SCRIPTS_DIR	:= $(PWD)
BIN_DIR		:= $(HOME)/.local/bin

# We will symlink everything that is executable into the BIN_DIR (filter out
# things like .nfs lock files)
EXECUTABLES	:= $(shell find $(SCRIPTS_DIR) -maxdepth 1 -type f -perm /111 -not -name '.*')

.PHONY: install
install:
	mkdir -pv $(BIN_DIR)
	for script in $(EXECUTABLES); do \
		ln -sfv $$script $(BIN_DIR)/; \
	done

