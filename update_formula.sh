#!/bin/bash
set -e

VERSION="0.1.0"
REPO="0xlxx/paperfetcher"
FORMULA_PATH="Formula/paperfetcher.rb"

echo "Waiting for release assets to be uploaded..."
while true; do
  ASSETS=$(env -u GITHUB_TOKEN gh release view v${VERSION} --repo ${REPO} --json assets --jq '.assets[].name' 2>/dev/null || true)
  if echo "$ASSETS" | grep -q "paperfetcher-v${VERSION}-aarch64-apple-darwin.tar.gz" && \
     echo "$ASSETS" | grep -q "paperfetcher-v${VERSION}-x86_64-apple-darwin.tar.gz" && \
     echo "$ASSETS" | grep -q "paperfetcher-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz"; then
    echo "All assets are successfully uploaded!"
    break
  fi
  echo "Still waiting..."
  sleep 10
done

echo "Downloading assets to calculate SHA256..."
mkdir -p /tmp/paperfetcher_release

curl -sL -o /tmp/paperfetcher_release/arm.tar.gz "https://github.com/${REPO}/releases/download/v${VERSION}/paperfetcher-v${VERSION}-aarch64-apple-darwin.tar.gz"
curl -sL -o /tmp/paperfetcher_release/intel.tar.gz "https://github.com/${REPO}/releases/download/v${VERSION}/paperfetcher-v${VERSION}-x86_64-apple-darwin.tar.gz"
curl -sL -o /tmp/paperfetcher_release/linux.tar.gz "https://github.com/${REPO}/releases/download/v${VERSION}/paperfetcher-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz"

ARM_SHA=$(shasum -a 256 /tmp/paperfetcher_release/arm.tar.gz | awk '{print $1}')
INTEL_SHA=$(shasum -a 256 /tmp/paperfetcher_release/intel.tar.gz | awk '{print $1}')
LINUX_SHA=$(shasum -a 256 /tmp/paperfetcher_release/linux.tar.gz | awk '{print $1}')

echo "ARM_SHA256: $ARM_SHA"
echo "INTEL_SHA256: $INTEL_SHA"
echo "LINUX_SHA256: $LINUX_SHA"

# Replace placeholders in Formula
sed -i '' "s/ARM_MAC_SHA256/$ARM_SHA/g" "$FORMULA_PATH"
sed -i '' "s/INTEL_MAC_SHA256/$INTEL_SHA/g" "$FORMULA_PATH"
sed -i '' "s/LINUX_X64_SHA256/$LINUX_SHA/g" "$FORMULA_PATH"

echo "Formula updated successfully!"

# Cleanup
rm -rf /tmp/paperfetcher_release
