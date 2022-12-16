CC          := g++
DEBUG_FLAGS := -g3 -pedantic -Werror=implicit-function-declaration -fsanitize=address,undefined
FLAGS       := -lm -Wall -Werror -lSDL2 #$(DEBUG_FLAGS)

SRC         := ./src
BIN         := ./bin
BINNAME     := bin
HEADERS     := ./headers
FILES 	 	:= $(wildcard ./files/*.bin)
EXEC        := prog.exe
ZIP         := exercicio.zip

# List of all expected $(BIN)/*.o
ALL         := $(wildcard $(SRC)/*.cpp)
ALL         := $(ALL:$(SRC)/%.cpp=$(BIN)/%.o)


all: $(EXEC)

compile: all

crun : compile run

run: all
	./$(EXEC)

clean:
	rm -f $(EXEC) $(BIN)/*.o $(ZIP)

zip:
	rm -f $(ZIP)
	zip $(ZIP) Makefile $(HEADERS)/*.h $(SRC)/*.cpp ./*.bin ./*.csv

reset:
	rm -f $(ZIP) $(EXEC) ./*.bin
	cp $(FILES) ./

$(EXEC): $(ALL)
	$(CC) -o $(EXEC) $(BIN)/*.o $(FLAGS)

$(BIN)/%.o: $(SRC)/%.cpp $(BIN)
	$(CC) -o $@ -c $< -I $(HEADERS) $(FLAGS)

$(BINNAME):
	mkdir $(BINNAME)