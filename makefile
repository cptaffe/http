SRC = http.c
HDR = http.h

OBJ := $(SRC:.c=.o)
LIB = libsock.o

LIBS=
CFLAGS+=-g  $(addprefix -I, $(dir $(LIBS)))

.PHONY: all clean

all: $(LIB)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $?

$(LIBS):
	$(foreach var,$@, $(MAKE) $(MAKEFLAGS) -C $(dir $(var));)

$(LIB): $(OBJ) $(LIBS)
	$(LD) -o $@ -r $^

clean:
	$(RM) $(LIB) $(OBJ)
	$(foreach var,$(LIBS), $(MAKE) $(MAKEFLAGS) -C $(dir $(var)) clean;)
