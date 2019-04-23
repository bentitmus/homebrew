class Dwm < Formula
  desc "Dynamic window manager"
  homepage "https://dwm.suckless.org/"
  url "https://github.com/bentitmus/dwm/archive/6.1.1.tar.gz"
  sha256 "727abe33e80aa773cf42904d4ea31f80dce9cacdd116ad9205e10e58bb4cc40a"
  revision 1
  head "https://git.suckless.org/dwm", :using => :git

  bottle do
    cellar :any_skip_relocation
    sha256 "a749a913684983c05a9998ca73d55bd8f05197fcf6d7573336eacf7e168a5120" => :mojave
    sha256 "0c5e0fd48f4d52ab748d5301add02b7ca39d773c604e108d2eb81705cf80c315" => :high_sierra
    sha256 "20707f7d694eef615c63c98c055db728a6922e68ccf287ca63933715781311e6" => :sierra
  end

  depends_on "dmenu"
  depends_on "freetype"
  depends_on :x11

  def install
    freetype = Formula["freetype"].opt_prefix
    ftinc = `#{freetype}/bin/freetype-config --prefix`.strip
    system "make", "PREFIX=#{prefix}", "FREETYPEINC=#{ftinc}/include/freetype2", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/dwm -v 2>&1", 1)
  end
end
