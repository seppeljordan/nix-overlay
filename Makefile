PYPI2NIX=pypi2nix # ~/src/pypi2nix/examples/pypi2nix/bin/pypi2nix

update: update-pypiPackages3 update-geimskell update-lrucache \
	update-htiled update-winetricks update-pypiPackages2 \
	update-node-packages

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
	cd 10-python3Packages && $(PYPI2NIX) \
		-v \
		-V 3 \
		-E "libffi openssl" \
		-r python3.txt \
		--default-overrides \
		--basename python3

update-pypiPackages2:
	cd 10-python2Packages && $(PYPI2NIX) \
		-v \
		-V 2.7 \
		-E "libffi openssl" \
		-r python2.txt \
		--default-overrides \
		--basename python2
update-nixpkgs-python:
	cd 00-nixpkgs-python && ./update.sh

update-winetricks:
	cd 90-custom/winetricks && \
		nix-shell -p pypiPackages.interpreter \
		--command './update'

update-node-packages:
	cd 90-custom/node-packages && \
		node2nix -6 -i pkgs.json -o pkgs.nix

.PHONY: update update-winetricks update-node-packages update-pypiPackages2 \
	update-pypiPackages3
