aarch64-linux-gnu-as output.s -o thing.o
aarch64-linux-gnu-ld thing.o -lc -o thing2
./thing2
rm thing.o thing2
