#!/bin/bash -x
SHARE_DIR="/tmp/dockershare"
SHARE_SCRIPT_NAME="build.xz.sh"
SHARE_SCRIPT="${SHARE_DIR}/${SHARE_SCRIPT_NAME}"
XZ_PKG="xz-5.2.4"

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

wget https://tukaani.org/xz/${XZ_PKG}.tar.gz
tar xvf *.tar.gz

cd ${XZ_PKG}

./configure \
    --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
    --prefix='' \
    --without-pkgconfigdir \
    --enable-shared
make
make install DESTDIR=/out

cd /out
zip /share/${XZ_PKG}.x86_64-w64-mingw32.zip . -r -9

chmod 666 /share/*.zip
__END

docker run -v /tmp/dockershare:/share -i -t ubuntu bash -c "bash /share/${SHARE_SCRIPT_NAME}"

echo "The library is available here: " $(ls ${SHARE_DIR}/*.zip)


