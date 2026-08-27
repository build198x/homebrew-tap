# build198x Homebrew tap

Homebrew formulae for [build198x](https://github.com/build198x/build198x), which converts assets, packs data and masters retro media.

```sh
brew install build198x/homebrew-tap/build198x
```

The standalone ADF tool has its own formula:

```sh
brew install build198x/homebrew-tap/build198x-adf
```

`build198x adf` is the same operation inside the pipeline tool; `build198x-adf`
is the leaner install for someone who only wants ADF mastering. It is also on
crates.io, so `cargo install build198x-adf` works too.

## About this repository

The formulae here are **generated**, not hand-written. Each build198x release runs
`cargo-dist`, which builds the platform archives, writes the formula from the
release's own manifest, and commits it to this repository.

So changes belong upstream: edit the packaging configuration in
[`build198x/build198x`](https://github.com/build198x/build198x) rather than the formula, or a
release will overwrite them.
