version=$(shell jq -r .version <info.json)

mod_install_base=~/Library/Application\ Support/factorio/mods
mod_name=PEW-ARGH_${version}
mod_build=${mod_name}.zip
mod_install=${mod_install_base}/${mod_build}

sounds=$(shell find sounds -name \*.ogg)
lua=$(shell find . -name \*.lua)
locales=$(shell find . -name \*.cfg)

all: install

install: ${mod_install}

${mod_install}: ${mod_build}
	rm -f ${mod_install_base}/PEW-ARGH_*.zip
	cp "$<" "$@"

${mod_name}: info.json ${lua} ${sounds} ${locales}
	rm -rf $@
	mkdir -p $@
	rsync -R $^ $@

${mod_build}: ${mod_name}
	zip -r $@ $</

run: install
	open -a Factorio

clean:
	rm -rf ${mod_name} ${mod_build}
