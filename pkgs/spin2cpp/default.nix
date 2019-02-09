{ stdenv, bison, fetchFromGitHub }:

  stdenv.mkDerivation rec {
    version = "2019-02-09r0";
    name = "spin2cpp-${version}";

    buildInputs = [ bison ];

    src = fetchFromGitHub {
      owner = "totalspectrum";
      repo  = "spin2cpp";
      rev   = "7b8129e79125cc9643c8484c9fea7c64a78da365";
      sha256 = "19wwnf7h20hv86vrsa7f9268n6s3jga5jbvwvf6r8i656gry67j6";
    };

  installPhase = ''
    mkdir -p $out/bin
    mv build/spin2cpp $out/bin/spin2cpp
    mv build/fastspin $out/bin/fastspin
    mv build/testlex $out/bin/testlex
  '';

  meta = with stdenv.lib; {
    description = "Convert Parallax Propeller Spin to PASM, C++, or C. Fastspin";
    homepage = https://github.com/totalspectrum/spin2cpp;
    license = licenses.gpl3;
    maintainers = [ maintainers.redvers ];
    platforms = platforms.all;
  };
}
