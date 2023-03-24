SOURCE_FILES := $(wildcard src/*.c src/*.cpp)

CFLAGS := -c -I include
CXXFLAGS := $(CFLAGS)

.PHONY: all
all: libctf.a

.PHONY: clean
clean:
	@rm -rd build/*.o libctf.a || true

build:
	@mkdir -p build

build/%.o: build src/%.c
	@printf "> \x1b[32mBuilding $@ with Stack=NonExec|Protected \x1b[0m\n"
	gcc $(CFLAGS) -o $@ $(filter-out build, $^)

build/%.o: build src/%.cpp
	@printf "> \x1b[32mBuilding $@ with Stack=NonExec|Protected \x1b[0m\n"
	g++ $(CXXFLAGS) -o $@ $(filter-out build, $^)

libctf.a: $(patsubst src/%,build/%.o,$(basename $(SOURCE_FILES)))
	@printf "> \x1b[32mCreating $@ file with $^ \x1b[0m\n"
	ar rcs $@ $^