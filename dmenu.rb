# typed: false
# frozen_string_literal: true

class Dmenu < Formula
  desc "Dynamic menu for X11"
  homepage "https://tools.suckless.org/dmenu/"
  url "https://dl.suckless.org/tools/dmenu-5.0.tar.gz"
  sha256 "fe18e142c4dbcf71ba5757dbbdea93b1c67d58fc206fc116664f4336deef6ed3"
  head "https://git.suckless.org/dmenu/", using: :git

  bottle do
    sha256 cellar: :any_skip_relocation, mojave:      "44e6f96de8f8dd18389c17b99f65a9632cb134b183512ddbd05a542279005f84"
    sha256 cellar: :any_skip_relocation, high_sierra: "297b8b591ee33d1a4f8100de2de275ca15268a906c77c1b4123d0787deb2cab4"
    sha256 cellar: :any_skip_relocation, sierra:      "2fe7512953f6e5099a4a624d8ebc6a3e83bda0753eafa7bb7f2942db90d21e62"
  end

  depends_on "freetype"
  depends_on :x11

  def install
    freetype = Formula["freetype"].opt_prefix
    ftinc = `#{freetype}/bin/freetype-config --prefix`.strip
    system "make", "PREFIX=#{prefix}", "FREETYPEINC=#{ftinc}/include/freetype2", "install"
  end

  test do
    assert_match(/#{version}/, shell_output("#{bin}/dmenu -v"))
  end
end
