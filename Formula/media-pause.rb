class MediaPause < Formula
  desc "macOS countdown timer that pauses browser media"
  homepage "https://github.com/0xlxx/media-pause"
  url "https://github.com/0xlxx/media-pause/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "936a4e001f35a284c59a8c7a8e6a54956201daaafe58ef2c6b9e3903927bb837"
  license "MIT"
  version "0.1.0"
  head "https://github.com/0xlxx/media-pause.git", branch: "main"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    system "swiftc", "-O", "-o", "media-pause", "main.swift"
    bin.install "media-pause"
  end

  test do
    assert_match "media-pause", shell_output("#{bin}/media-pause --version")
  end
end
