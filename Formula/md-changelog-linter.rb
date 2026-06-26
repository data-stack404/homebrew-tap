# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://docs.brew.sh/rubydoc/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class MdChangelogLinter < Formula
  desc "A simple markdown linter to create high-quality changelogs"
  homepage "https://github.com/data-stack404/md-changelog-linter"
  url "https://github.com/data-stack404/md-changelog-linter/archive/refs/tags/1.1.1.tar.gz"
  sha256 "e3bb51c3370990c3af53d81537f2593dbd88d14c4acb949ab2469d7b0da04e5d"
  license "MIT"

  depends_on "node"

  def install
    # If the project needs a build step, run it so `dist/` is created.
    # Many projects have build scripts defined in package.json; running this
    # explicitly ensures the output exists before install.
    system "npm", "run", "build" if (buildpath/"package.json").exist?

    # Use Language::Node helper to install into libexec in the Homebrew way.
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

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
