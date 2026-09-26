class Build198xAdf < Formula
  desc "Create, master, verify, and inspect Amiga ADF floppy disk images (OFS/FFS) — the standalone ADF tool."
  homepage "https://build198x.github.io"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.7/build198x-adf-aarch64-apple-darwin.tar.xz"
      sha256 "b62b9fee63b4334796a4cd7b08433ee2195cb8958c988fee5006a5daf36ee165"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.7/build198x-adf-x86_64-apple-darwin.tar.xz"
      sha256 "fc18dac981c5a1cfaf52e3975303c22ef3ae09cf5bb34991873778cda919c5b0"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.7/build198x-adf-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "de951b832df3457018ab313df60883a17b7d2bf315d0c9c3d55f18b2a28db0df"
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
