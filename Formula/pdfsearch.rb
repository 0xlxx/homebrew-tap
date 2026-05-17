class Pdfsearch < Formula
  desc "High-performance PDF full-text search with fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "82b7ce046c5bf2c8a6c576b88a6955f44b8a62c2f5e3591533f299a586c09d54"
  license "MIT"
  head "https://github.com/0xlxx/pdfsearch.git", branch: "main"

  depends_on "python@3.13"

  resource "pymupdf" do
    url "https://files.pythonhosted.org/packages/01/89/3f8edd6c4f50ca370e2a2f2a3011face36f3760728ffe76dffec91c0fca0/pymupdf-1.27.2.3-cp310-abi3-macosx_11_0_arm64.whl"
    sha256 "660d93cb6da5bbddf11d3982ae27745dd3a9902d9f24cdb69adab83962294b5a"
  end

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "pip", "install", "--target=#{libexec}", resource("pymupdf").cached_download
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
