class BucketManager < Formula
  desc "Native macOS S3-compatible object storage browser"
  homepage "https://github.com/allenhack638/bucket-manager"
  url "https://github.com/allenhack638/bucket-manager/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a10ecab184e948fd61bac03588353d73b228a5c8340fbdc6753c08ecf1a2b4fa"
  license "MIT"

  depends_on macos: :sonoma

  def install
    ENV["VERSION"] = version.to_s
    ENV["BUILD_NUMBER"] = "1"
    inreplace "make-app.sh",
      'swift build -c "$CONFIG" -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types',
      'swift build -c "$CONFIG" -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types --disable-sandbox'
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
    assert_path_exists prefix/"Bucket Manager.app"
  end
end
