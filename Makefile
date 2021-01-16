
PROGRAMS=intro
SOURCE=$(foreach p,$(PROGRAMS),$(p).cairo)
COMPILED=$(foreach p,$(PROGRAMS),$(p)_compiled.json)

all: $(COMPILED)

run_%: %_compiled.json
	cairo-run --program=$^ --print_output --layout=small

%_compiled.json: %.cairo
	cairo-compile $^ --output $@
