SCRIPT = tna.sh
COMMAND_NAME = tna

PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin

.PHONY: install uninstall

install:
	@echo "Installing $(COMMAND_NAME) in $(BINDIR)..."
	@mkdir -p $(BINDIR)
	sudo install -m 755 $(SCRIPT) $(BINDIR)/$(COMMAND_NAME)
	@echo "Done! To run, use: $(COMMAND_NAME)"

# Target per rimuovere il comando
uninstall:
	@echo "Uninstalling $(COMMAND_NAME)"
	sudo rm -f $(BINDIR)/$(COMMAND_NAME)
	@echo "Command removed. To install again, run \"make install\""

