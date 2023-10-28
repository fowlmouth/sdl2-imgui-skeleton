BIN := sdltest

SRC := $(wildcard src/*.cpp) $(wildcard imgui/*.cpp)
SRC += imgui/backends/imgui_impl_sdl2.cpp imgui/backends/imgui_impl_sdlrenderer2.cpp

OBJ := $(SRC:.cpp=.o)

IMGUI_RELEASE := 1.89.9

CXXFLAGS := -std=c++20 $(shell pkg-config --cflags sdl2) -Iimgui -Iimgui/backends
LDFLAGS := $(shell pkg-config --libs sdl2)

ALL: $(BIN)
.PHONY: clean cleanall debug release

$(BIN): $(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

%.o: %.cpp imgui
	$(CXX) $(CXXFLAGS) -c $< -o $@

imgui.tar.gz:
	curl --location --output imgui.tar.gz https://github.com/ocornut/imgui/archive/refs/tags/v$(IMGUI_RELEASE).tar.gz

imgui: imgui.tar.gz
	mkdir imgui
	tar xzf imgui.tar.gz --strip-components=1 -C imgui

clean:
	rm -rf $(OBJ)
cleanall: clean
	rm -rf $(BIN) imgui imgui.tar.gz
