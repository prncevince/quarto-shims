QUARTO_VERSION=$(/bin/cat .quarto-version)
wget \
  -P ./quarto-cli \
  https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-macos.tar.gz
mkdir -p ./quarto-cli/quarto-${QUARTO_VERSION}-macos
tar -xf ./quarto-cli/quarto-${QUARTO_VERSION}-macos.tar.gz -C ./quarto-cli/quarto-${QUARTO_VERSION}-macos
rm ./quarto-cli/quarto-${QUARTO_VERSION}-macos.tar.gz

