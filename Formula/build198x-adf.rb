class Build198xAdf < Formula
  desc "Create, master, verify, and inspect Amiga ADF floppy disk images (OFS/FFS) — the standalone ADF tool."
  homepage "https://build198x.github.io"
  version "0.2.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.11/build198x-adf-aarch64-apple-darwin.tar.xz"
      sha256 "848fce1f61812d4b3a212fb483e7f39cad26ca40e5b3d51e86e1443c96dd398a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.11/build198x-adf-x86_64-apple-darwin.tar.xz"
      sha256 "38ca1b10ccf4bce22eacebe236f06ba50842e3b4df17d9fd8cd7b604055edf06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.11/build198x-adf-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "605c388a3164aa889bf6f1cc8e5f404910e780511be862076822128092df03ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/build198x/build198x/releases/download/build198x-adf-v0.2.11/build198x-adf-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9c479bd8510c6c1111078e3a35f834a9c4cec7a8d65d267a01d06df6667464bf"
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
