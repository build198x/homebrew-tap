class Build198x < Formula
  desc "The 198x family's build-tools pipeline — asset conversion, data packing, and media mastering for retro targets."
  homepage "https://build198x.github.io"
  version "0.2.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.10/build198x-aarch64-apple-darwin.tar.xz"
      sha256 "9b2387c0e8c59ef50d9fa478ba12bedd926e416a0e069f594104bbdee370f3b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.10/build198x-x86_64-apple-darwin.tar.xz"
      sha256 "f6726d0f48cab3c240fae355fb3ca4ce44207a378330cc5ab3fc341bf4451cb3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.10/build198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e9e495c0110bdf8be11483d01f6ac4612665b312d8c1e90df56104c6a01b27c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.10/build198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "406ebadd315890488a7df6d4e055fa9e23c92ee8cb0ed8c6ffcb89aa4fad4198"
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
