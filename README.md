# rm-scripts
Personal scripts for my remarkable

## Install

```sh
cd .vellum/local-repo/armv7
curl -LO https://github.com/luishfonseca/rm-scripts/releases/latest/download/lhf-1.0.0-r0.apk
vellum --allow-untrusted index -o APKINDEX.tar.gz *.apk
curl -sL https://raw.githubusercontent.com/luishfonseca/rm-scripts/main/sign.sh | sh -s ~/.vellum/etc/apk/keys/local.rsa APKINDEX.tar.gz
vellum update
vellum install lhf
```
