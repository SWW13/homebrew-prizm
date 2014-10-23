require 'formula'

class Mkg3a < Formula
  homepage 'https://bitbucket.org/tari/mkg3a/overview'
  url 'https://bitbucket.org/tari/mkg3a/get/e54c94261575.zip'
  sha1 'f1212ece44e24a2202964fce1394e8623f18301a'

  depends_on 'cmake' => :build

  def install
    FileUtils.cd('src') do
      system 'cmake', '.', *std_cmake_args
      system 'make'
      system 'make', 'install'
    end
  end

end
