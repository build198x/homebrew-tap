class Build198x < Formula
  desc "The 198x family's build-tools pipeline — asset conversion, data packing, and media mastering for retro targets."
  homepage "https://build198x.github.io"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.5/build198x-aarch64-apple-darwin.tar.xz"
      sha256 "bb20b02d3a64cba81ffc7d2d37030b0484203a5aaa9def323d1305b40d3eee08"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.5/build198x-x86_64-apple-darwin.tar.xz"
      sha256 "4da36fab844223b5031fa04be86921f82d9aaed6d3434c6f13335ab84d4440b4"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.5/build198x-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c6aa7994a71d4e360b00da1e4901c94be23efc0808af41a1476e93fdad0908e7"
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
