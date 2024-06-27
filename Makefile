
all: 

########################################################
# sub-repos

REPOS=cbm-benchmarks

# downloads all the repos it depends on
clone: $(REPOS)

# update cloned repos
update: $(REPOS)
	git pull
	for i in $(REPOS); do (cd $$i; git pull); done

########################################################

cbm-benchmarks:
	git clone https://github.com/fachat/cbm-benchmarks.git

