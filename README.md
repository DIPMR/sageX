# SageX — research preview (v0.1.0-rc1)

SageX is a **research-preview fork of [Sage Wallet](https://github.com/rigidnetwork/sage)**
(Apache-2.0) that surfaces **NalandaX** soulbound NamIDs and labels soulbound NFTs.
Part of [web3utxos.com](https://web3utxos.com). See [`MODIFICATIONS.md`](./MODIFICATIONS.md)
for exactly what differs from upstream.

> **Research preview — use on testnet11.** Binaries are **unsigned**; your OS will show an
> "unidentified developer / unknown publisher" warning. This is expected for an RC.

## Platforms in this stage

Only the artifacts this build host can **honestly** produce are staged here (Linux x64 + web).
All other platforms build in CI — see [`PLATFORM_TRUTH_TABLE.md`](./PLATFORM_TRUTH_TABLE.md).

| Platform | Artifact | Where |
|----------|----------|-------|
| Linux x64 | `SageX_0.12.11_amd64.AppImage`, `SageX_0.12.11_amd64.deb`, `SageX-0.12.11-1.x86_64.rpm` | this stage |
| Web (watch-only) | `web-bundle/` static site | this stage |
| Linux ARM · Windows x64/ARM | deb/rpm/appimage · msi/nsis | CI (`build.yml`, on tag) |
| macOS · iOS · Android | dmg · ipa · apk/aab | CI / blocked — see truth table |

## Quickstart — Linux x64

1. **Download** the artifact for your packaging + `SHA256SUMS`.
2. **Verify the checksum** (never skip this):
   ```bash
   sha256sum -c SHA256SUMS 2>&1 | grep SageX
   ```
3. **Install / run:**
   - **AppImage:** `chmod +x SageX_0.12.11_amd64.AppImage && ./SageX_0.12.11_amd64.AppImage`
   - **deb:** `sudo apt install ./SageX_0.12.11_amd64.deb`
   - **rpm:** `sudo dnf install ./SageX-0.12.11-1.x86_64.rpm`
4. **Expect the unsigned-binary warning** — this RC is not code-signed.
5. **Launch** — SageX boots on **testnet11** by default (see note below).
6. Open the **NamIDs** tab and resolve `didit.nm` (read-only, the primary demo) to confirm the
   NalandaX layer; `soultest.nm` is shown as a secondary example.

> **Network note:** SageX ships with **testnet11** pinned as the default network (upstream Sage
> defaults to mainnet). This is a testnet-only research preview; change networks in
> Settings → Network if you need to.

## Farming
SageX is built on **Sage = a light wallet**, so **farming/plotting is not a SageX capability**
by design. Farming lives in **ChiaX →** (the full-node app). SageX will show a pointer, not a
farming tab.

## Integrity
Every artifact is covered by `SHA256SUMS` in its directory. `LICENSE` (Apache-2.0) and
`MODIFICATIONS.md` travel with the release. Gate script: `gates/verify_artifacts.sh`.

**Not yet published.** Public distribution and the final `v0.1.0` tag are Mayank-gated.
