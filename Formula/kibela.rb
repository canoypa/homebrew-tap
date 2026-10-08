class Kibela < Formula
  desc "Read Kibela notes from the command line"
  homepage "https://github.com/canoypa/kibela-cli"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.2.0/kibela-aarch64-apple-darwin.tar.xz"
      sha256 "b2a3d5e51f86333794931d01407916fab1658fd33d9ec52d201e4f0dc92d6ac8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.2.0/kibela-x86_64-apple-darwin.tar.xz"
      sha256 "4047e08e7437a7d06f18dcd7b34fa39c44f06750fb42acddd76e83804e9b5b5d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.2.0/kibela-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f8e1783e7e44001d1eca0a311128a6603858eb37374a49f394ea177fa3b1ca9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canoypa/kibela-cli/releases/download/v0.2.0/kibela-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c74fb1dff38d17157c8f8083f0319916d877c765405baab20cf88671946ebc7c"
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
