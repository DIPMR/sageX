# SageX — install on a second machine (from the public release)

Copy-paste install for a fresh machine, straight from the public repo
**https://github.com/DIPMR/sagex** releases. Research preview — **testnet11**,
binaries **unsigned** (expect an "unknown publisher" warning).

> These commands target release **v0.1.0-rc1**. Bump the `V=` tag when a newer
> release is published. Always verify the checksum before running.

## Linux x64

```bash
V=v0.1.0-rc1
BASE="https://github.com/DIPMR/sagex/releases/download/$V"

# 1. download an artifact + the checksums
cd ~/Downloads
curl -L -O "$BASE/SageX_0.12.11_amd64.AppImage"
curl -L -O "$BASE/SHA256SUMS"

# 2. verify (must print "OK"); refuse to run if it doesn't
sha256sum -c SHA256SUMS 2>&1 | grep AppImage

# 3. run
chmod +x SageX_0.12.11_amd64.AppImage
./SageX_0.12.11_amd64.AppImage        # add --no-sandbox only if your box needs it

# deb/rpm alternatives:
#   sudo apt install ./SageX_0.12.11_amd64.deb
#   sudo dnf install ./SageX-0.12.11-1.x86_64.rpm
```

## Windows x64 (from the CI artifact on the release)

PowerShell:

```powershell
$V   = "v0.1.0-rc1"
$Base = "https://github.com/DIPMR/sagex/releases/download/$V"
cd $env:USERPROFILE\Downloads

# 1. download installer + checksums
Invoke-WebRequest "$Base/SageX_0.12.11_x64-setup.exe" -OutFile SageX-setup.exe
Invoke-WebRequest "$Base/SHA256SUMS" -OutFile SHA256SUMS.txt

# 2. verify the hash matches the line in SHA256SUMS.txt
Get-FileHash .\SageX-setup.exe -Algorithm SHA256 | Format-List

# 3. install (SmartScreen will warn "unknown publisher" — expected for an RC:
#    More info -> Run anyway)
.\SageX-setup.exe
```

> The exact Windows asset name (`*-setup.exe` / `*.msi` / `*.zip`) is whatever
> the CI matrix (`.github/workflows/build.yml`) attaches to the release. Match
> the name in the release's asset list.

## First run (both platforms)
- SageX boots on **testnet11** by default.
- Open **NamIDs** → resolve **didit.nm** (read-only) to confirm the NalandaX layer.
- It's a watch-only research preview — import a **public key** to view; no secrets required.
