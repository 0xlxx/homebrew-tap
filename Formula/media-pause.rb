class MediaPause < Formula
  desc "macOS countdown timer that pauses and resumes browser media"
  homepage "https://github.com/0xlxx/media-pause"
  url "https://github.com/0xlxx/media-pause/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "4d077021b5bc03bd7dca3ac7e609e3815c822ddcb6567839f49fff2ff64b4c23"
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
