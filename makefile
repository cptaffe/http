SRC = http.c
HDR = http.h

OBJ := $(SRC:.c=.o)
LIB = libhttp.o

LIBS=
CFLAGS+=-g  $(addprefix -I, $(dir $(LIBS)))

TESTBIN=test.bin

.PHONY: all clean test

all: $(LIB)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $?

$(LIBS):
	$(foreach var,$@, $(MAKE) $(MAKEFLAGS) -C $(dir $(var));)

$(LIB): $(OBJ) $(LIBS)
	$(LD) -o $@ -r $^

$(TESTBIN): test.o $(LIB)
	$(CC) -o $(TESTBIN) test.c $(LIB)

# run tests
test: $(LIB)
	$(CC) $(CFLAGS) --std=c99 -o "test.o" -c "test.c"
	$(CC) $(CFLAGS) -o "test" "test.o" $^
	./test

clean:
	$(RM) $(LIB) $(OBJ)
	$(foreach var,$(LIBS), $(MAKE) $(MAKEFLAGS) -C $(dir $(var)) clean;)
