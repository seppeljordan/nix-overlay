# This file has been generated by node2nix 1.5.2. Do not edit!

{pkgs ? import <nixpkgs> {
    inherit system;
  }, system ? builtins.currentSystem, nodejs ? pkgs."nodejs-6_x"}:

let
  nodeEnv = import ./node-env.nix {
    inherit (pkgs) stdenv python2 utillinux runCommand writeTextFile;
    inherit nodejs;
  };
in
import ./pkgs.nix {
  inherit (pkgs) fetchurl fetchgit;
  inherit nodeEnv;
}