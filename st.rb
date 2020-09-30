class St < Formula
  desc "Suckless Terminal"
  homepage "https://st.suckless.org/"
  url "https://github.com/bentitmus/st/archive/0.8.6.tar.gz"
  sha256 "d79bb4e4ee3f2bc01a072ee23a12d26a176ed699"
  revision 1
  head "https://git.suckless.org/st", :using => :git

  bottle do
    cellar :any_skip_relocation
    sha256 "a749a913684983c05a9998ca73d55bd8f05197fcf6d7573336eacf7e168a5120" => :mojave
    sha256 "0c5e0fd48f4d52ab748d5301add02b7ca39d773c604e108d2eb81705cf80c315" => :high_sierra
    sha256 "20707f7d694eef615c63c98c055db728a6922e68ccf287ca63933715781311e6" => :sierra
  end

  depends_on "freetype"
  depends_on :x11
  depends_on "pkg-config" => :build

  def install
    freetype = Formula["freetype"].opt_prefix
    ftinc = `#{freetype}/bin/freetype-config --prefix`.strip
    system "make", "PREFIX=#{prefix}", "FREETYPEINC=#{ftinc}/include/freetype2", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/st -v 2>&1", 1)
  end
end
