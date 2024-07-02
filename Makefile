
BASE=$(shell git remote -v | cut -f 2- | sed -e "s%fachat/.*%fachat%g" | uniq )

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
	git clone $(BASE)/cbm-benchmarks.git

