class Walle < Formula
  desc "a trash compactor for your code comments"
  homepage "https://github.com/kallepronk/wall-e"
  url "https://github.com/kallepronk/wall-e/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "64b3e0d8cbc2fde33fe95f3b01c1052a19547c39ff714fae8fa89a1ab6183959"
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