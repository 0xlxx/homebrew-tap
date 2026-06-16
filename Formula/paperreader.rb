class Paperreader < Formula
  desc "High-performance full-text search for PDF, EPUB, and TXT files, tailored for LLM agents"
  homepage "https://github.com/0xlxx/paperreader"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/0xlxx/paperreader/releases/download/v0.1.0/paperreader-mac-intel.tar.gz"
      sha256 "9d62219367a6c5b4c993b54425f915ff2cd3f2a1d0371eaf1fe3bdcf1f246f92"
    elsif Hardware::CPU.arm?
      url "https://github.com/0xlxx/paperreader/releases/download/v0.1.0/paperreader-mac-arm64.tar.gz"
      sha256 "16cff6e880543be3db45da6fcca1570c59f1b159dfae676c9558b0988e96da3d"
    end
  end

  depends_on "ripgrep"

  def install
    bin.install "paperreader"
  end

  def caveats
    <<~EOS
      Interactive mode (-I) requires fzf and Skim:
        brew install fzf
        brew install --cask skim
    EOS
  end

  test do
    system bin/"paperreader", "--help"
  end
end
