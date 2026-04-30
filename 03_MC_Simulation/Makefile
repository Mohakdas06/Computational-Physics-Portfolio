# Compiler settings
FC = gfortran
FLAGS = -O3 -Wall -J obj -I obj

# Directories
SRC_SHARED = src/shared
SRC_PROB = src/problems
OBJ_DIR = obj
BIN_DIR = bin

# 1. FIND ALL PROBLEM FILES AUTOMATICALLY
# This looks in src/problems for any file matching "prob*.f90"
SRCS = $(wildcard $(SRC_PROB)/prob*.f90)

# 2. CREATE A LIST OF EXECUTABLES
# This changes "src/problems/prob01.f90" -> "bin/prob01"
PROGS = $(patsubst $(SRC_PROB)/%.f90, $(BIN_DIR)/%, $(SRCS))

# Helper to create directories
$(shell mkdir -p $(OBJ_DIR) $(BIN_DIR))

# Shared objects
OBJS_SHARED = $(OBJ_DIR)/constants_mod.o $(OBJ_DIR)/monte_carlo_toolbox.o

# --- TARGETS ---

# Build all detected programs
all: $(PROGS)

# --- RULES ---

# Compile Shared Modules
$(OBJ_DIR)/constants_mod.o: $(SRC_SHARED)/constants_mod.f90
	$(FC) $(FLAGS) -c $< -o $@

$(OBJ_DIR)/monte_carlo_toolbox.o: $(SRC_SHARED)/monte_carlo_toolbox.f90 $(OBJ_DIR)/constants_mod.o
	$(FC) $(FLAGS) -c $< -o $@

# Magic Rule: Compile any problem found
$(BIN_DIR)/%: $(SRC_PROB)/%.f90 $(OBJS_SHARED)
	$(FC) $(FLAGS) $(OBJS_SHARED) $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o $(OBJ_DIR)/*.mod $(BIN_DIR)/*