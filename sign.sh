#!/bin/sh
# Sign APK packages or APKINDEX without abuild-sign
# BusyBox compatible - requires: openssl, tar, gzip, dd, wc
set -e

PRIVKEY="${1:?Usage: sign.sh <private-key> <file...>}"
KEYNAME="$(basename "$PRIVKEY" .rsa).rsa.pub"
shift

for f in "$@"; do
    FILE="$(readlink -f "$f")"
    DIR="$(dirname "$FILE")"
    SIG=".SIGN.RSA.${KEYNAME}"

    openssl dgst -sha1 -sign "$PRIVKEY" -out "${DIR}/${SIG}" "$FILE"

    cd "$DIR"
    TMPTAR="$(mktemp)"
    SIGTARGZ="$(mktemp)"
    tar cf "$TMPTAR" "$SIG"
    CUTSIZE=$(($(wc -c < "$TMPTAR") - 1024))
    dd if="$TMPTAR" bs="$CUTSIZE" count=1 2>/dev/null | gzip -9 > "$SIGTARGZ"

    TMPSIGNED="$(mktemp)"
    cat "$SIGTARGZ" "$FILE" > "$TMPSIGNED"
    chmod 644 "$TMPSIGNED"
    mv "$TMPSIGNED" "$FILE"

    rm -f "$TMPTAR" "$SIGTARGZ" "$SIG"
    echo "Signed $f"
done
