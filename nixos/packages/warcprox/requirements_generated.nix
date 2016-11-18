# generated using pypi2nix tool (version: 1.6.0)
#
# COMMAND:
#   pypi2nix -V 3.4 -e warcprox -E libffi -E openssl -E gdbm -E git
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "certauth" = python.mkDerivation {
    name = "certauth-1.1.3";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/f9/20/3b34db694bb8e89e763dd42c5bbc89db29634e24cb4c880a4d7c9863dd1a/certauth-1.1.3.tar.gz";
      sha256 = "64a2cd09870377dd2601353969617ebb424d94a8ab21d5ccdb93b9bf41cf3578";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."pyOpenSSL"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Simple Certificate Authority for MITM proxies";
    };
  };



  "cffi" = python.mkDerivation {
    name = "cffi-1.9.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/a1/32/e3d6c3a8b5461b903651dd6ce958ed03c093d2e00128e3f33ea69f1d7965/cffi-1.9.1.tar.gz";
      sha256 = "563e0bd53fda03c151573217b3a49b3abad8813de9dd0632e10090f6190fdaf8";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."pycparser"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Foreign Function Interface for Python calling C code.";
    };
  };



  "cryptography" = python.mkDerivation {
    name = "cryptography-1.5.3";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/6c/c5/7fc1f8384443abd2d71631ead026eb59863a58cad0149b94b89f08c8002f/cryptography-1.5.3.tar.gz";
      sha256 = "cf82ddac919b587f5e44247579b433224cc2e03332d2ea4d89aa70d7e6b64ae5";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."cffi"
      self."idna"
      self."pyasn1"
      self."six"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
    };
  };



  "idna" = python.mkDerivation {
    name = "idna-2.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/fb/84/8c27516fbaa8147acd2e431086b473c453c428e24e8fb99a1d89ce381851/idna-2.1.tar.gz";
      sha256 = "ed36f281aebf3cd0797f163bb165d84c31507cedd15928b095b1675e2d04c676";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Internationalized Domain Names in Applications (IDNA)";
    };
  };



  "pyOpenSSL" = python.mkDerivation {
    name = "pyOpenSSL-16.2.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/0c/d6/b1fe519846a21614fa4f8233361574eddb223e0bc36b182140d916acfb3b/pyOpenSSL-16.2.0.tar.gz";
      sha256 = "7779a3bbb74e79db234af6a08775568c6769b5821faecf6e2f4143edb227516e";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."cryptography"
      self."six"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.asl20;
      description = "Python wrapper module around the OpenSSL library";
    };
  };



  "pyasn1" = python.mkDerivation {
    name = "pyasn1-0.1.9";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/f7/83/377e3dd2e95f9020dbd0dfd3c47aaa7deebe3c68d3857a4e51917146ae8b/pyasn1-0.1.9.tar.gz";
      sha256 = "853cacd96d1f701ddd67aa03ecc05f51890135b7262e922710112f12a2ed2a7f";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "ASN.1 types and codecs";
    };
  };



  "pycparser" = python.mkDerivation {
    name = "pycparser-2.17";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/be/64/1bb257ffb17d01f4a38d7ce686809a736837ad4371bcc5c42ba7a715c3ac/pycparser-2.17.tar.gz";
      sha256 = "0aac31e917c24cb3357f5a4d5566f2cc91a19ca41862f6c3c22dc60a629673b6";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "C parser in Python";
    };
  };



  "six" = python.mkDerivation {
    name = "six-1.10.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz";
      sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Python 2 and 3 compatibility utilities";
    };
  };



  "warcprox" = python.mkDerivation {
    name = "warcprox-1.4";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/08/77/8edbcd19009a0f3699442c0fbb792928b9d2dbf17f8a959a12f58b8155b3/warcprox-1.4.tar.gz";
      sha256 = "39a50e9ad06f0250b1e4b0821840072d49c8077734a6293a5ad804b36c76c5c7";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."certauth"
      self."warctools"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.gpl1;
      description = "WARC writing MITM HTTP/S proxy";
    };
  };



  "warctools" = python.mkDerivation {
    name = "warctools-4.10.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/e6/5b/17eacaa14dde83dbecb62be44c21c5e9b8f2c709c1da5846e361c3033f3b/warctools-4.10.0.tar.gz";
      sha256 = "ce0c6e274db8ac8810f7c97b3943e8e8deadbc3f5c982db77cddaae2d2ae6170";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Command line tools and libraries for handling and manipulating WARC files (and HTTP contents)";
    };
  };

}