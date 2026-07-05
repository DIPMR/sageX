# SageX v0.1.0-rc2 — Platform Truth Table (G1)

Build host: **Ubuntu 24.04.4 LTS, x86_64** (`mayank-Inspiron-15-3567`).
Toolchain present: rustc/cargo 1.96.0 · cargo-tauri 2.52.3 · node 22.22.2 · pnpm 10.13.1 ·
webkit2gtk-4.1 ✅. Rust targets installed: `x86_64-unknown-linux-gnu`, `wasm32-unknown-unknown` only.
No Apple hardware. No Windows host. No Android SDK/NDK/JDK. No signing certs.

Upstream Sage ships **7** build variants (from `.github/workflows/build.yml`), mirrored below.
**Rule honoured: no artifact is fabricated for a target this machine cannot honestly produce.**

| Target | Formats | This machine | Why |
|--------|---------|--------------|-----|
| **Linux x64** | AppImage · deb · rpm | **NATIVE-NOW** | Native host + webkit2gtk-4.1 present. This is the real artifact set this RC produces. |
| **Web bundle** | static `dist/` | **NATIVE-NOW** | `pnpm run build` (vite) produces `dist/`; watch-only surface, re-gated to D4. |
| **Android** | apk · aab | **CROSS-ATTEMPT → BLOCKED (in-session)** | Linux *can* build Android, but needs JDK + Android SDK + NDK r26d (~several GB) — none installed here. Scripted install path documented; CI Android job already exists. No JDK on host. |
| **Linux ARM64** | AppImage · deb · rpm | **CI-ONLY** | aarch64 cross needs a sysroot + cross-linker; upstream builds it on a native `linux-arm64` runner. Not honestly producible from x64 here. |
| **Windows x64** | msi · nsis · zip | **CI-ONLY** | Tauri MSI/NSIS bundling requires a Windows host (WiX/NSIS); no supported cross-bundle from Linux. |
| **Windows ARM64** | msi · nsis | **CI-ONLY** | Same as above + `aarch64-pc-windows-msvc`. |
| **macOS (universal)** | dmg · app | **BLOCKED** | Apple hardware + macOS SDK required. `NEEDS-MAYANK: Apple hardware`. |
| **iOS** | ipa | **BLOCKED** | Apple hardware + Apple Developer account + signing certs (team `NQJQRYZZG3`). `NEEDS-MAYANK: Apple Dev account + certs`. |

## What that means for this RC
- **Honestly produced here:** Linux x64 (AppImage/deb/rpm) + web bundle.
- **Honestly produced only in CI:** Linux ARM, Windows x64/ARM (GitHub-hosted runners already
  wired in `build.yml`). CI is the cross-platform path — not this laptop.
- **Blocked pending Mayank:** macOS + iOS (hardware/account/certs), Android (in-session; CI job exists).

The CI matrix in `.github/workflows/build.yml` already covers all 7 upstream targets and gates
GitHub Releases on `v*` tags — it is the sanctioned way the non-native targets get built.
