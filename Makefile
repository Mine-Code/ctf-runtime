rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

Dockerfile.marker: Dockerfile ctflib/libctf.a $(call rwildcard,ctflib/include,*) runtime.sh
	docker build -t minecode-ctf-runner .

	@[ ! -e Dockerfile.marker ] && { \
		touch Dockerfile.marker; \
		$(MAKE) -C ctflib clean all; \
	}

ctflib/libctf.a: $(call rwildcard,ctflib/include,*) $(call rwildcard,ctflib/src,*)
	@[ -e Dockerfile.marker ] \
		&& docker run -it --rm -e CHALLENGE=no -v $(CURDIR)/ctflib:/mnt minecode-ctf-runner "apt update; apt install make; make" \
		|| make -C ctflib