class Build198xAdf < Formula
  desc "Create, master, verify, and inspect Amiga ADF floppy disk images (OFS/FFS) — the standalone ADF tool."
  homepage "https://build198x.github.io"
  version "0.2.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.12/build198x-adf-aarch64-apple-darwin.tar.xz"
      sha256 "479fe1830a3fc26d3109a4ecfaf36913a6530fb3351cc0a678b42620efda12ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.12/build198x-adf-x86_64-apple-darwin.tar.xz"
      sha256 "631eb96b4ea2175e3f82d9006573b53f653f285fb67bb0319ca9f5415b6502d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.12/build198x-adf-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2adcabc2d7146b4d1daa4ebe41a8e3b9021083bdda786e758d8ff4fe09f4b848"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.12/build198x-adf-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "45fb5a88e03d7ab4f85b9bd102909f83e1a3420131d1da75e958f79240f6cb50"
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
