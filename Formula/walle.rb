class Walle < Formula
  desc "a trash compactor for your code comments"
  homepage "https://github.com/kallepronk/wall-e"
  url "https://github.com/kallepronk/wall-e/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0c62e66a0ee4b390bad25991448d1a98f16dc7f0cf6f02363e149504ffac371b"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"walle"), "."

    # 2. Create the second entrypoint (Symlink)
    # This tells Homebrew: "Create a symlink named 'wall-e' that points to 'walle'"
    bin.install_symlink "walle" => "wall-e"
  end

  test do
    # specific tests to ensure both entrypoints work
    system "#{bin}/walle", "--version"
    system "#{bin}/wall-e", "--version"
  end
end