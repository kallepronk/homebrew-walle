class Walle < Formula
  desc "a trash compactor for your code comments"
  homepage "https://github.com/kallepronk/wall-e"
  url "https://github.com/kallepronk/wall-e/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "99f2fdf5bb12b3af01abb411a92de500c9d4852d44b2624025dbaac7daa04eb9"
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