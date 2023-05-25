matmult.out: main.o matmult.o
	gcc -g -m32 -Wall -Werror -o matmult.out main.o matmult.o

matmult.o: matmult.s
	gcc -g -m32 -Wall -Werror -c -o matmult.o matmult.s

main.o: main.c
	gcc -g -m32 -Wall -Werror -c -o main.o main.c
	
clean:
	rm -f main.o matmult.o matmult.out
