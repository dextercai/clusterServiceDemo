package main

import (
	"bytes"
	"github.com/gofiber/fiber/v2"
	"os"
)

func main() {
	app := fiber.New()

	app.Get("/*", func(c *fiber.Ctx) error {
		var infoBuffer bytes.Buffer

		infoBuffer.WriteString("CurrentPath: /" + c.Params("*") + "\r\n\r\n")
		for _, v := range os.Environ() {
			infoBuffer.WriteString(v + "\r\n")
		}

		infoBuffer.WriteString("\r\n")
		infoBuffer.WriteString(c.Request().String() + "\r\n")
		infoBuffer.WriteString("\r\n")

		return c.SendString(infoBuffer.String())
	})

	app.Listen(":3000")
}
