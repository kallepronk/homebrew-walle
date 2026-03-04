class Walle < Formula
  desc "a trash compactor for your code comments"
  homepage "https://github.com/kallepronk/wall-e"
  url "https://github.com/kallepronk/wall-e/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "a7e31048c22b424d92f2c781fbba1da8f706b81c2f3b0117002d969fc2b9917d"
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