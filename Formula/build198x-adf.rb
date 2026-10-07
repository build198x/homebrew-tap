class Build198xAdf < Formula
  desc "Create, master, verify, and inspect Amiga ADF floppy disk images (OFS/FFS) — the standalone ADF tool."
  homepage "https://build198x.github.io"
  version "0.2.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.10/build198x-adf-aarch64-apple-darwin.tar.xz"
      sha256 "cb7ea1b8a0cd6c39176a5a5653fafcdae83795eb93868c03e65a20587c2fca81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.10/build198x-adf-x86_64-apple-darwin.tar.xz"
      sha256 "002fda03b5650f7c2a8465cc51498c645fa6fee1d9132781f84e6129f68ab7e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.10/build198x-adf-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "51d608a56a86b8a77cf27afa98227defcd27defbad54aebd6f71e09eaf01024d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.10/build198x-adf-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a084b55f9006686b2a1cb5029c3e42f6d417cd941d902b6d88bb160a9206380b"
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
