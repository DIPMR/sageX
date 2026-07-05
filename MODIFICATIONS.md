# SageX — Modifications relative to upstream Sage

SageX is a **fork of [Sage Wallet](https://github.com/rigidnetwork/sage)** (Rigid Network),
licensed **Apache-2.0**. The upstream `LICENSE` is preserved verbatim in this release.
This file records every substantive change the fork makes, as required for downstream
redistribution under Apache-2.0 §4(b).

Upstream base: Sage `v0.12.11` (crate/product version carried forward unchanged).

## Summary of changes

| Area | Change | Files |
|------|--------|-------|
| New crate | **`sage-nalandax`** — a read-only coin *recognizer* that classifies NalandaX identity coins (NamID singletons, soulbound NFTs) that stock Sage drops as `Unknown` or shows without a soulbound label. 1:1 port of a verified Python reference. | `crates/sage-nalandax/` |
| Wallet wiring | `ChildKind` gains `NamId` and `SoulboundNft` classification arms so custom `nx_namid` singletons and reject-transfer NFTs are indexed and labelled instead of dropped. | `crates/sage-wallet/src/child_kind.rs`, `crates/sage-wallet/Cargo.toml` |
| Network default | **Boot default network pinned to `testnet11`** (was upstream `mainnet`) — SageX is a testnet-only research preview. | `crates/sage-config/src/config.rs` |
| Frontend | A **NamIDs** tab and soulbound labelling in the NFT views. | `src/` (React/TS) |
| Branding | `productName` → **SageX** (bundle identifier `com.rigidnetwork.sage` retained for config-dir compatibility). | `src-tauri/tauri.conf.json` |
| Local plugin | `tauri-plugin-sage` bundled in-tree (`file:tauri-plugin-sage`). | `tauri-plugin-sage/` |
| Ops (not shipped in binaries) | Systemd units, desktop launchers, a spend/air-gap **guard** (`sagex_guard.py`) and a read-only **cloud proxy** (`sagex_cloud_proxy.py`) for the operator's self-hosted deployment. | `deploy/`, `run_sagex.sh`, `sagex_guard.py`, `sagex_cloud_proxy.py` |

## What is NOT changed
- Wallet driver code, consensus, and key handling are **upstream Sage**. (The boot **default network**
  is the one exception — pinned to `testnet11`; see the table above.)
- The NalandaX layer is **recognition/display only** — it does not sign, spend, or alter
  transaction construction.

## Known deltas from upstream release behaviour
- **Default network is `testnet11`** (upstream ships `mainnet`). SageX is a testnet-only
  research preview, so it boots testnet11 out of the box. Switch to another network in
  Settings → Network if needed.
- Binaries are **unsigned** (no code-signing certificate). Expect the standard OS
  "unidentified developer / unknown publisher" warning on macOS and Windows.

## Provenance
Upstream `LICENSE` (Apache-2.0) and this `MODIFICATIONS.md` travel with every SageX
artifact. No upstream `NOTICE` file exists in the base repo; none is added.
