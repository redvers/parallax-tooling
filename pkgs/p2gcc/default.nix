{ stdenv, fetchFromGitHub, propeller-gcc }:

  stdenv.mkDerivation rec {
    version = "2019-01-12r0";
    name = "p2gcc-${version}";

    buildInputs = [ propeller-gcc ];

    src = fetchFromGitHub {
      owner = "davehein";
      repo  = "p2gcc";
      rev   = "2d7fcd554bbb700bfd8fd49ade01b5b386c44f9f";
      sha256 = "10ind8d6v7islyfjng9wjy0vmk9lbqp70jca8lq6s4c96b3smbcn";
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
