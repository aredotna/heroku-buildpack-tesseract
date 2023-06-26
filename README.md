# Heroku Buildpack Tesseract

This package provides a custom Heroku buildpack providing the [Tesseract OCR](https://github.com/tesseract-ocr/tesseract) binary and all the required libraries to Heroku apps. Training data for English language is provided.

## Configuration


1. add teh buildpack
    ```
    heroku buildpacks:add https://github.com/teketekepon/heroku-buildpack-tesseract
    ```
    or add by copy the URL in the Dashboard to add the buildpack.
2. you can use the `tesseract` binary in your Heroku app!
3. deploy :)

## Note
This fork uses the Tesseract version 5.3.1

## License
MIT License.

Original work Copyright (c) 2013 Marco Azimonti
Modified work Copyright (c) 2015 Matteo Maggioni
Modified work Copyright (c) 2015 Oswell Chan
Modified work Copyright (c) 2018 Malcolm Patterson
Modified work Copyright (c) 2020 Takahiro Furukawa
