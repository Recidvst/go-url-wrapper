# Go URL launcher

A simple Go application to launch a URL using the user's default browser.

It's basically just a wrapper around the share link to allow launching from a distributable binary. It opens the
provided link in the user's default browser and shuts down.

## Requirements

- Go 1.16+ (recommended: latest stable)

## Configuration

Create an `.env` file in the root directory and set the required values - refer to the `.env.example` file.

## Usage

### Build and run the application locally

   ```sh
   # Build
   go build main.go
   # Run
   go run main.go
   ```

### Build and run the application as a binary

_**Important:** this has only been tested on Windows 10 so far!_

We have provided a build script to build the application for the target OS with the correct flags and environment
variables.

   ```sh
   ./build.sh
   ```

If you want, you can run the commands manually but make sure to include the correct environment variables via lflag.

   ```sh
   # For Windows
   GOOS=windows GOARCH=amd64 go build -o <BOTNAME>-launcher.exe -ldflags "-s -w -X teams-bot-launcher/config.ShareLink=<SHARE_LINK>" // for 64-bit, use GOARCH=386 for 32-bit
   ```

Once built, double-click the generated file or run it from a terminal with `./<BOTNAME>-launcher.exe`


