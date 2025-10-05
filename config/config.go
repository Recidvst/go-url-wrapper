package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

// Config - holds required custom values
// this was planned to contain name etc. but those values currently not needed within the app itself
type Config struct {
	Url string
}

var (
	ShareLink string
)

// GetEnvironmentVariables - read .env file and ldflag values, and return environment variables as a struct
func GetEnvironmentVariables() Config {
	_ = godotenv.Load(".env") // .env is optional as won't be present when distributed

	var cfg = Config{}

	// prefer ldflag values over .env file values (used when distributed as a binary)
	cfg.Url = os.Getenv("SHARE_LINK")
	if ShareLink != "" {
		cfg.Url = ShareLink
	}

	if cfg.Url == "" { // name and url are required
		log.Fatal("One or more environment variables are not set. Please set SHARE_LINK")
	}

	return cfg
}
