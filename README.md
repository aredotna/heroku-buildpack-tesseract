# Heroku Buildpack Tesseract

This package provides a custom Heroku buildpack providing the [Tesseract OCR](https://github.com/tesseract-ocr/tesseract) binary,
for Heroku 20 and 22 stack.


This is a buildpack adding a heroku-compatible version of the [tesseract](https://github.com/tesseract-ocr/tesseract)
package. It uses the most recent 5.x version and supports stack 22. Actual all language trainee data are included.

# General build instructions

Ensure Docker is running and then un `make` on the console.
This will generate some tarballs you can check in.