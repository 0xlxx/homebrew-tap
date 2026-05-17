class Pdfsearch < Formula
  desc "High-performance PDF full-text search with fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "1dd8faa557cc20eadf65085a6e00b6d08f06a8f528a622a876044658794c0da2"
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
      Interactive mode (-I) requires fzf. Install it with:
        brew install fzf
    EOS
  end

  test do
    system bin/"pdfsearch", "--help"
  end
end
