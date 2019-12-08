PYPI2NIX=$(PWD)/pypi2nix-exec/bin/pypi2nix
export NIX_PATH := nixpkgs-overlays=$(shell pwd):$(NIX_PATH)

all: pypi2nix-exec/bin/pypi2nix update test

update: \
	update-geimskell \
	update-htiled \
	update-sdl2-compositor \
	update-lrucache \
	update-nixpkgs-python \
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
	test-geimskell \
	test-nix-prefetch-github \
	test-custom

test-geimskell:
	nix build -f tests/test-geimskell.nix

update-lrucache:
	mkdir -p 90-custom/lrucache
	cabal2nix cabal://lrucache \
		> 90-custom/lrucache/default.nix


test-python2-build:
	nix build -f tests/test-python2-build.nix

test-python3-build:
	nix-build tests/test-python3-build.nix --show-trace -j 1

test-haskell-env:
	nix build -f tests/test-haskell-env.nix

test-emacs:
	nix build -f tests/test-emacs.nix

test-nix-prefetch-github:
	nix build -f tests/test-nix-prefetch-github.nix

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
	rm -rf build/python3
	cd 10-python3Packages && $(PYPI2NIX) \
		-V python3 \
		-E "libsodium libffi libxml2 libxslt openssl" \
		-r python3.txt \
		--basename python3

update-pypiPackages2:
	$(PYPI2NIX) \
		-V python27 \
		-E "libffi openssl" \
		-r 10-python2Packages/python2.txt \
		--default-overrides \
		--basename 10-python2Packages/python2

update-winetricks:
	cd 90-custom/winetricks && \
		nix-prefetch-github Winetricks winetricks > source.json

# '<nixpkgs>' -A pypiPackages.packages.pypi2nix
pypi2nix-exec/bin/pypi2nix:
	nix-build \
		https://github.com/nix-community/pypi2nix/archive/master.tar.gz \
		-o pypi2nix-exec --show-trace

test-custom:
	nix build -f tests/test-custom.nix


.PHONY: \
	clean \
	pypi2nix-exec/bin/pypi2nix \
	test \
	test-emacs \
	test-geimskell \
	test-haskell-env \
	test-python2-build \
	test-python3-build \
	test-nix-kubernetes \
	update \
	update-nixpkgs-python \
	update-pypiPackages2 \
	update-pypiPackages3 \
	update-winetricks
