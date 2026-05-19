class Pdfsearch < Formula
  desc "High-performance full-text search for PDF, EPUB, and TXT files"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "1c953a2923aeab49de1c24c1cb320d7e5d1651d77d7ddfcd208ae515d0e24a93"
  license "MIT"
  head "https://github.com/0xlxx/pdfsearch.git", branch: "main"

  depends_on "python@3.13"
  depends_on "ripgrep"

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "pip", "install", "--target=#{libexec}", "PyMuPDF>=1.23"
    libexec.install "pdfsearch"
    libexec.install "core"
    (bin/"pdfsearch").write_env_script libexec/"pdfsearch", PYTHONPATH: libexec
  end

  def caveats
    <<~EOS
      Interactive mode (-I) requires fzf and Skim:
        brew install fzf
        brew install --cask skim
    EOS
  end

  test do
    system bin/"pdfsearch", "--help"
  end
end
