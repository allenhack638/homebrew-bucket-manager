class BucketManager < Formula
  desc "Native macOS S3-compatible object storage browser"
  homepage "https://github.com/allenhack638/bucket-manager"
  url "https://github.com/allenhack638/bucket-manager/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "5a09247432cfdddc24b74a835c2b3fd573c5512d86da98ff34277dc161dd1f4c"
  license "MIT"

  depends_on :macos => :sonoma
  depends_on xcode: :build

  def install
    ENV["VERSION"] = version.to_s
    ENV["BUILD_NUMBER"] = "1"
    system "./make-app.sh", "release"
    prefix.install "build/Bucket Manager.app"
    (bin/"bucket-manager").write <<~SH
      #!/bin/bash
      exec open "#{opt_prefix}/Bucket Manager.app"
    SH
    chmod 0755, bin/"bucket-manager"
  end

  def caveats
    <<~EOS
      Bucket Manager is installed under Homebrew’s prefix, not /Applications.
      Launch it with:
        bucket-manager
      or:
        open "#{opt_prefix}/Bucket Manager.app"
    EOS
  end

  test do
    assert_predicate prefix/"Bucket Manager.app", :exist?
  end
end
