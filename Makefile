version=$(shell jq -r .version <info.json)

mod_install_base=~/Library/Application\ Support/factorio/mods
mod_name=PEW-ARGH_${version}
mod_build=${mod_name}.zip
mod_install=${mod_install_base}/${mod_build}

sounds=$(shell find sounds -name *.ogg)

all: install

install: ${mod_install}

${mod_install}: ${mod_build}
	cp "$<" "$@"

${mod_build}: data.lua info.json ${sounds}
	git archive HEAD --prefix=${mod_name}/ --format=zip -o $@

run: install
	open -a Factorio
