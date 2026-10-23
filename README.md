# Homebrew Tap for Bucket Manager

Builds [Bucket Manager](https://github.com/allenhack638/bucket-manager) from source:

```bash
brew tap allenhack638/bucket-manager
brew install --build-from-source bucket-manager
bucket-manager
```

Building from source avoids the quarantine warning on unsigned GitHub binary releases.
Requires macOS 14+ and an Xcode/Swift 6.2+ toolchain.
