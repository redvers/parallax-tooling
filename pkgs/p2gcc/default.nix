{ stdenv, fetchFromGitHub, propeller-gcc }:

  stdenv.mkDerivation rec {
    version = "2019-01-13r0";
    name = "p2gcc-${version}";

    buildInputs = [ propeller-gcc ];

    src = fetchFromGitHub {
      owner = "davehein";
      repo  = "p2gcc";
      rev   = "0dac45361ff1bd9a26998dd9afab4c68d2a62c1a";
      sha256 = "1843hza2x166jsl063s2addp3qn505cyh7g746n33dadh8ixkxng";
    };

  postUnpack = ''
    substituteInPlace $sourceRoot/p2gcc --replace '$P2GCC_LIBDIR' $out/lib
  '';

  buildPhase = ''
    chmod +x build_linux
    ./build_linux
    cd lib
    chmod +x buildlibs
    ./buildlibs
    cd ..
    '';

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/lib
      cp bin/* $out/bin/
      cp lib/* $out/lib/
    '';


  meta = with stdenv.lib; {
    description = "A toolset for making gcc great again (with the P2)";
    homepage = https://github.com/davehein/p2gcc;
    license = licenses.gpl3;
    maintainers = [ maintainers.redvers ];
    platforms = platforms.all;
  };
}
