OpenSSL 1.0.2d
--------------

Date: 2015-07-09

Flavour: Static

Built from source

OpenSSL FIPS 2.0.10


--- Tests ---

...
...
...
ALL OCSP TESTS SUCCESSFUL
Test X509v3_check_*
../util/shlib_wrap.sh ./v3nametest
../util/shlib_wrap.sh ./heartbeat_test
Test constant time utilites
../util/shlib_wrap.sh ./constant_time_test
Testing constant time operations...
ok (ran 1908 tests)
test_verify_extra
../util/shlib_wrap.sh ./verify_extra_test
PASS
make[1]: Leaving directory `/src/openssl-1.0.2d/test'
OPENSSL_CONF=apps/openssl.cnf util/opensslwrap.sh version -a
OpenSSL 1.0.2d-fips 9 Jul 2015
built on: reproducible build, date unspecified
platform: mingw
options:  bn(64,32) rc4(8x,mmx) des(ptr,risc1,16,long) idea(int) blowfish(idx)
compiler: /mingw/bin/gcc.exe -I. -I.. -I../include  -DZLIB -DOPENSSL_THREADS -D_
MT -DDSO_WIN32 -DOPENSSL_SSL_CLIENT_ENGINE_AUTO=capi -DOPENSSL_CAPIENG_DIALOG -D
L_ENDIAN -DWINVER=0x0501 -D_WIN32_WINNT=0x0501 -D_WIN32_IE=0x0501 -DPTW32_STATIC
_LIB -fomit-frame-pointer -O0 -pipe -mms-bitfields -fno-builtin -march=i686 -mtu
ne=i686 -Wall -DOPENSSL_BN_ASM_PART_WORDS -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_M
ONT -DOPENSSL_BN_ASM_GF2m -I/mingw/include -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM
-DMD5_ASM -DRMD160_ASM -DAES_ASM -DVPAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM
OPENSSLDIR: "C:/OpenSSL"