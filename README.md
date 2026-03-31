# rm-scripts
Personal scripts for my remarkable

## Install

```sh
cd .vellum/local-repo/armv7
curl -LO https://github.com/luishfonseca/rm-scripts/releases/latest/download/lhf-1.0.0-r0.apk
vellum index --allow-untrusted -o APKINDEX.tar.gz *.apk
vellum update --allow-untrusted
vellum install --allow-untrusted lhf
```
