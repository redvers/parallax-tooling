{ stdenv, bison, fetchFromGitHub }:

  stdenv.mkDerivation rec {
    version = "2018-11-03";
    name = "spin2cpp-${version}";

    buildInputs = [ bison ];

    src = fetchFromGitHub {
      owner = "totalspectrum";
      repo  = "spin2cpp";
      rev   = "dd26af74a3e470115f6f608144aeec9f5da6e4be";
      sha256 = "05qwl9y9r13rz2bma9qq1ixhsjwgfrfs7abh6b96aw5ynwk0xfxw";
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
