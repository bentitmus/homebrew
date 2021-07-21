# typed: false
# frozen_string_literal: true

class St < Formula
  desc "Suckless Terminal"
  homepage "https://st.suckless.org/"
  url "https://github.com/bentitmus/st/archive/0.9.0.tar.gz"
  sha256 "d61dea9f3feff55732604938bd99c37548aaa21cc9e57c3fb8e6a3f693a4656d"
  revision 1
  head "https://git.suckless.org/st", using: :git

  bottle do
    sha256 cellar: :any_skip_relocation, mojave:      "a749a913684983c05a9998ca73d55bd8f05197fcf6d7573336eacf7e168a5120"
    sha256 cellar: :any_skip_relocation, high_sierra: "0c5e0fd48f4d52ab748d5301add02b7ca39d773c604e108d2eb81705cf80c315"
    sha256 cellar: :any_skip_relocation, sierra:      "20707f7d694eef615c63c98c055db728a6922e68ccf287ca63933715781311e6"
  end

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "libx11"
  depends_on "libxft"

  def install
    freetype = Formula["freetype"].opt_prefix
    ftinc = `#{freetype}/bin/freetype-config --prefix`.strip
    system "make", "PREFIX=#{prefix}", "FREETYPEINC=#{ftinc}/include/freetype2", "install"
  end

  test do
    assert_match(/#{version}/, shell_output("#{bin}/st -v 2>&1", 1))
  end
end
