CC=gcc
CFLAGS=-I.
DEPS = parse.h y.tab.h
OBJ = y.tab.o lex.yy.o parse.o echo_server.o
FLAGS = -g -Wall

default: echo_server echo_client all

all: echo_server

lex.yy.c: lexer.l
	flex $^

y.tab.c: parser.y
	yacc -d $^

%.o: %.c $(DEPS)
	$(CC) $(FLAGS) -c -o $@ $< $(CFLAGS)

echo_server: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

echo_client:
	@gcc echo_client.c -o echo_client -Wall -Werror

clean:
	@rm echo_server echo_client
	rm -f *~ *.o example lex.yy.c y.tab.c y.tab.h
