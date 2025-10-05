#!/bin/sh
# ===== Teams Bot Launcher Build Script =====

# Move to project root
cd "$(dirname "$0")/.." || exit 1

# Load variables from .env if it exists
if [ -f .env ]; then
  set -a
  . ./.env
  set +a
fi

if [ -z "$SHARE_LINK" ]; then
  echo "SHARE_LINK is not set! Check your .env file in the project root."
  exit 1
fi

# Output file name will be <BOT_NAME>-Launcher or <BOT_NAME>-Launcher-<BOT_VERSION>
if [ -n "$BOT_VERSION" ]; then
  OUTPUT="${BOT_NAME}-${BOT_VERSION}-Launcher"
else
  OUTPUT="${BOT_NAME}-Launcher"
fi

# Add .exe extension for Windows
if [ "$GOOS" = "windows" ]; then
  OUTPUT="${OUTPUT}.exe"
fi

echo "Building $OUTPUT for $GOOS/$GOARCH..."
echo "..."
if go build -o "$OUTPUT" \
  -ldflags "-s -w \
    -X teams-bot-launcher/config.ShareLink=${SHARE_LINK}"; then
  echo "Build succeeded!"
else
  echo "Build failed!"
  exit 1
fi