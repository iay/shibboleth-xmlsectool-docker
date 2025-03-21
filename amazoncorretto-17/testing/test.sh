#!/usr/bin/sh

set -e

./make-keys.sh
./setup-softhsm.sh

SOFTHSM2_CONF=softhsm/softhsm2.conf \
    xmlsectool.sh --sign --inFile uk000006.xml --outFile uk000006-out.xml \
    --pkcs11Config pkcs11-softhsm.cfg --keyAlias key10 --keyPassword 12341234

xmlsectool.sh --verifySignature \
     --inFile uk000006-out.xml \
     --certificate secrets/self-signed.pem
