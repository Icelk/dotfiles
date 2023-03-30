# Generate self-signed certificate with OpenSSL

```
$ openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout pk.pem -out cert.pem

```
