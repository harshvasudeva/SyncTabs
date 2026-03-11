BINARY_WIN    = dist/synctabs-companion.exe
BINARY_DARWIN = dist/synctabs-companion-darwin
BINARY_LINUX  = dist/synctabs-companion-linux
INSTALLER     = dist/SyncTabs-Companion-Setup.exe
VERSION       = 1.0.0
MODULE        = github.com/harshvasudeva/synctabs-companion

.PHONY: all build build-windows build-darwin build-linux build-debug installer icons clean deps generate

all: build

## Install Go dependencies
deps:
	go mod tidy

## Generate Windows version info resource (.syso)
generate: deps
	go install github.com/josephspurrier/goversioninfo/cmd/goversioninfo@latest
	go generate ./...

## Build the Windows executable (no console window, stripped)
build: build-windows

build-windows: deps generate
	@mkdir -p dist
	GOOS=windows GOARCH=amd64 go build \
		-ldflags="-H windowsgui -s -w -X '$(MODULE)/config.AppVersion=$(VERSION)'" \
		-o $(BINARY_WIN) .
	@echo "Built: $(BINARY_WIN)"
	@ls -lh $(BINARY_WIN)

## Build macOS executable (native arch, stripped)
build-darwin: deps
	@mkdir -p dist
	CGO_ENABLED=1 go build \
		-ldflags="-s -w -X '$(MODULE)/config.AppVersion=$(VERSION)'" \
		-o $(BINARY_DARWIN) .
	@echo "Built: $(BINARY_DARWIN)"
	@ls -lh $(BINARY_DARWIN)

## Build Linux executable (amd64, stripped)
build-linux: deps
	@mkdir -p dist
	CGO_ENABLED=1 go build \
		-ldflags="-s -w -X '$(MODULE)/config.AppVersion=$(VERSION)'" \
		-o $(BINARY_LINUX) .
	@echo "Built: $(BINARY_LINUX)"
	@ls -lh $(BINARY_LINUX)

## Build with console visible (for development/debugging)
build-debug: deps generate
	@mkdir -p dist
	GOOS=windows GOARCH=amd64 go build \
		-ldflags="-X '$(MODULE)/config.AppVersion=$(VERSION)-debug'" \
		-o dist/synctabs-companion-debug.exe .
	@echo "Built: dist/synctabs-companion-debug.exe"

## Build NSIS installer (requires makensis on PATH)
installer: build-windows
	@which makensis > /dev/null 2>&1 || (echo "Error: makensis not found. Install NSIS." && exit 1)
	makensis installer.nsi
	@echo "Installer: $(INSTALLER)"

## Convert extension PNGs to ICO format (requires Python + Pillow)
icons:
	python3 -c "\
from PIL import Image, ImageEnhance; \
import os; \
i16=Image.open('../extension/icons/icon16.png').convert('RGBA'); \
i32=Image.open('../extension/icons/icon48.png').convert('RGBA').resize((32,32)); \
i48=Image.open('../extension/icons/icon48.png').convert('RGBA'); \
i16.save('assets/icon_connected.ico',format='ICO',sizes=[(16,16),(32,32),(48,48)],append_images=[i32,i48]); \
g=lambda img: ImageEnhance.Brightness(img.convert('LA').convert('RGBA')).enhance(0.5); \
g(i16).save('assets/icon_disconnected.ico',format='ICO',sizes=[(16,16),(32,32),(48,48)],append_images=[g(i32),g(i48)]); \
print('Icons created')"

## Clean build artifacts
clean:
	rm -rf dist/ resource_windows.syso

## Verify build compiles (cross-compile check from non-Windows)
verify:
	GOOS=windows GOARCH=amd64 go build -o /dev/null . && echo "Build check: OK"
