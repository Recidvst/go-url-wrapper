#!/bin/sh
# ===== Go URL Wrapper build script =====

# Move to project root
cd "$(dirname "$0")/.." || exit 1

# Load variables from .env if it exists
if [ -f .env ]; then
  set -a
  . ./.env
  set +a
fi

if [ -z "$URL" ]; then
  echo "URL is not set! Check your .env file in the project root."
  exit 1
fi

# Output file name will be <BINARY_NAME>-Launcher or <BINARY_NAME>-Launcher-<BINARY_VERSION>
if [ -n "$BINARY_VERSION" ]; then
  OUTPUT="${BINARY_NAME}-${BINARY_VERSION}-Launcher"
else
  OUTPUT="${BINARY_NAME}-Launcher"
fi

# Add .exe extension for Windows
if [ "$GOOS" = "windows" ]; then
  OUTPUT="${OUTPUT}.exe"
fi

echo "Building $OUTPUT for $GOOS/$GOARCH..."
echo "..."
if go build -o "$OUTPUT" \
  -ldflags "-s -w \
    -X go-url-wrapper/config.URL=${URL}"; then
  echo "Build succeeded!"
else
  echo "Build failed!"
  exit 1
fi
