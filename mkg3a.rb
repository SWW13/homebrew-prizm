require 'formula'

class Mkg3a < Formula
  homepage 'https://bitbucket.org/tari/mkg3a/overview'
  url 'https://bitbucket.org/tari/mkg3a/get/e54c94261575.zip'
  sha1 'f1212ece44e24a2202964fce1394e8623f18301a'

  depends_on 'cmake' => :build

  def install
    #ENV['CC'] = '/usr/local/bin/gcc-4.9'
    #ENV['CXX'] = '/usr/local/bin/g++-4.9'
    #ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    #ENV['LD'] = '/usr/local/bin/gcc-4.9'

    mkdir 'build' do
      
      FileUtils.cd('../src', :verbose => true)
      
      system 'cmake', '.', *std_cmake_args
      system 'make'
      system 'make', 'install'
    end
  end

end
