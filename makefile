CXX = g++

IBOOST_DIR=C:/boost/boost_1_64_0		# boost Library include directory
ICPPLIBS=C:/_cpplibs/include			# Other libraries include dir

LDIR=C:/boost/lib_64gcc/lib				# boost Library lib files
LIBS=									# other libraries lib files
IDIR=incl								# include directory (for this project)

CFLAGS=-O2 -Wall -Wextra -pedantic -std=c++14 -I$(IBOOST_DIR) -I$(ICPPLIBS) \
-I$(IDIR) -L$(LDIR) $(LIBS) -static


_DEPS = # Insert header file names here, place them in IDIR (./incl by default)
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

SDIR=src								# source file directory
_SRC = # Insert .cpp source file names here, place them in SDIR (./src)
SRC = $(patsubst %,$(SDIR)/%,$(_SRC))

ODIR=obj								# object file directory
_OBJ = # Insert .o files compiled from SRC here, they will be placed in ODIR (./obj)
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

TDIR=bin								# target (executable) directory
_TARGET = # Insert executable .exe files here, they will be placed in TDIR (./bin)
TARGET = $(patsubst %,$(TDIR)/%,$(_TARGET)) 


TESTS_DIR=tests							# tests source directory
_TESTS_DEPS = # Insert header file names here, place them in TESTS_DIR (./tests)
TESTS_DEPS = $(patsubst %,$(TESTS_DIR)/%,$(_TESTS_DEPS))
_TESTSO = # Insert .o test files here, place .cpp test files in TESTS_DIR (./tests)
TESTSO = $(patsubst %,$(TESTS_DIR)/%,$(_TESTSO))

_TESTS = # insert tests main executable name here
TESTS = $(patsubst %,$(TESTS_DIR)/%,$(_TESTS))


all: $(TARGET) $(TESTS)


# Compile the project
$(ODIR)/%.o: $(SDIR)/%.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CFLAGS)

$(TARGET): $(OBJ)
	$(CXX) -o $@ $^ $(CFLAGS)


# Compile tests
$(TESTS_DIR)/%.o: $(TESTS_DIR)/%.cpp $(DEPS) $(TESTS_DEPS)
	$(CXX) -c -o $@ $< $(CFLAGS)

$(TESTS): $(TESTSO)
	$(CXX) -o $@ $^ $(CFLAGS)



clean:
	rm -f $(ODIR)/*.* $(TDIR)/*.* $(TESTS_DIR)/*.o $(TESTS_DIR)/*.exe


.PHONY: all, clean
