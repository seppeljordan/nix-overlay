PYPI2NIX=$(PWD)/pypi2nix-exec/bin/pypi2nix
export NIX_PATH := nixpkgs-overlays=$(shell pwd):$(NIX_PATH)

all: pypi2nix-exec/bin/pypi2nix update test

update: \
	update-pypiPackages3

clean:
	rm pypi2nix-exec

test: \
	test-python3-build \
	test-emacs \
	test-haskell-env \
	test-nix-prefetch-github \
	test-custom

test-python3-build:
	nix-build tests/test-python3-build.nix --show-trace -j 1

test-haskell-env:
	nix build -f tests/test-haskell-env.nix

test-emacs:
	nix build -f tests/test-emacs.nix

test-nix-prefetch-github:
	nix build -f tests/test-nix-prefetch-github.nix

update-pypiPackages3:
	rm -rf build/python3
	cd 10-python3Packages && $(PYPI2NIX) \
		-V python3 \
		-E "libsodium libffi libxml2 libxslt openssl" \
		-r python3.txt \
		--basename python3
test-custom:
	nix build -f tests/test-custom.nix


.PHONY: \
	clean \
	pypi2nix-exec/bin/pypi2nix \
	test \
	test-emacs \
	test-haskell-env \
	test-python3-build \
	update \
	update-pypiPackages3
