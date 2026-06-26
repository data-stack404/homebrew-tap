# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://docs.brew.sh/rubydoc/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class MdChangelogLinter < Formula
  desc "A simple markdown linter to create high-quality changelogs"
  homepage "https://github.com/data-stack404/md-changelog-linter"
  url "https://github.com/data-stack404/md-changelog-linter/archive/refs/tags/1.1.0.tar.gz"
  sha256 "78de633b317cf78d005b76d7263b1ae5e3220054f8f55cb0da6564c81c3a6584"
  license "MIT"

  depends_on "node"

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test md-changelog-linter`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
