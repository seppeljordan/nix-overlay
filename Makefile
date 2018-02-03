PYPI2NIX=pypi2nix-exec/bin/pypi2nix
NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz:nixpkgs-overlays=$(shell pwd)

all: pypi2nix-exec update test

update: update-pypiPackages3 update-geimskell update-lrucache \
	update-htiled update-winetricks update-pypiPackages2 \
	update-node-packages

clean:
	rm pypi2nix-exec

test: \
	test-python2-build \
	test-python3-build \
	test-emacs \
	test-integration

test-integration:
	nix-build tests/test.nix

test-python2-build:
	nix-build tests/test-python2-build.nix

test-python3-build:
	nix-build tests/test-python3-build.nix

test-emacs:
	nix-build tests/test-emacs.nix

update-htiled:
	mkdir -p 90-custom/htiled
	cabal2nix https://github.com/seppeljordan/htiled.git \
		> 90-custom/htiled/default.nix

update-lrucache:
	mkdir -p 90-custom/lrucache
	cabal2nix https://github.com/seppeljordan/lrucache.git \
		> 90-custom/lrucache/default.nix

update-geimskell:
	cd 90-custom/geimskell && \
		cabal2nix "https://github.com/seppeljordan/geimskell.git" > default.nix

update-pypiPackages3:
	$(PYPI2NIX) \
		-v \
		-V 3 \
		-E "libffi openssl" \
		-r 10-python3Packages/python3.txt \
		--default-overrides \
		--basename 10-python3Packages/python3

update-pypiPackages2: pypi2nix-exec/bin/pypi2nix
	$(PYPI2NIX) \
		-v \
		-V 2.7 \
		-E "libffi openssl" \
		-r 10-python2Packages/python2.txt \
		--default-overrides \
		--basename 10-python2Packages/python2

update-winetricks:
	echo $(NIX_PATH)
	cd 90-custom/winetricks && \
		nix-shell '<nixpkgs>' -p pypiPackages3.interpreter \
		--command './update'

update-node-packages:
	cd 90-custom/node-packages && \
		node2nix -6 -i pkgs.json -o pkgs.nix

pypi2nix-exec/bin/pypi2nix:
	nix-build '<nixpkgs>' \
		-A pypiPackages3.packages.pypi2nix \
		-o pypi2nix-exec

.PHONY: update update-winetricks update-node-packages update-pypiPackages2 \
	update-pypiPackages3 test test-python2-build test-integration \
	test-python3-build pypi2nix-exec/bin/pypi2nix clean test-emacs
