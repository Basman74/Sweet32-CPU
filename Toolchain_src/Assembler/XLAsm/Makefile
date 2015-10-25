


CXXFLAGS	= -std=c++0x -Wextra -Wall -O2

CXXFLAGS	+= -DNDEBUG

xlasm: Makefile xlasm.cpp xlasmexpr.cpp xlasmsweet32.cpp
	$(CXX) $(CXXFLAGS) xlasm.cpp xlasmexpr.cpp xlasmsweet32.cpp -o xlasm

clean:
	rm -f xlasm *.o
