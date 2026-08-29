class Build198x < Formula
  desc "The 198x family's build-tools pipeline — asset conversion, data packing, and media mastering for retro targets."
  homepage "https://build198x.github.io"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.6/build198x-aarch64-apple-darwin.tar.xz"
      sha256 "7fa60e5803d829f91de95b916f921057887dee61c8496f265e54240524ef8a83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.6/build198x-x86_64-apple-darwin.tar.xz"
      sha256 "492c71f49155230b277828d9fb468b8dd44860d6428688d75394637f4044065d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.6/build198x-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "871956cc1419f90473681ea04c85e27d6641ec87c79dc3f03dc84c30f6b15a86"
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
      bin.install "build198x"
    end
    if OS.mac? && Hardware::CPU.intel?
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
