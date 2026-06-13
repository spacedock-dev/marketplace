# spacedock marketplace

The Spacedock plugin marketplace. Holds the one `marketplace.json` that serves two
channels of the [spacedock](https://github.com/spacedock-dev/spacedock) plugin:

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
