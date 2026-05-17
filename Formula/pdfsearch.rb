class Pdfsearch < Formula
  include Language::Python::Virtualenv

  desc "High-performance PDF full-text search with fzf interactive mode"
  homepage "https://github.com/0xlxx/pdfsearch"
  url "https://github.com/0xlxx/pdfsearch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "82b7ce046c5bf2c8a6c576b88a6955f44b8a62c2f5e3591533f299a586c09d54"
  license "MIT"
  head "https://github.com/0xlxx/pdfsearch.git", branch: "main"

  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install "PyMuPDF"
    libexec.install "pdfsearch"
    (bin/"pdfsearch").write_env_script libexec/"pdfsearch", PATH: "#{libexec}/bin:$PATH"
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
