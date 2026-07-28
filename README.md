# spacedock marketplace

The Spacedock plugin marketplace. Holds the one `marketplace.json` that serves every
Spacedock-family plugin.

Two channels of the [spacedock](https://github.com/spacedock-dev/spacedock) plugin:

- **`spacedock`** (stable) — pinned to a release tag (`source.ref: v0.X.Y`). Frozen
  bytes; advances only when a new release tag is cut and this entry is repointed.
- **`spacedock-edge`** (edge) — tracks the `next` branch HEAD (`source.ref: next`).

The `spacedock` binary selects the channel by its `devBranch` stamp: a stable
binary installs `spacedock@spacedock`, an edge binary installs
`spacedock-edge@spacedock`. Install:

```
claude plugin marketplace add spacedock-dev/marketplace
claude plugin install spacedock@spacedock        # stable
claude plugin install spacedock-edge@spacedock   # edge
```

Both entries are one `{"source":"url","url":…,"ref":…}` source resolving to the
spacedock plugin repo at distinct refs.

Also listed:

- **`subspace`** — [subspace-beta](https://github.com/spacedock-dev/subspace-beta), pinned
  to a beta tag.
- **`cargento`** — [cargento](https://github.com/spacedock-dev/cargento), an agent
  cartography dashboard. Tracks that repo's `stable` branch, which its release workflow
  advances on every release, so the listing does not need repointing per release. The
  plugin lives in a `cargento/` subdirectory rather than at the repo root, so the entry
  uses a `git-subdir` source with `"path": "cargento"`.

```
claude plugin install cargento@spacedock
```
