{ stdenv, fetchFromGitHub, propeller-gcc }:

  stdenv.mkDerivation rec {
    version = "2019-01-09";
    name = "p2gcc-${version}";

    buildInputs = [ propeller-gcc ];

    src = fetchFromGitHub {
      owner = "davehein";
      repo  = "p2gcc";
      rev   = "563e271445819b72df44a9376d37223bdc31a721";
      sha256 = "1rqnhm38238rjn17m6vir4cyza03a0ldgxnb1l0c632rf4k2g0jf";
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
