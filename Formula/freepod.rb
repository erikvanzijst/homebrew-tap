class Freepod < Formula
  include Language::Python::Virtualenv

  desc "Take a local project directory to a running deployment on freepod.eu"
  homepage "https://pypi.org/project/freepod/"
  url "https://files.pythonhosted.org/packages/16/58/dce81d0c9890cd7b53596be58248340ec8012bb030858c5521a79c022511/freepod-0.11.1.tar.gz"
  sha256 "f869f12fd409e40a6509be3eb9f4771f8bf52e390b942a5d63adfa271b0e1d96"
  license "MIT"

  bottle do
    root_url "https://github.com/erikvanzijst/homebrew-tap/releases/download/freepod-0.10.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9fee2dafaba2b8139097bdc5c926775e4652a95b9e4541aa15676b589508d7ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b30221dfcb586d69462f54ce07c83f374b44350d178df23d4532756a6bbd97cf"
  end

  depends_on "python@3.14"

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/61/cc/a381afa6efea9f496eff839d4a6a1aed3bfafc7b3ab4b0d1b243a12573dd/anyio-4.14.2.tar.gz"
    sha256 "cfa139f3ed1a23ee8f88a145ddb5ac7605b8bbfd8592baacd7ce3d8bb4313c7f"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/a3/c2/24167ea9858356b47a87a50d39908bfdb72ceeefe0041586e704e5376b3a/certifi-2026.7.22.tar.gz"
    sha256 "741e2c3b351ddf169a738da9f2c048608ff7f2c5cc02f1ebc6b118bb090d5d55"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/76/d4/81420972a676e8ffea40450d8c8c92943e7218a78fe9b64359836cc9876b/click-8.4.2.tar.gz"
    sha256 "9a6cea6e60b17ebe0a44c5cc636d94f09bd66142c1cd7d8b4cd731c4917a15f6"
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
    url "https://files.pythonhosted.org/packages/cd/63/9496c57188a2ee585e0f1db071d75089a11e98aa86eb99d9d7618fc1edce/idna-3.18.tar.gz"
    sha256 "ffb385a7e039654cef1ab9ef32c6fafe283c0c0467bba1d9029738ce4a14a848"
  end

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/5a/82/42f767fc1c1143d6fd36efb827202a2d997a375e160a71eb2888a925aac1/pathspec-1.1.1.tar.gz"
    sha256 "17db5ecd524104a120e173814c90367a96a98d07c45b2e10c2f3919fff91bf5a"
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
