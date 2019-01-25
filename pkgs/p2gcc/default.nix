{ stdenv, fetchFromGitHub, propeller-gcc }:

  stdenv.mkDerivation rec {
    version = "2019-01-23r1";
    name = "p2gcc-${version}";

    buildInputs = [ propeller-gcc ];

    src = fetchFromGitHub {
      owner = "davehein";
      repo  = "p2gcc";
      rev   = "fcfed297ab9f63c050ee2c436bb9b74abdb4f0d0";
      sha256 = "0y2hiijkbl8m2jipc02n61pfvvnlxvgdmclzf6pkrcqr3l7b9nql";
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
