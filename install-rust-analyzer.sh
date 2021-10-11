#!/bin/sh

url=$(curl \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/rust-analyzer/rust-analyzer/releases/latest | \
    grep -o "https://.*x86_64-unknown-linux-gnu.gz")
curl -L $url -o rust-analyzer.gz

gzip -d rust-analyzer.gz

chmod +x rust-analyzer

mkdir -p ~/.local/bin/coc-rust-analyzer-data

mv ~/.config/coc/extensions/coc-rust-analyzer-data/* ~/.local/bin/coc-rust-analyzer-data/

rm -rf ~/.config/coc/extensions/coc-rust-analyzer-data

ln -sf ~/.local/bin/coc-rust-analyzer-data ~/.config/coc/extensions/coc-rust-analyzer-data

ln -sf ~/.local/bin/coc-rust-analyzer-data/rust-analyzer ~/.local/bin/

mv -i rust-analyzer ~/.local/bin

if test -f "rust-analyzer"; then
    rm rust-analyzer
fi
