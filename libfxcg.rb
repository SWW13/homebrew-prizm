require 'formula'

class Libfxcg < Formula
  homepage 'https://github.com/Jonimoose/libfxcg'
  head 'https://github.com/Jonimoose/libfxcg.git'

  depends_on 'gmp' => :build
  depends_on 'libmpc' => :build
  depends_on 'mpfr' => :build
  depends_on 'gcc49' => :build
  depends_on 'sh3eb-elf-binutils'
  depends_on 'sh3eb-elf-gcc'

  def install
    binutils = Formula.factory 'sh3eb-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.9'
    ENV['CXX'] = '/usr/local/bin/g++-4.9'
    ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    ENV['LD'] = '/usr/local/bin/gcc-4.9'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"
    
    inreplace 'libc/Makefile' do |s|
      s.gsub! 'TOOLCHAIN_PREFIX=prizm-', 'TOOLCHAIN_PREFIX=sh3eb-elf-'
    end
    inreplace 'libfxcg/Makefile' do |s|
      s.gsub! 'TOOLCHAIN_PREFIX=prizm-', 'TOOLCHAIN_PREFIX=sh3eb-elf-'
    end
    inreplace 'toolchain/prizm_rules' do |s|
      s.gsub! 'PREFIX	:=	prizm-', 'PREFIX	:=	sh3eb-elf-'
    end
    FileUtils.rm('lib/.gitignore')

    FileUtils.cd('libfxcg') do
      system 'make'
    end

    FileUtils.cd('libc') do
      system 'make'
    end

    (prefix).install 'include'
    (prefix).install 'lib'
    (prefix).install 'toolchain'
    (prefix).install 'examples'
  end

 def caveats
    <<-EOS.undent
      libfxcg is installed to #{prefix} add the following path as FXCGSDK, e.g.
      \t export FXCGSDK=#{prefix}
      
      examples see: #{prefix/'examples'}
      
      start a new project with
      \t $ cp -R #{prefix/'examples'/'make-PrizmSDK'} PATH/project
      \t $ cd project
      \t $ make
      \t $ cp project.g3a /Volumes/FXCG_FLASH/
    EOS
    
  end

end
