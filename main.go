package main

import (
	"fmt"
	"log"
	"os/exec"
	"runtime"
	"go-url-wrapper/config"
)

func openURL(url string) error {
	var cmd *exec.Cmd

	switch runtime.GOOS {
	case "windows":
		cmd = exec.Command("rundll32", "url.dll,FileProtocolHandler", url) // windows
	case "darwin":
		cmd = exec.Command("open", url) // mac
	default: // linux, *bsd
		cmd = exec.Command("xdg-open", url) // linux/bsd
	}

	fmt.Printf("Attempting to open link in the default browser - %s\n", url)
	return cmd.Start()
}

func main() {
	cfg := config.GetEnvironmentVariables()

	err := openURL(cfg.Url)
	if err != nil {
		fmt.Println("Failed to open the link. Please check a default browser is set, or copy the link manually")
		log.Fatal(err)
	}
	fmt.Println("Successfully opened the link")
}
