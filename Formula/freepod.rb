class Freepod < Formula
  include Language::Python::Virtualenv

  desc "Take a local project directory to a running deployment on freepod.eu"
  homepage "https://pypi.org/project/freepod/"
  url "https://files.pythonhosted.org/packages/0d/50/9f78d6a5c4312364fc97c654d70c0459ad8097eda1251a561b165dce9702/freepod-0.25.1.tar.gz"
  sha256 "e0fbcd90c50303be5df5ddbfd535812193744d62472727ff56c784daca6c02a0"
  license "MIT"

  bottle do
    root_url "https://github.com/erikvanzijst/homebrew-tap/releases/download/freepod-0.25.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1aa47d78950850db57ccd3bbd1716f00171d405bdd3089177e79d65ea76083e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f799b787fe0d71d557cc77c3162eb599dd3b15b4559cd0529601d190f2a5ef6b"
  end

  depends_on "python@3.14"

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/a1/98/7e457a3b014976887a050561955c0b76e1e7e2d6e27b78ecef2ef80518f2/anyio-4.16.0.tar.gz"
    sha256 "59bb03251907983d1603d27c3087ddb1e93299ea2163adcdba37899a4fb12ffb"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/fd/11/b524cbd9bbdaca58608e4cf4053fd463417549e1959fa8d3aa18319f9555/certifi-2026.10.23.tar.gz"
    sha256 "a9895e6e2758b371e0545e321a3a8fd1fcfd9829ada8824a936dfb16aaaf36cd"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/45/37/edbf1b0707709013c0cf2e8317e03d97ed29bf4cac709fe328904ae92a38/click-8.5.1.tar.gz"
    sha256 "9bbfada76703fd1d784b83eea012e3e8c6a001a876543ef104fa56aaaeb072b4"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
  end

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/5a/82/42f767fc1c1143d6fd36efb827202a2d997a375e160a71eb2888a925aac1/pathspec-1.1.1.tar.gz"
    sha256 "17db5ecd524104a120e173814c90367a96a98d07c45b2e10c2f3919fff91bf5a"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end

  def install
    virtualenv_install_with_resources
    generate_completions_from_executable(bin/"freepod", shell_parameter_format: :click)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/freepod --version")

    # With no cached credential the client fails closed, offline, on the exit
    # code its distribution contract documents for "not authenticated".
    assert_match "not authenticated", shell_output("#{bin}/freepod whoami 2>&1", 3)
  end
end
