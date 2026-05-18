class Pdfsearch < Formula
  desc "High-performance PDF full-text search with text indexing and fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "00d762fbd96f5f668f4eae55a870cc24f62d43a3bdc3224281276e50cf45d0dd"
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
