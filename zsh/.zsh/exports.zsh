# Enable native TLS for UV (for downloading cpython, packages etc)
export UV_SYSTEM_CERTS=1

# Custom CA certificates for SSL/TLS
export SSL_CERT_FILE="$HOME/.ca-certs/ca-bundle.crt"
export REQUESTS_CA_BUNDLE="$HOME/.ca-certs/cacert_mio.pem"
export NODE_EXTRA_CA_CERTS="$HOME/.ca-certs/cacert_mio.pem"
