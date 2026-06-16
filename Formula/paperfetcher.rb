class Paperfetcher < Formula
  desc "LLM-agent-friendly CLI for academic paper search and retrieval"
  homepage "https://github.com/0xlxx/paperfetcher"
  version "0.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/0xlxx/paperfetcher/releases/download/v#{version}/paperfetcher-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2004e793d20e8cf32f98cc764f901aed87ef5955bf830f64400d2b1e717810fd"
    else
      url "https://github.com/0xlxx/paperfetcher/releases/download/v#{version}/paperfetcher-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "4f951ae6d5a359175c17dded22e8b6402c47dfe210986c6c5c9d6d41d779061f"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/0xlxx/paperfetcher/releases/download/v#{version}/paperfetcher-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fce485c3282028777861bac3dd7987fb333fb68be2fe60ff98abc1f27c4b571a"
    end
  end

  def install
    bin.install "paperfetcher"
  end

  test do
    assert_match "paperfetcher", shell_output("#{bin}/paperfetcher --version")
  end
end
