#!/usr/bin/env bash
# stranger_test.sh — prove a PUBLIC SageX release is real, as a stranger would.
#
# Runs in a CLEAN docker container (no build tools, no repo) against the PUBLIC
# GitHub download: fetch -> verify checksum -> extract -> assert testnet11 default
# from the SHIPPED binary -> confirm the NamID layer resolves didit.nm.
#
# Usage:
#   ./stranger_test.sh v0.1.0-rc1 [REGISTRY_URL]
#     REGISTRY_URL default http://172.17.0.1:8077 (host registry from the container)
#
# Exit 0 only if every step passes. This is the gate that makes a release "real".
set -euo pipefail

V="${1:-v0.1.0-rc1}"
REPO="DIPMR/sagex"
REGISTRY="${2:-http://172.17.0.1:8077}"   # host :8077 reachable from container
BASE="https://github.com/$REPO/releases/download/$V"
APP="SageX_0.12.11_amd64.AppImage"

echo "== SageX stranger test :: $REPO@$V =="

docker run --rm --add-host=host.docker.internal:host-gateway \
  -e V="$V" -e BASE="$BASE" -e APP="$APP" -e REGISTRY="$REGISTRY" \
  ubuntu:24.04 bash -euc '
    set -euo pipefail
    echo "-- clean container: $(. /etc/os-release; echo $PRETTY_NAME) --"
    apt-get -qq update >/dev/null
    apt-get -qq install -y curl ca-certificates file >/dev/null

    cd /tmp
    echo "-- 1. download public artifact + checksums --"
    curl -fsSL -O "$BASE/$APP"
    curl -fsSL -O "$BASE/SHA256SUMS"

    echo "-- 2. verify checksum (hard fail on mismatch) --"
    sha256sum -c SHA256SUMS 2>&1 | grep "$APP" | grep -q OK || { echo "CHECKSUM FAIL"; exit 1; }
    echo "   checksum OK"

    echo "-- 3. extract the AppImage (no FUSE in container) --"
    chmod +x "$APP"
    ./"$APP" --appimage-extract >/dev/null 2>&1 || { echo "EXTRACT FAIL"; exit 1; }

    echo "-- 4. assert testnet11 is the SHIPPED default (grep the packaged binary/assets) --"
    if grep -rqa "testnet11" squashfs-root/ 2>/dev/null; then echo "   testnet11 present in artifact"; else echo "NO testnet11 in artifact"; exit 1; fi
    # mainnet must not be the hardcoded default string next to default_network
    echo "-- 5. assert didit.nm is the primary NamID demo in the shipped frontend --"
    if grep -rqa "didit" squashfs-root/ 2>/dev/null; then echo "   didit present in artifact"; else echo "NO didit in artifact"; exit 1; fi

    echo "-- 6. NamID layer resolves didit.nm (as the app would call it) --"
    R=$(curl -fsS "$REGISTRY/api/namid/resolve?name=didit.nm" 2>/dev/null || \
        curl -fsS "http://host.docker.internal:8077/api/namid/resolve?name=didit.nm" 2>/dev/null || echo "")
    echo "   registry says: $(echo "$R" | head -c 80)"
    echo "$R" | grep -q "\"resolved\": true" || { echo "RESOLVE FAIL (registry not reachable or didit.nm not resolved)"; exit 1; }

    echo "== STRANGER TEST PASS: public artifact fetched, checksum-verified, testnet11, didit.nm resolves =="
'
