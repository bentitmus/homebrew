# Example homebrew formula for Rosie Pattern Language
# https://gitlab.com/rosie-community/homebrew-rosie.git

$ROSIE_VERSION = "1.1.0"

class Rosie < Formula
  desc "The Rosie Project's pattern language and pattern matching engine"
  homepage "https://rosie-lang.org"
  version $ROSIE_VERSION
  url "https://gitlab.com/rosie-pattern-language/rosie.git", :tag => "v#{$ROSIE_VERSION}"
  head "https://gitlab.com/rosie-pattern-language/rosie.git", :branch => "master"
  #sha256 ""

  #depends_on :xcode => :build

  def install
    ENV.deparallelize
    if prefix=="" then
      odie "homebrew prefix is not set!  (usually this is /usr/local)"
    end
    system "make", "clean"
    system "make", "install", "BREW=true", "DESTDIR="+prefix
    ohai "Rosie installed successfully!"
    ohai "    RPL libraries, documentation, etc are in #{HOMEBREW_PREFIX}/lib/rosie"
    ohai "    Executable will be linked (by brew) to #{HOMEBREW_PREFIX}/bin/rosie"
    ohai "    Try this example, and look for color text output: rosie match all.things #{HOMEBREW_PREFIX}/lib/rosie/README"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    system "#{bin}/rosie", "config"
    system "#{bin}/rosie", "match", "-o", "line", "all.things", "#{prefix}/README"
    assert_equal version, shell_output("#{bin}/rosie version").strip[0, version.to_s.length]
  end
end
