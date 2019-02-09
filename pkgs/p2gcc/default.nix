{ stdenv, fetchFromGitHub, propeller-gcc }:

  stdenv.mkDerivation rec {
    version = "2019-02-08r0";
    name = "p2gcc-${version}";

    buildInputs = [ propeller-gcc ];

    src = fetchFromGitHub {
      owner = "davehein";
      repo  = "p2gcc";
      rev   = "7e8bc6d2e80d7544d96efbd7341cc51853128326";
      sha256 = "1grvbbgqgsa5s2j5nl3mr9p435dz1wn2hyswfkg5dd1kxl07g2f8";
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
