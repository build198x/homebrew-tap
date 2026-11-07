class Build198xAdf < Formula
  desc "Create, master, verify, and inspect Amiga ADF floppy disk images (OFS/FFS) — the standalone ADF tool."
  homepage "https://build198x.github.io"
  version "0.2.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.15/build198x-adf-aarch64-apple-darwin.tar.xz"
      sha256 "0cc556cbe1356f8bbe724a5489cea5c12deb89f73426472009e5db3e09bce463"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.15/build198x-adf-x86_64-apple-darwin.tar.xz"
      sha256 "b1f05138677f9706020959ce4349e9187f61776b300b4c9dbe50b1f6fc638f2f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.15/build198x-adf-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "40a7d339a525e8fa4a491d7b7ea10ffbcf1b24c78054b9d754ab4cdd2b0d89ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.15/build198x-adf-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0a95dc93183c50163da0bf6fbbf3ad188960633d5126d62dd450b7db8fd85d3a"
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
      bin.install "build198x-adf"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "build198x-adf"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "build198x-adf"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "build198x-adf"
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
