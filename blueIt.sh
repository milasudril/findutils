#!/bin/bash

# pre-configure
cat > config.cache << "EOF"
gl_cv_func_wcwidth_works=yes
gl_cv_header_working_fcntl_h=yes
ac_cv_func_fnmatch_gnu=yes
EOF

# configure
CFLAGS="--sysroot=${BLUEOS_SYSTEM}" ./configure --prefix=/usr --cache-file=config.cache --build=${BLUEOS_HOST} --host=${BLUEOS_TARGET} --libexecdir=/usr/lib/findutils --localstatedir=/var/lib/locate

# build
make

# install
make DESTDIR=${BLUEOS_SYSTEM} install
mv -v ${BLUEOS_SYSTEM}/usr/bin/find ${BLUEOS_SYSTEM}/bin
cp ${BLUEOS_SYSTEM}/usr/bin/updatedb{,.orig}
sed 's@find:=${BINDIR}@find:=/bin@' ${BLUEOS_SYSTEM}/usr/bin/updatedb.orig > ${BLUEOS_SYSTEM}/usr/bin/updatedb
rm ${BLUEOS_SYSTEM}/usr/bin/updatedb.orig