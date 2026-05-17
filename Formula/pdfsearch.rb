class Pdfsearch < Formula
  desc "High-performance PDF full-text search with fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "bd6efebdb05ab5077bc115071647f1c9e818580a4e66725e4133534718aa6b91"
  license "MIT"
  head "https://github.com/0xlxx/pdfsearch.git", branch: "main"

  depends_on "python@3.13"

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "pip", "install", "--target=#{libexec}", "PyMuPDF>=1.23"
    libexec.install "pdfsearch"
    (bin/"pdfsearch").write_env_script libexec/"pdfsearch", PYTHONPATH: libexec
  end

  def caveats
    <<~EOS
      Interactive mode (-I) requires fzf and Skim:
        brew install fzf skim
    EOS
  end

  test do
    system bin/"pdfsearch", "--help"
  end
end
