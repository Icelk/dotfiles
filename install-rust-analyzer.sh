#!/bin/sh

url=$(curl \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/rust-analyzer/rust-analyzer/releases/latest | \
    grep -o "https://.*x86_64-unknown-linux-gnu.gz")
curl -L $url -o rust-analyzer.gz

gzip -d rust-analyzer.gz

chmod +x rust-analyzer

mv -i rust-analyzer ~/.local/bin

if test -f "rust-analyzer"; then
    rm rust-analyzer
fi
