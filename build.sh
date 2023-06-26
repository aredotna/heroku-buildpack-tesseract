#!/bin/bash

set -euo pipefail
set -x

VERSION=5.3.1
STACK=heroku-22


echo " - - - -> Install dependencies"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y \
  autoconf automake autotools-dev libtool g++ pkg-config cmake \
  libcurl4-openssl-dev libleptonica-dev libpng-dev libtiff-dev \
  libgif-dev libicu-dev libpango1.0-dev
apt-get clean
rm -rf /var/lib/apt/lists/*


echo " - - - -> Create and go into build dir"
mkdir -p /build
cd /build || exit 1


echo " - - - -> Fetching and Unpacking Tesseract sources"
curl --fail -sq -LOJ "https://github.com/tesseract-ocr/tesseract/archive/refs/tags/${VERSION}.tar.gz"
tar --strip-components=1 -zxvf "tesseract-${VERSION}.tar.gz"


echo " - - - -> Build and install Tesseract from sources"
mkdir build
cd build || exit 1
# -DBUILD_SHARED_LIBS=OFF
CFLAGS="-mtune=generic" CXXFLAGS="-mtune=generic" cmake -DGRAPHICS_DISABLED=ON -DBUILD_TRAINING_TOOLS=OFF -DMARCH_NATIVE_OPT=OFF ..
make

mkdir -p /src/tesseract-${VERSION}-${STACK}/bin
mv bin/tesseract /src/tesseract-${VERSION}-${STACK}/bin/

mkdir -p /src/tesseract-${VERSION}-${STACK}/lib
cp -P /lib/x86_64-linux-gnu/liblept*so* /src/tesseract-${VERSION}-${STACK}/lib/
cp -P /lib/x86_64-linux-gnu/libgif*so* /src/tesseract-${VERSION}-${STACK}/lib/


echo " - - - -> Install Tesseract train data"
mkdir -p /src/tesseract-${VERSION}-${STACK}/share
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/chi_sim.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/chi_sim.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/deu.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/deu.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/ell.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/ell.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/eng.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/equ.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/equ.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/fra.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/fra.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/ita.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/ita.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/jpn.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/jpn.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/lat.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/lat.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/osd.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/osd.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/rus.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/rus.traineddata"
curl --fail -sq -Lo "/src/tesseract-${VERSION}-${STACK}/share/spa.traineddata" "https://github.com/tesseract-ocr/tessdata/raw/main/spa.traineddata"

cd /src
umask 000
tar -czpf tesseract-${VERSION}-${STACK}.tar.gz tesseract-${VERSION}-${STACK}
# rm -rf tesseract-${VERSION}-${STACK}


# Failures:
# tesseract: error while loading shared libraries: libarchive.so.13
# Error opening data file /app/vendor/tesseract/share/eng.traineddata