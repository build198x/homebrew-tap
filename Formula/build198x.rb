class Build198x < Formula
  desc "The 198x family's build-tools pipeline — asset conversion, data packing, and media mastering for retro targets."
  homepage "https://build198x.github.io"
  version "0.2.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.11/build198x-aarch64-apple-darwin.tar.xz"
      sha256 "bd510f646968cb854fbdb14868116c480a74b57dfd87068a4dfce08b05c7c49b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.11/build198x-x86_64-apple-darwin.tar.xz"
      sha256 "cad94448d913b1e8151455234a5f75b5327a20d93f7001eea762dd4dcb1818a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.11/build198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bb442e7724a59b24568c166f5dcd555acaadab4518fe97d6d9e01e57055d2a1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.11/build198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7f9f26f08d08789874b9208d3287caf6eab92d6eb05412d156817e14ad6f753"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "build198x"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "build198x"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "build198x"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "build198x"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
