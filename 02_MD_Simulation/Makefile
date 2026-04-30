# Compiler and Optimization Flags
FC = gfortran
# -O3 for max optimization (crucial for MD simulations)
# -Wall to show all warnings
# -J $(BUILD_DIR) sends the generated .mod files to the build directory
FFLAGS = -O3 -Wall -J $(BUILD_DIR)

# Directories
SRC_DIR = src
BUILD_DIR = bin
DATA_DIR = data

# Output Executable Name
TARGET = md_sim

# Default Target (What runs when you just type 'make')
all: directories $(TARGET)

# Ensure necessary directories exist
directories:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(DATA_DIR)

# Link the compiled object files to create the final executable
$(TARGET): $(BUILD_DIR)/md_params.o \
           $(BUILD_DIR)/md_init.o \
           $(BUILD_DIR)/md_forces.o \
           $(BUILD_DIR)/md_energy.o \
           $(BUILD_DIR)/md_integrator.o \
           $(BUILD_DIR)/md_analysis.o \
           $(BUILD_DIR)/md_main.o
	$(FC) $(FFLAGS) -o $@ $^

# -------------------------------------------------------------------
# Explicit Fortran Dependencies (Order Matters)
# -------------------------------------------------------------------

# md_params has no dependencies, compile first
$(BUILD_DIR)/md_params.o: $(SRC_DIR)/md_params.f90
	$(FC) $(FFLAGS) -c $< -o $@

# init, forces, and energy depend purely on params
$(BUILD_DIR)/md_init.o: $(SRC_DIR)/md_init.f90 $(BUILD_DIR)/md_params.o
	$(FC) $(FFLAGS) -c $< -o $@

$(BUILD_DIR)/md_forces.o: $(SRC_DIR)/md_forces.f90 $(BUILD_DIR)/md_params.o
	$(FC) $(FFLAGS) -c $< -o $@

$(BUILD_DIR)/md_energy.o: $(SRC_DIR)/md_energy.f90 $(BUILD_DIR)/md_params.o
	$(FC) $(FFLAGS) -c $< -o $@

$(BUILD_DIR)/md_analysis.o: $(SRC_DIR)/md_analysis.f90 $(BUILD_DIR)/md_params.o
	$(FC) $(FFLAGS) -c $< -o $@

# integrator depends on params and forces
$(BUILD_DIR)/md_integrator.o: $(SRC_DIR)/md_integrator.f90 $(BUILD_DIR)/md_params.o $(BUILD_DIR)/md_forces.o
	$(FC) $(FFLAGS) -c $< -o $@

# main program depends on everything
$(BUILD_DIR)/md_main.o: $(SRC_DIR)/md_main.f90 $(BUILD_DIR)/md_params.o $(BUILD_DIR)/md_init.o $(BUILD_DIR)/md_forces.o $(BUILD_DIR)/md_energy.o $(BUILD_DIR)/md_integrator.o $(BUILD_DIR)/md_analysis.o
	$(FC) $(FFLAGS) -c $< -o $@

# -------------------------------------------------------------------
# Utility Commands
# -------------------------------------------------------------------

# Run the simulation and automatically move output data to the data/ folder
run: all
	./$(TARGET)
	@mv *.dat $(DATA_DIR)/ 2>/dev/null || true
	@echo "Simulation complete. Output files moved to $(DATA_DIR)/"

# Clean up build artifacts and the executable
clean:
	rm -rf $(BUILD_DIR) $(TARGET)
	@echo "Cleaned build directory and executable."

# Prevents make from confusing these targets with actual files named 'all', 'clean', etc.
.PHONY: all directories run clean