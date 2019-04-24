#!/bin/bash -x
SHARE_DIR="/tmp/dockershare"
SHARE_SCRIPT="${SHARE_DIR}/build.lzo.sh"
LZO_PKG="lzo-2.10"

mkdir -p ${SHARE_DIR}

cat > ${SHARE_SCRIPT} << __END
#!/bin/bash
cd /
apt update
apt install -y \
   binutils-mingw-w64 \
   binutils-mingw-w64-x86-64 \
   gcc-mingw-w64-base \
   g++-mingw-w64 \
   g++-mingw-w64-x86-64 \
   gcc-mingw-w64-x86-64 \
   mingw-w64 \
   mingw-w64-common \
   build-essential \
   wget \
   zip

wget http://www.oberhumer.com/opensource/lzo/download/${LZO_PKG}.tar.gz
tar xvf *.tar.gz

cd ${LZO_PKG}

./configure \
    --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
    --prefix='' \
    --without-pkgconfigdir \
    --enable-shared
make
make install DESTDIR=/out

cd /out
zip /share/${LZO_PKG}.x86_64-w64-mingw32.zip . -r -9

chmod 666 /share/*.zip
__END

docker run -v /tmp/dockershare:/share -i -t ubuntu bash -c "bash /share/build.lzo.sh"

echo "The library is available here: " $(ls ${SHARE_DIR}/*.zip)


