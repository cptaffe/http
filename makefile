SRC = http.cc
HDR = http.h

OBJ := $(SRC:.cc=.o)
LIB = libhttp.o

LIBS=
CXXFLAGS+=-g $(addprefix -I, $(dir $(LIBS)))

TESTBIN=test.bin

.PHONY: all clean test

all: $(LIB)

%.o: %.c
	$(CXX) $(CXXFLAGS) -o $@ -c $?

$(LIBS):
	$(foreach var,$@, $(MAKE) $(MAKEFLAGS) -C $(dir $(var));)

$(LIB): $(OBJ) $(LIBS)
	$(LD) -o $@ -r $^

$(TESTBIN): test.o $(LIB)
	$(CXX) -o $(TESTBIN) test.cc $(LIB)

# run tests
test: $(LIB)
	$(CXX) $(CXXFLAGS) -o "test.o" -c "test.cc"
	$(CXX) $(CXXFLAGS) -o "test" "test.o" $^
	./test

clean:
	$(RM) $(LIB) $(OBJ)
	$(foreach var,$(LIBS), $(MAKE) $(MAKEFLAGS) -C $(dir $(var)) clean;)
