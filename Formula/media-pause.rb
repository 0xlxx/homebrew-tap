class MediaPause < Formula
  desc "macOS countdown timer that pauses and resumes browser media"
  homepage "https://github.com/0xlxx/media-pause"
  url "https://github.com/0xlxx/media-pause/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "9aafa776cce4114e23d5ac6c08f62bcc23d8a4320a5b2cc3cc4383b0b483545e"
  license "MIT"
  head "https://github.com/0xlxx/media-pause.git", branch: "main"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/media-pause"
  end

  test do
    assert_match "media-pause", shell_output("#{bin}/media-pause --version")
  end
end
