class Pdfsearch < Formula
  desc "High-performance PDF full-text search with text indexing and fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "138eb2ec06ccd9930c34e1a2b1640134f21f5ee6bcfc00cc5a208615205b5039"
  license "MIT"
  head "https://github.com/0xlxx/pdfsearch.git", branch: "main"

  depends_on "python@3.13"
  depends_on "ripgrep"

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "pip", "install", "--target=#{libexec}", "PyMuPDF>=1.23"
    libexec.install "pdfsearch"
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
