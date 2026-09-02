# spacedock marketplace

The Spacedock plugin marketplace: two marketplaces, one per channel, each serving
the [spacedock](https://github.com/spacedock-dev/spacedock) plugin. The channel
lives in the **marketplace name**; the entry name stays `spacedock` on both
channels (it must equal the plugin's own `plugin.json` name).

- **`spacedock`** (stable) — this branch's root `marketplace.json`. Its `spacedock`
  entry tracks the product repo's `stable` branch (`source.ref: stable`), which the
  release workflow advances on every release, so the entry needs no repointing.
- **`spacedock-edge`** (edge) — a separate marketplace on this repo's
  [`edge` branch](https://github.com/spacedock-dev/marketplace/tree/edge). Its single
  `spacedock` entry tracks the product repo's `main` HEAD (`source.ref: main`).

The `spacedock` binary selects the channel by its `devBranch` stamp: a stable
binary installs `spacedock@spacedock`, an edge binary installs
`spacedock@spacedock-edge`. Install manually:

```
# Stable
claude plugin marketplace add spacedock-dev/marketplace
claude plugin install spacedock@spacedock

# Edge — the @edge ref is what registers the spacedock-edge marketplace
claude plugin marketplace add spacedock-dev/marketplace@edge
claude plugin install spacedock@spacedock-edge
```

Codex installs the same way with `codex plugin marketplace add` and
`codex plugin add`.

**The plugin ships skills and hooks only — no binary.** The `spacedock` CLI is a
separate install: `brew tap spacedock-dev/homebrew-tap && brew install spacedock`
on macOS, or the checksum-verified
[install script](https://github.com/spacedock-dev/spacedock/blob/main/install.sh)
on macOS/Linux. See the
[spacedock repo](https://github.com/spacedock-dev/spacedock) for details.

Also listed in the stable marketplace:

- **`subspace`** — [subspace](https://github.com/spacedock-dev/subspace), pinned
  to a release tag.
- **`cargento`** — [cargento](https://github.com/spacedock-dev/cargento), an agent
  cartography dashboard. Tracks that repo's `stable` branch, which its release workflow
  advances on every release, so the listing does not need repointing per release. The
  plugin lives in a `cargento/` subdirectory rather than at the repo root, so the entry
  uses a `git-subdir` source with `"path": "cargento"`.
- **`behavior-diff`** — [Behavior Diff](https://github.com/spacedock-dev/behavior-diff)
  compares agent behavior before and after an instruction-file change. The plugin
  lives in the repo's `plugin/` subdirectory, so the entry uses a `git-subdir`
  source with `"path": "plugin"`. It tracks `main` until the repo publishes a
  release tag or stable branch.

```
claude plugin install cargento@spacedock
claude plugin install behavior-diff@spacedock
codex plugin add behavior-diff@spacedock
```
