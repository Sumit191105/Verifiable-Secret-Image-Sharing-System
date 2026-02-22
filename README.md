# 🔐 Verifiable Secret Image Sharing using GF(2^8)

A threshold-based secret image sharing system implemented using polynomial interpolation over **Galois Field GF(2^8)** with cryptographic integrity verification.

This project demonstrates secure multi-party image sharing where any **k out of n shares** can reconstruct the original image.

---

## 🚀 Features

- Threshold-based (k,n) secret sharing
- Finite Field arithmetic using GF(2^8)
- Optimized Vandermonde matrix inversion
- Polynomial-based share generation
- Secure reconstruction without floating-point instability
- Global SHA-256 authentication for integrity verification
- Support for grayscale and RGB images

---

## 🧠 Core Concepts Implemented

- Shamir-inspired Secret Sharing
- Polynomial Interpolation
- Finite Field Arithmetic (GF(2^8))
- Vandermonde Matrix Algebra
- Cryptographic Hashing (SHA-256)
- Secure Multi-Party Reconstruction
- Numerical Stability Handling

---

## 📷 Workflow

Original Image  
↓  
Convert to pixel batches  
↓  
Generate polynomial over GF(2^8)  
↓  
Create n share images  
↓  
Reconstruct using k shares  
↓  
Verify integrity using SHA-256  

---

## 📂 Project Structure
# 🔐 Verifiable Secret Image Sharing using GF(2^8)

A threshold-based secret image sharing system implemented using polynomial interpolation over **Galois Field GF(2^8)** with cryptographic integrity verification.

This project demonstrates secure multi-party image sharing where any **k out of n shares** can reconstruct the original image.

---

## 🚀 Features

- Threshold-based (k,n) secret sharing
- Finite Field arithmetic using GF(2^8)
- Optimized Vandermonde matrix inversion
- Polynomial-based share generation
- Secure reconstruction without floating-point instability
- Global SHA-256 authentication for integrity verification
- Support for grayscale and RGB images

---

## 🧠 Core Concepts Implemented

- Shamir-inspired Secret Sharing
- Polynomial Interpolation
- Finite Field Arithmetic (GF(2^8))
- Vandermonde Matrix Algebra
- Cryptographic Hashing (SHA-256)
- Secure Multi-Party Reconstruction
- Numerical Stability Handling

---

## 📷 Workflow

Original Image  
↓  
Convert to pixel batches  
↓  
Generate polynomial over GF(2^8)  
↓  
Create n share images  
↓  
Reconstruct using k shares  
↓  
Verify integrity using SHA-256  

---



## ⚙️ How to Run

1. Open MATLAB (with Communications Toolbox)
2. Navigate to `src/`
3. Run:


main.m


4. Share images will be generated
5. Reconstruction will verify integrity automatically

---

## 🔍 Authentication Strategy

Instead of hashing each batch (computationally expensive),  
a **global SHA-256 hash** of the original image is computed.

After reconstruction:

- Hash of reconstructed image is calculated
- Compared with original hash
- Integrity verified

---

## 📊 Performance Optimization

- Precomputed Vandermonde matrix inverses
- Eliminated repeated matrix inversion inside loops
- Avoided floating-point arithmetic errors by using GF(2^8)

---

## 🎓 Skills Demonstrated

- Applied Cryptography
- Finite Field Mathematics
- Polynomial Interpolation
- Matrix Algebra
- Secure System Design
- Performance Optimization
- Debugging Numerical Instability
- Algorithmic Thinking

---

## 📌 Use Cases

- Secure distributed storage
- Multi-party secure image reconstruction
- Threshold cryptographic systems
- Educational cryptography demonstrations

---

## 📜 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

**Sumit Verma**  
