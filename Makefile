.PHONY: update-formula help

help:
	@echo "Usage: make update-formula RELEASE=v0.2.0"
	@echo ""
	@echo "This will fetch the release tarball, compute SHA256, and output formula values"

update-formula:
	@if [ -z "$(RELEASE)" ]; then \
		echo "Error: RELEASE variable not set"; \
		echo "Usage: make update-formula RELEASE=v0.2.0"; \
		exit 1; \
	fi
	@$(MAKE) _fetch-and-compute RELEASE=$(RELEASE)

_fetch-and-compute:
	@echo "Fetching release $(RELEASE)..."
	@TMPDIR=$$(mktemp -d) && \
	trap "rm -rf $$TMPDIR" EXIT && \
	cd $$TMPDIR && \
	curl -sL -o wall-e.tar.gz "https://github.com/kallepronk/wall-e/archive/refs/tags/$(RELEASE).tar.gz" && \
	if [ ! -f wall-e.tar.gz ]; then \
		echo "Error: Failed to download release"; \
		exit 1; \
	fi && \
	SHA256=$$(shasum -a 256 wall-e.tar.gz | awk '{print $$1}') && \
	echo "" && \
	echo "=== Update values for walle.rb ===" && \
	echo "" && \
	echo "url \"https://github.com/kallepronk/wall-e/archive/refs/tags/$(RELEASE).tar.gz\"" && \
	echo "sha256 \"$$SHA256\"" && \
	echo "" && \
	echo "Copy these values into Formula/walle.rb"

