import matplotlib.pyplot as plt
import numpy as np

DATA = np.loadtxt("data/prob02.dat")
ENERGIES = np.loadtxt("data/prob02_energies.dat")
SCALE_FACTOR = 10

# Load data
x = DATA[:, 0]
V_x = DATA[:, 1]

wavefunctions = [DATA[:, i] for i in range(2, len(ENERGIES) + 2)]

# Plot
plt.figure(figsize=(8, 8))

# Plot the background potential
plt.plot(x, V_x, color='black', linewidth=2, label=r'V(x) = $0.5 m \omega^2 x^2$ for $x \geq 0$')

# Plot shifted and scaled wavefunctions
for n, (psi, E) in enumerate(zip(wavefunctions, ENERGIES)):
    plt.plot(x, (psi * SCALE_FACTOR) + E, label=f'n={n} (E={E:.4f})')
    plt.axhline(E, color='gray', linestyle='--', alpha=0.5)

plt.axvline(x=0.0, color='black', lw=4)

plt.title('Half Harmonic Oscillator Solutions (FDM)', size=15)
plt.xlabel(r'Position $(x)$', size=15)
plt.ylabel(r'Wavefunction $\psi(x)$', size=15)
plt.xlim([0, 5])
plt.ylim([0, 11])

plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.15), ncol=3)
plt.subplots_adjust(bottom=0.2)
plt.tight_layout()

plt.savefig('plots/prob02_half_harmonic.png', dpi=300)
plt.show()