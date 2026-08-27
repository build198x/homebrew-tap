# build198x Homebrew tap

Homebrew formulae for [build198x](https://github.com/build198x/build198x), which converts assets, packs data and masters retro media.

```sh
brew install build198x/homebrew-tap/build198x
```

Only the `build198x` pipeline CLI is packaged here today. The standalone
`build198x-adf` binary is on crates.io (`cargo install build198x-adf`) but is
not yet attached to a GitHub Release, so there is nothing for a formula to
point at. See build198x/build198x for that.

## About this repository

The formulae here are **generated**, not hand-written. Each build198x release runs
`cargo-dist`, which builds the platform archives, writes the formula from the
release's own manifest, and commits it to this repository.

So changes belong upstream: edit the packaging configuration in
[`build198x/build198x`](https://github.com/build198x/build198x) rather than the formula, or a
release will overwrite them.
