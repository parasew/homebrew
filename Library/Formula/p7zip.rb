class P7zip < Formula
  homepage "http://p7zip.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/p7zip/p7zip/9.38.1/p7zip_9.38.1_src_all.tar.bz2"
  sha1 "6b1eccf272d8b141a94758f80727ae633568ba69"

  option "32-bit"

  def install
    if Hardware.is_32_bit? or build.build_32_bit?
      mv "makefile.macosx_32bits", "makefile.machine"
    else
      mv "makefile.macosx_64bits", "makefile.machine"
    end

    # install.sh chmods to 444, which is bad and breaks uninstalling
    inreplace "install.sh", /chmod (444|555).*/, ""

    system "make", "all3",
                   "CC=#{ENV.cc} $(ALLFLAGS)",
                   "CXX=#{ENV.cxx} $(ALLFLAGS)"
    system "make", "DEST_HOME=#{prefix}",
                   "DEST_MAN=#{man}",
                   "install"
  end
end
