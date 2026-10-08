class Kibela < Formula
  desc "Read Kibela notes from the command line"
  homepage "https://github.com/canoypa/kibela-cli"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.1.0/kibela-aarch64-apple-darwin.tar.xz"
      sha256 "2eb88e8507b6f1d54e8945acbc628e4c6be784b7bea0908c4c0cb11f86573f53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.1.0/kibela-x86_64-apple-darwin.tar.xz"
      sha256 "bb9ab0eebc631d1878dd542d56c43c4fb1ae46d85049e1fc5a14830d15a51f0c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.1.0/kibela-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "21da30f481ce16bcaa4254839010022e000cb2333d69364d6305b9a8851877ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.1.0/kibela-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f42f0ac737ff356253473e1565146c64ab946c9c4d65bb049a2c86056d042740"
    end
  end
  license "MIT"

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
      bin.install "kibela"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kibela"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kibela"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kibela"
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
