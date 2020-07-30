version=$(shell jq -r .version <src/info.json)

mod_install_base=~/Library/Application\ Support/factorio/mods
mod_name=PEW-PEW_${version}
mod_build=${mod_name}.zip
mod_install=${mod_install_base}/${mod_build}

sounds=$(shell find src/sounds -name \*.ogg)
lua=$(shell find src -name \*.lua)
locales=$(shell find src/locale -name \*.cfg)

all: install

install: ${mod_install}

${mod_install}: ${mod_build}
	rm -f ${mod_install_base}/PEW-PEW_*.zip
	cp "$<" "$@"

${mod_name}: src/info.json ${lua} ${sounds} ${locales}
	rm -rf $@
	mkdir -p $@
	cp -r src/ $@
	cp thumbnail.png $@
	cp changelog.txt $@

${mod_build}: ${mod_name}
	zip -r $@ $</

run: install
	open -a Factorio

clean:
	rm -rf ${mod_name} *.zip
