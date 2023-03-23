rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

Dockerfile.marker: Dockerfile ctflib/libctf.a $(call rwildcard,ctflib/include,*) runtime.sh
	docker build -t minecode-ctf-runner .

	touch Dockerfile.marker

ctflib/libctf.a: $(call rwildcard,ctflib/include,*) $(call rwildcard,ctflib/src,*)
#	make -C ctflib
	@docker run -it --rm -e CHALLENGE=no -v $(CURDIR)/ctflib:/mnt minecode-ctf-runner "apt update; apt install make; make"