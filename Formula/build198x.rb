class Build198x < Formula
  desc "The 198x family's build-tools pipeline — asset conversion, data packing, and media mastering for retro targets."
  homepage "https://build198x.github.io"
  version "0.2.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.13/build198x-aarch64-apple-darwin.tar.xz"
      sha256 "12c9f61f121907b3403a7f4047093589ca7602a2bafe3b7a0322858cb6b2ed72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.13/build198x-x86_64-apple-darwin.tar.xz"
      sha256 "6ee18d16f1b7271a31decb5e37ed8fb5b065fc7311422cadaee30c4fb873d4a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.13/build198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "be04a389229bbb9c7ac524ea34ca9666a0f6f3309fb8eedef617754f3f30ca00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-v0.2.13/build198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cfda688ba30e811852efdc3e80949affeaf247d7360141a6d343aa36d13eb755"
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
