MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := build

.PHONY: build clean customize default dep install dep_xcode dep_homebrew dep_ansible list packages test update

build: dep

clean:
	brew cleanup &&\
	 brew prune &&\
	 sudo periodic daily weekly monthly &&\
	 sudo mdutil -E / &&\
	 sudo /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user

clean_docker:
	docker system prune -af

customize:
	ansible-playbook customize.yml

default: build

dep: dep_xcode dep_homebrew dep_homebrew_upgrade dep_ansible dep_roles

dep_homebrew_upgrade:
	brew upgrade

dep_ansible:
	brew install ansible -f

dep_homebrew:
	@/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

dep_roles:
	rm -rfv roles/* && ansible-galaxy install -r requirements.yml -p roles --force

dep_xcode:
	-xcode-select --install

packages:
	ansible-playbook packages.yml

test:
	brew doctor

update:
	ansible-playbook update.yml
