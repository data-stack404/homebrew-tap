# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://docs.brew.sh/rubydoc/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
require "language/node"
require "fileutils"

class MdChangelogLinter < Formula
  desc "A simple markdown linter to create high-quality changelogs"
  homepage "https://github.com/data-stack404/md-changelog-linter"
  url "https://github.com/data-stack404/md-changelog-linter/archive/refs/tags/1.1.1.tar.gz"
  sha256 "9392f1aca940606a01ab11edb377570d96da4bc02cc35855d48ad6d8eaef4a4b"
  license "MIT"

  depends_on "node"

  def install
    # Use Language::Node helper to install node_modules into libexec in the Homebrew way.
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

    # If the repo includes a prebuilt dist/, copy it into the installed package directory
    # so that bin/* scripts that do `require('../dist/...')` can find it.
    if (buildpath/"dist").exist?
      target = libexec/"lib/node_modules/md-changelog-linter"
      target.mkpath
      FileUtils.cp_r (buildpath/"dist"), target
    end

    # Symlink executables
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # Basic sanity check: ensure the binary runs and prints a help/version line.
    # Adjust the --version/--help flag according to the CLI's available options.
    assert_predicate bin/"md-changelog-linter", :exist?
    system "#{bin}/md-changelog-linter", "CHANGELOG.md"
  end
end
