{ stdenv, fetchFromGitHub }:

  stdenv.mkDerivation rec {
    version = "2018-06-19";
    name = "spinsim-${version}";
    OPT="-Wno-implicit-fallthrough -Wno-format-security";

    buildInputs = [ ];

    src = fetchFromGitHub {
      owner = "parallaxinc";
      repo  = "spinsim";
      rev   = "12851674614357919af154bf110846d9eb25b5c5";
      sha256 = "0pj6rd0brx9brgncb78nihr2bvg9fd5likwh6g0c53179ag8vx8a";
    };

  postUnpack = ''
    substituteInPlace $sourceRoot/Makefile --replace 'Wno-format' 'Wno-format -Wno-format-security'
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv build/spinsim $out/bin/spinsim
  '';

  meta = with stdenv.lib; {
    description = "A simulator for the Parallax Propeller (P1 & P2)";
    homepage = https://github.com/parallaxinc/spinsim;
    license = licenses.gpl3;
    maintainers = [ maintainers.redvers ];
    platforms = platforms.all;
  };
}
