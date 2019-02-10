{ stdenv, fetchFromGitHub }:

  stdenv.mkDerivation rec {
    version = "2018-12-06r1";
    name = "spinsim-${version}";
    OPT="-Wno-implicit-fallthrough -Wno-format-security";

    buildInputs = [ ];

    src = fetchFromGitHub {
      owner = "parallaxinc";
      repo  = "spinsim";
      rev   = "bb903fc36f7e6762e56c4b39bdb888c895322a02";
      sha256 = "1lnvz914q51jjich4nvwnh3y173plg4ikgkv4b5b442pabghb8fx";
    };

  postUnpack = ''
    substituteInPlace $sourceRoot/Makefile --replace 'Wno-format' 'Wno-format -Wno-format-security'
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv build/spinsim $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "A simulator for the Parallax Propeller (P1 & P2), master branch";
    homepage = https://github.com/parallaxinc/spinsim;
    license = licenses.gpl3;
    maintainers = [ maintainers.redvers ];
    platforms = platforms.all;
  };
}
