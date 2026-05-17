class Pdfsearch < Formula
  include Language::Python::Virtualenv

  desc "High-performance PDF full-text search with fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "82b7ce046c5bf2c8a6c576b88a6955f44b8a62c2f5e3591533f299a586c09d54"
  license "MIT"
  head "https://github.com/0xlxx/pdfsearch.git", branch: "main"

  depends_on "python@3.13"

  resource "pymupdf" do
    url "https://files.pythonhosted.org/packages/22/32/708bedc9dde7b328d45abbc076091769d44f2f24ad151ad92d56a6ec142b/pymupdf-1.27.2.3.tar.gz"
    sha256 "7a92faa25129e8bbec5e50eeb9214f187665428c31b05c4ef6e36c58c0b1c6d2"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Interactive mode (-I) requires fzf. Install it with:
        brew install fzf
    EOS
  end

  test do
    assert_match "pdfsearch", shell_output("#{bin}/pdfsearch --help")
  end
end
