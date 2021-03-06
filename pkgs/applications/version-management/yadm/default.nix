{ stdenv, fetchurl, fetchFromGitHub }:

let version = "1.12.0"; in
stdenv.mkDerivation {
  name = "yadm-${version}";

  src = fetchFromGitHub {
    owner  = "TheLocehiliosan";
    repo   = "yadm";
    rev    = "${version}";
    sha256 = "0873jgks7dpfkj5km1jchxdrhf7lia70p0f8zsrh9p4crj5f4pc6";
  };

  buildCommand = ''
    mkdir -p $out/bin
    mkdir -p $out/share/man/man1
    sed -e 's:/bin/bash:/usr/bin/env bash:' $src/yadm > $out/bin/yadm
    chmod 755 $out/bin/yadm
    install -m 644 $src/yadm.1 $out/share/man/man1/yadm.1
  '';

  meta = {
    homepage = https://github.com/TheLocehiliosan/yadm;
    description = "Yet Another Dotfiles Manager";
    longDescription = ''
    yadm is a dotfile management tool with 3 main features: Manages files across
    systems using a single Git repository. Provides a way to use alternate files on
    a specific OS or host. Supplies a method of encrypting confidential data so it
    can safely be stored in your repository.
    '';
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.unix;
  };
}
