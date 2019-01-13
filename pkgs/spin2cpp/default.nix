{ stdenv, bison, fetchFromGitHub }:

  stdenv.mkDerivation rec {
    version = "2018-11-03r0";
    name = "spin2cpp-${version}";

    buildInputs = [ bison ];

    src = fetchFromGitHub {
      owner = "totalspectrum";
      repo  = "spin2cpp";
      rev   = "b0762a810c46c08a1ffe06a9817c29cdd0e9834b";
      sha256 = "1i2jznqharj9azsh6ww3d02k9rrh04amfjr1frm9j91q901fgkx8";
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
