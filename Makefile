PYPI2NIX=$(PWD)/pypi2nix-exec/bin/pypi2nix
NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.03.tar.gz:nixpkgs-overlays=$(shell pwd)

all: pypi2nix-exec/bin/pypi2nix update test

update: \
	update-geimskell \
	update-htiled \
	update-sdl2-compositor \
	update-lrucache \
	update-nixpkgs-python \
	update-node-packages \
	update-pypiPackages2 \
	update-pypiPackages3 \
	update-winetricks

update-nixpkgs-python:
	nix-prefetch-github garbas nixpkgs-python > 10-nixpkgs-python/nixpkgs-python.json

clean:
	rm pypi2nix-exec

test: \
	test-python2-build \
	test-python3-build \
	test-emacs \
	test-haskell-env \
	test-geimskell

test-geimskell:
	nix build -f tests/test-geimskell.nix

update-lrucache:
	mkdir -p 90-custom/lrucache
	cabal2nix cabal://lrucache \
		> 90-custom/lrucache/default.nix


test-python2-build:
	nix build -f tests/test-python2-build.nix

test-python3-build:
	nix build -f tests/test-python3-build.nix

test-haskell-env:
	nix build -f tests/test-haskell-env.nix

test-emacs:
	nix build -f tests/test-emacs.nix

update-htiled:
	mkdir -p 90-custom/htiled
	cabal2nix https://github.com/seppeljordan/htiled.git \
		> 90-custom/htiled/default.nix

update-geimskell:
	cd 90-custom/geimskell && \
		cabal2nix "https://github.com/seppeljordan/geimskell.git" > default.nix

update-sdl2-compositor:
	cd 90-custom/sdl2-compositor && \
		cabal2nix "https://github.com/seppeljordan/sdl2-compositor.git" > default.nix

update-pypiPackages3:
	cd 10-python3Packages && $(PYPI2NIX) \
		-V 3 \
		-v \
		-E "libffi openssl mercurial libxml2 libxslt pkgconfig dbus dbus-glib ncurses cairo gobjectIntrospection" \
		--setup-requires 'pycairo' \
		--setup-requires 'setuptools-scm' \
		-r python3.txt \
		--default-overrides \
		--basename python3

update-pypiPackages2:
	$(PYPI2NIX) \
		-v \
		-V 2.7 \
		-E "libffi openssl" \
		-r 10-python2Packages/python2.txt \
		--default-overrides \
		--basename 10-python2Packages/python2

update-winetricks:
	cd 90-custom/winetricks && \
		nix-prefetch-github Winetricks winetricks > source.json

update-node-packages:
	cd 90-custom/node-packages && \
		node2nix -6 -i pkgs.json -o pkgs.nix

# -A pypiPackages3.packages.pypi2nix
pypi2nix-exec/bin/pypi2nix:
	nix-build '<nixpkgs>' \
		-A pypiPackages.packages.pypi2nix \
		-o pypi2nix-exec --show-trace


.PHONY: \
	clean \
	pypi2nix-exec/bin/pypi2nix \
	test \
	test-emacs \
	test-geimskell \
	test-haskell-env \
	test-python2-build \
	test-python3-build \
	update \
	update-nixpkgs-python \
	update-node-packages \
	update-pypiPackages2 \
	update-pypiPackages3 \
	update-winetricks
