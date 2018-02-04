# This file has been generated by node2nix 1.5.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "ansi-regex-2.1.1" = {
      name = "ansi-regex";
      packageName = "ansi-regex";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-2.1.1.tgz";
        sha1 = "c3b33ab5ee360d86e0e628f0468ae7ef27d654df";
      };
    };
    "argparse-1.0.9" = {
      name = "argparse";
      packageName = "argparse";
      version = "1.0.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/argparse/-/argparse-1.0.9.tgz";
        sha1 = "73d83bc263f86e97f8cc4f6bae1b0e90a7d22c86";
      };
    };
    "balanced-match-1.0.0" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha1 = "89b4d199ab2bee49de164ea02b89ce462d71b767";
      };
    };
    "bluebird-3.5.1" = {
      name = "bluebird";
      packageName = "bluebird";
      version = "3.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/bluebird/-/bluebird-3.5.1.tgz";
        sha512 = "2631bhp784qng0ifbypsmvijn6kjfvkhq2335kdz8ix5qi3wb3lbpg94xjn1av2s6i95ygr5a4y9j1721dw6zdbywwh1m48by4qpa1h";
      };
    };
    "bluebird-retry-0.5.3" = {
      name = "bluebird-retry";
      packageName = "bluebird-retry";
      version = "0.5.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/bluebird-retry/-/bluebird-retry-0.5.3.tgz";
        sha1 = "677d28cef9a90eaee911cf63fc7e883bafdf2c9c";
      };
    };
    "brace-expansion-1.1.8" = {
      name = "brace-expansion";
      packageName = "brace-expansion";
      version = "1.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.8.tgz";
        sha1 = "c07b211c7c952ec1f8efd51a77ef0d1d3990a292";
      };
    };
    "builtin-modules-1.1.1" = {
      name = "builtin-modules";
      packageName = "builtin-modules";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/builtin-modules/-/builtin-modules-1.1.1.tgz";
        sha1 = "270f076c5a72c02f5b65a47df94c5fe3a278892f";
      };
    };
    "camelcase-3.0.0" = {
      name = "camelcase";
      packageName = "camelcase";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/camelcase/-/camelcase-3.0.0.tgz";
        sha1 = "32fc4b9fcdaf845fcdf7e73bb97cac2261f0ab0a";
      };
    };
    "cli-table2-0.2.0" = {
      name = "cli-table2";
      packageName = "cli-table2";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-table2/-/cli-table2-0.2.0.tgz";
        sha1 = "2d1ef7f218a0e786e214540562d4bd177fe32d97";
      };
    };
    "cliui-3.2.0" = {
      name = "cliui";
      packageName = "cliui";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cliui/-/cliui-3.2.0.tgz";
        sha1 = "120601537a916d29940f934da3b48d585a39213d";
      };
    };
    "code-point-at-1.1.0" = {
      name = "code-point-at";
      packageName = "code-point-at";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/code-point-at/-/code-point-at-1.1.0.tgz";
        sha1 = "0d070b4d043a5bea33a2f1a40e2edb3d9a4ccf77";
      };
    };
    "colors-1.1.2" = {
      name = "colors";
      packageName = "colors";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/colors/-/colors-1.1.2.tgz";
        sha1 = "168a4701756b6a7f51a12ce0c97bfa28c084ed63";
      };
    };
    "concat-map-0.0.1" = {
      name = "concat-map";
      packageName = "concat-map";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha1 = "d8a96bd77fd68df7793a73036a3ba0d5405d477b";
      };
    };
    "decamelize-1.2.0" = {
      name = "decamelize";
      packageName = "decamelize";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/decamelize/-/decamelize-1.2.0.tgz";
        sha1 = "f6534d15148269b20352e7bee26f501f9a191290";
      };
    };
    "error-ex-1.3.1" = {
      name = "error-ex";
      packageName = "error-ex";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/error-ex/-/error-ex-1.3.1.tgz";
        sha1 = "f855a86ce61adc4e8621c3cda21e7a7612c3a8dc";
      };
    };
    "expand-tilde-1.2.2" = {
      name = "expand-tilde";
      packageName = "expand-tilde";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/expand-tilde/-/expand-tilde-1.2.2.tgz";
        sha1 = "0b81eba897e5a3d31d1c3d102f8f01441e559449";
      };
    };
    "find-up-1.1.2" = {
      name = "find-up";
      packageName = "find-up";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/find-up/-/find-up-1.1.2.tgz";
        sha1 = "6b2e9822b1a2ce0a60ab64d610eccad53cb24d0f";
      };
    };
    "fs.realpath-1.0.0" = {
      name = "fs.realpath";
      packageName = "fs.realpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha1 = "1504ad2523158caa40db4a2787cb01411994ea4f";
      };
    };
    "get-caller-file-1.0.2" = {
      name = "get-caller-file";
      packageName = "get-caller-file";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-caller-file/-/get-caller-file-1.0.2.tgz";
        sha1 = "f702e63127e7e231c160a80c1554acb70d5047e5";
      };
    };
    "glob-7.1.2" = {
      name = "glob";
      packageName = "glob";
      version = "7.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.2.tgz";
        sha512 = "08vjxzixc9dwc1hn5pd60yyij98krk2pr758aiga97r02ncvaqx1hidi95wk470k1v84gg4alls9bm52m77174z128bgf13b61x951h";
      };
    };
    "graceful-fs-4.1.11" = {
      name = "graceful-fs";
      packageName = "graceful-fs";
      version = "4.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.1.11.tgz";
        sha1 = "0e8bdfe4d1ddb8854d64e04ea7c00e2a026e5658";
      };
    };
    "hoek-3.0.4" = {
      name = "hoek";
      packageName = "hoek";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/hoek/-/hoek-3.0.4.tgz";
        sha1 = "268adff66bb6695c69b4789a88b1e0847c3f3123";
      };
    };
    "hosted-git-info-2.5.0" = {
      name = "hosted-git-info";
      packageName = "hosted-git-info";
      version = "2.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/hosted-git-info/-/hosted-git-info-2.5.0.tgz";
        sha512 = "355g980qsk8k9hkv60z58llbvpscjl5yqkh4wx719s8jcq2swzn4ynzinj8azmvdgs10r22wb297rmixh9vvsml55sbysdf2i8ipn54";
      };
    };
    "inflight-1.0.6" = {
      name = "inflight";
      packageName = "inflight";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha1 = "49bd6331d7d02d0c09bc910a1075ba8165b56df9";
      };
    };
    "inherits-2.0.3" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.3.tgz";
        sha1 = "633c2c83e3da42a502f52466022480f4208261de";
      };
    };
    "invert-kv-1.0.0" = {
      name = "invert-kv";
      packageName = "invert-kv";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/invert-kv/-/invert-kv-1.0.0.tgz";
        sha1 = "104a8e4aaca6d3d8cd157a8ef8bfab2d7a3ffdb6";
      };
    };
    "is-arrayish-0.2.1" = {
      name = "is-arrayish";
      packageName = "is-arrayish";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-arrayish/-/is-arrayish-0.2.1.tgz";
        sha1 = "77c99840527aa8ecb1a8ba697b80645a7a926a9d";
      };
    };
    "is-builtin-module-1.0.0" = {
      name = "is-builtin-module";
      packageName = "is-builtin-module";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-builtin-module/-/is-builtin-module-1.0.0.tgz";
        sha1 = "540572d34f7ac3119f8f76c30cbc1b1e037affbe";
      };
    };
    "is-fullwidth-code-point-1.0.0" = {
      name = "is-fullwidth-code-point";
      packageName = "is-fullwidth-code-point";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-1.0.0.tgz";
        sha1 = "ef9e31386f031a7f0d643af82fde50c457ef00cb";
      };
    };
    "is-utf8-0.2.1" = {
      name = "is-utf8";
      packageName = "is-utf8";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-utf8/-/is-utf8-0.2.1.tgz";
        sha1 = "4b0da1442104d1b336340e80797e865cf39f7d72";
      };
    };
    "lcid-1.0.0" = {
      name = "lcid";
      packageName = "lcid";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lcid/-/lcid-1.0.0.tgz";
        sha1 = "308accafa0bc483a3867b4b6f2b9506251d1b835";
      };
    };
    "load-json-file-1.1.0" = {
      name = "load-json-file";
      packageName = "load-json-file";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/load-json-file/-/load-json-file-1.1.0.tgz";
        sha1 = "956905708d58b4bab4c2261b04f59f31c99374c0";
      };
    };
    "lodash-3.10.1" = {
      name = "lodash";
      packageName = "lodash";
      version = "3.10.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash/-/lodash-3.10.1.tgz";
        sha1 = "5bf45e8e49ba4189e17d482789dfd15bd140b7b6";
      };
    };
    "lodash-4.17.5" = {
      name = "lodash";
      packageName = "lodash";
      version = "4.17.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash/-/lodash-4.17.5.tgz";
        sha512 = "11hikgyas884mz8a58vyixaahxbpdwljdw4cb6qp15xa3sfqikp2mm6wgv41jsl34nzsv1hkx9kw3nwczvas5p73whirmaz4sxggwmj";
      };
    };
    "lodash.assign-4.2.0" = {
      name = "lodash.assign";
      packageName = "lodash.assign";
      version = "4.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.assign/-/lodash.assign-4.2.0.tgz";
        sha1 = "0d99f3ccd7a6d261d19bdaeb9245005d285808e7";
      };
    };
    "minimatch-3.0.4" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha512 = "1879a3j85h92ypvb7lpv1dqpcxl49rqnbgs5la18zmj1yqhwl60c2m74254wbr5pp3znckqpkg9dvjyrz6hfz8b9vag5a3j910db4f8";
      };
    };
    "normalize-package-data-2.4.0" = {
      name = "normalize-package-data";
      packageName = "normalize-package-data";
      version = "2.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-package-data/-/normalize-package-data-2.4.0.tgz";
        sha512 = "01wzws79ps84ylshjb7rfpjykgiqxnpr89s52p2yyzfx8nfvyh5flvf1almiiavsi75xgi8g3s5davc1mmgz7gn8yvlqz6gnhax8f7n";
      };
    };
    "number-is-nan-1.0.1" = {
      name = "number-is-nan";
      packageName = "number-is-nan";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/number-is-nan/-/number-is-nan-1.0.1.tgz";
        sha1 = "097b602b53422a522c1afb8790318336941a011d";
      };
    };
    "once-1.4.0" = {
      name = "once";
      packageName = "once";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha1 = "583b1aa775961d4b113ac17d9c50baef9dd76bd1";
      };
    };
    "os-homedir-1.0.2" = {
      name = "os-homedir";
      packageName = "os-homedir";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/os-homedir/-/os-homedir-1.0.2.tgz";
        sha1 = "ffbc4988336e0e833de0c168c7ef152121aa7fb3";
      };
    };
    "os-locale-1.4.0" = {
      name = "os-locale";
      packageName = "os-locale";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/os-locale/-/os-locale-1.4.0.tgz";
        sha1 = "20f9f17ae29ed345e8bde583b13d2009803c14d9";
      };
    };
    "os-tmpdir-1.0.2" = {
      name = "os-tmpdir";
      packageName = "os-tmpdir";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/os-tmpdir/-/os-tmpdir-1.0.2.tgz";
        sha1 = "bbe67406c79aa85c5cfec766fe5734555dfa1274";
      };
    };
    "parse-json-2.2.0" = {
      name = "parse-json";
      packageName = "parse-json";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/parse-json/-/parse-json-2.2.0.tgz";
        sha1 = "f480f40434ef80741f8469099f8dea18f55a4dc9";
      };
    };
    "path-exists-2.1.0" = {
      name = "path-exists";
      packageName = "path-exists";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-exists/-/path-exists-2.1.0.tgz";
        sha1 = "0feb6c64f0fc518d9a754dd5efb62c7022761f4b";
      };
    };
    "path-is-absolute-1.0.1" = {
      name = "path-is-absolute";
      packageName = "path-is-absolute";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha1 = "174b9268735534ffbc7ace6bf53a5a9e1b5c5f5f";
      };
    };
    "path-type-1.1.0" = {
      name = "path-type";
      packageName = "path-type";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-type/-/path-type-1.1.0.tgz";
        sha1 = "59c44f7ee491da704da415da5a4070ba4f8fe441";
      };
    };
    "pify-2.3.0" = {
      name = "pify";
      packageName = "pify";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pify/-/pify-2.3.0.tgz";
        sha1 = "ed141a6ac043a849ea588498e7dca8b15330e90c";
      };
    };
    "pinkie-2.0.4" = {
      name = "pinkie";
      packageName = "pinkie";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pinkie/-/pinkie-2.0.4.tgz";
        sha1 = "72556b80cfa0d48a974e80e77248e80ed4f7f870";
      };
    };
    "pinkie-promise-2.0.1" = {
      name = "pinkie-promise";
      packageName = "pinkie-promise";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pinkie-promise/-/pinkie-promise-2.0.1.tgz";
        sha1 = "2135d6dfa7a358c069ac9b178776288228450ffa";
      };
    };
    "read-pkg-1.1.0" = {
      name = "read-pkg";
      packageName = "read-pkg";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/read-pkg/-/read-pkg-1.1.0.tgz";
        sha1 = "f5ffaa5ecd29cb31c0474bca7d756b6bb29e3f28";
      };
    };
    "read-pkg-up-1.0.1" = {
      name = "read-pkg-up";
      packageName = "read-pkg-up";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/read-pkg-up/-/read-pkg-up-1.0.1.tgz";
        sha1 = "9d63c13276c065918d57f002a57f40a1b643fb02";
      };
    };
    "require-directory-2.1.1" = {
      name = "require-directory";
      packageName = "require-directory";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/require-directory/-/require-directory-2.1.1.tgz";
        sha1 = "8c64ad5fd30dab1c976e2344ffe7f792a6a6df42";
      };
    };
    "require-main-filename-1.0.1" = {
      name = "require-main-filename";
      packageName = "require-main-filename";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/require-main-filename/-/require-main-filename-1.0.1.tgz";
        sha1 = "97f717b69d48784f5f526a6c5aa8ffdda055a4d1";
      };
    };
    "semver-5.5.0" = {
      name = "semver";
      packageName = "semver";
      version = "5.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-5.5.0.tgz";
        sha512 = "0h32zh035y8m6dzcqhcymbhwgmc8839fa1hhj0jfh9ivp9kmqfj1sbwnsnkzcn9qm3sqn38sa8ys2g4c638lpnmzjr0a0qndmv7f8p1";
      };
    };
    "set-blocking-2.0.0" = {
      name = "set-blocking";
      packageName = "set-blocking";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/set-blocking/-/set-blocking-2.0.0.tgz";
        sha1 = "045f9782d011ae9a6803ddd382b24392b3d890f7";
      };
    };
    "spdx-correct-1.0.2" = {
      name = "spdx-correct";
      packageName = "spdx-correct";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-correct/-/spdx-correct-1.0.2.tgz";
        sha1 = "4b3073d933ff51f3912f03ac5519498a4150db40";
      };
    };
    "spdx-expression-parse-1.0.4" = {
      name = "spdx-expression-parse";
      packageName = "spdx-expression-parse";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-expression-parse/-/spdx-expression-parse-1.0.4.tgz";
        sha1 = "9bdf2f20e1f40ed447fbe273266191fced51626c";
      };
    };
    "spdx-license-ids-1.2.2" = {
      name = "spdx-license-ids";
      packageName = "spdx-license-ids";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-license-ids/-/spdx-license-ids-1.2.2.tgz";
        sha1 = "c9df7a3424594ade6bd11900d596696dc06bac57";
      };
    };
    "sprintf-js-1.0.3" = {
      name = "sprintf-js";
      packageName = "sprintf-js";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/sprintf-js/-/sprintf-js-1.0.3.tgz";
        sha1 = "04e6926f662895354f3dd015203633b857297e2c";
      };
    };
    "string-width-1.0.2" = {
      name = "string-width";
      packageName = "string-width";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/string-width/-/string-width-1.0.2.tgz";
        sha1 = "118bdf5b8cdc51a2a7e70d211e07e2b0b9b107d3";
      };
    };
    "strip-ansi-3.0.1" = {
      name = "strip-ansi";
      packageName = "strip-ansi";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-3.0.1.tgz";
        sha1 = "6a385fb8853d952d5ff05d0e8aaf94278dc63dcf";
      };
    };
    "strip-bom-2.0.0" = {
      name = "strip-bom";
      packageName = "strip-bom";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-bom/-/strip-bom-2.0.0.tgz";
        sha1 = "6219a85616520491f35788bdbf1447a99c7e6b0e";
      };
    };
    "tmp-0.0.30" = {
      name = "tmp";
      packageName = "tmp";
      version = "0.0.30";
      src = fetchurl {
        url = "https://registry.npmjs.org/tmp/-/tmp-0.0.30.tgz";
        sha1 = "72419d4a8be7d6ce75148fd8b324e593a711c2ed";
      };
    };
    "validate-npm-package-license-3.0.1" = {
      name = "validate-npm-package-license";
      packageName = "validate-npm-package-license";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/validate-npm-package-license/-/validate-npm-package-license-3.0.1.tgz";
        sha1 = "2804babe712ad3379459acfbe24746ab2c303fbc";
      };
    };
    "which-module-1.0.0" = {
      name = "which-module";
      packageName = "which-module";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/which-module/-/which-module-1.0.0.tgz";
        sha1 = "bba63ca861948994ff307736089e3b96026c2a4f";
      };
    };
    "window-size-0.2.0" = {
      name = "window-size";
      packageName = "window-size";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/window-size/-/window-size-0.2.0.tgz";
        sha1 = "b4315bb4214a3d7058ebeee892e13fa24d98b075";
      };
    };
    "wrap-ansi-2.1.0" = {
      name = "wrap-ansi";
      packageName = "wrap-ansi";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-2.1.0.tgz";
        sha1 = "d8fc3d284dd05794fe84973caecdd1cf824fdd85";
      };
    };
    "wrappy-1.0.2" = {
      name = "wrappy";
      packageName = "wrappy";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha1 = "b5243d8f3ec1aa35f1364605bc0d1036e30ab69f";
      };
    };
    "y18n-3.2.1" = {
      name = "y18n";
      packageName = "y18n";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/y18n/-/y18n-3.2.1.tgz";
        sha1 = "6d15fba884c08679c0d77e88e7759e811e07fa41";
      };
    };
    "yamljs-0.2.10" = {
      name = "yamljs";
      packageName = "yamljs";
      version = "0.2.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/yamljs/-/yamljs-0.2.10.tgz";
        sha1 = "481cc7c25ca73af59f591f0c96e3ce56c757a40f";
      };
    };
    "yargs-4.8.1" = {
      name = "yargs";
      packageName = "yargs";
      version = "4.8.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs/-/yargs-4.8.1.tgz";
        sha1 = "c0c42924ca4aaa6b0e6da1739dfb216439f9ddc0";
      };
    };
    "yargs-parser-2.4.1" = {
      name = "yargs-parser";
      packageName = "yargs-parser";
      version = "2.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs-parser/-/yargs-parser-2.4.1.tgz";
        sha1 = "85568de3cf150ff49fa51825f03a8c880ddcc5c4";
      };
    };
  };
in
{
  "nix-kubernetes-git+https://github.com/seppeljordan/nix-kubernetes.git" = nodeEnv.buildNodePackage {
    name = "nix-kubernetes";
    packageName = "nix-kubernetes";
    version = "0.25.0";
    src = fetchgit {
      url = "https://github.com/seppeljordan/nix-kubernetes.git";
      rev = "91db3132e134c7b2e34fa9d86ac89dccdc876126";
      sha256 = "bd77884e39de689cb95d89840fcb351c60e630a8791d93bf0afe32396f50c4ec";
    };
    dependencies = [
      sources."ansi-regex-2.1.1"
      sources."argparse-1.0.9"
      sources."balanced-match-1.0.0"
      sources."bluebird-3.5.1"
      sources."bluebird-retry-0.5.3"
      sources."brace-expansion-1.1.8"
      sources."builtin-modules-1.1.1"
      sources."camelcase-3.0.0"
      (sources."cli-table2-0.2.0" // {
        dependencies = [
          sources."lodash-3.10.1"
        ];
      })
      sources."cliui-3.2.0"
      sources."code-point-at-1.1.0"
      sources."colors-1.1.2"
      sources."concat-map-0.0.1"
      sources."decamelize-1.2.0"
      sources."error-ex-1.3.1"
      sources."expand-tilde-1.2.2"
      sources."find-up-1.1.2"
      sources."fs.realpath-1.0.0"
      sources."get-caller-file-1.0.2"
      sources."glob-7.1.2"
      sources."graceful-fs-4.1.11"
      sources."hoek-3.0.4"
      sources."hosted-git-info-2.5.0"
      sources."inflight-1.0.6"
      sources."inherits-2.0.3"
      sources."invert-kv-1.0.0"
      sources."is-arrayish-0.2.1"
      sources."is-builtin-module-1.0.0"
      sources."is-fullwidth-code-point-1.0.0"
      sources."is-utf8-0.2.1"
      sources."lcid-1.0.0"
      sources."load-json-file-1.1.0"
      sources."lodash-4.17.5"
      sources."lodash.assign-4.2.0"
      sources."minimatch-3.0.4"
      sources."normalize-package-data-2.4.0"
      sources."number-is-nan-1.0.1"
      sources."once-1.4.0"
      sources."os-homedir-1.0.2"
      sources."os-locale-1.4.0"
      sources."os-tmpdir-1.0.2"
      sources."parse-json-2.2.0"
      sources."path-exists-2.1.0"
      sources."path-is-absolute-1.0.1"
      sources."path-type-1.1.0"
      sources."pify-2.3.0"
      sources."pinkie-2.0.4"
      sources."pinkie-promise-2.0.1"
      sources."read-pkg-1.1.0"
      sources."read-pkg-up-1.0.1"
      sources."require-directory-2.1.1"
      sources."require-main-filename-1.0.1"
      sources."semver-5.5.0"
      sources."set-blocking-2.0.0"
      sources."spdx-correct-1.0.2"
      sources."spdx-expression-parse-1.0.4"
      sources."spdx-license-ids-1.2.2"
      sources."sprintf-js-1.0.3"
      sources."string-width-1.0.2"
      sources."strip-ansi-3.0.1"
      sources."strip-bom-2.0.0"
      sources."tmp-0.0.30"
      sources."validate-npm-package-license-3.0.1"
      sources."which-module-1.0.0"
      sources."window-size-0.2.0"
      sources."wrap-ansi-2.1.0"
      sources."wrappy-1.0.2"
      sources."y18n-3.2.1"
      sources."yamljs-0.2.10"
      sources."yargs-4.8.1"
      sources."yargs-parser-2.4.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Kubernetes deployment manager written in nix";
      homepage = https://github.com/x-truder/nix-kubernetes;
      license = "MIT";
    };
    production = true;
    bypassCache = false;
  };
}