# DevOps PA 3

## Purpose

Demonstrate the skills of preparing a Debian distributive of your software source code and precompiled binary.

---

## Requirements

1. **Branch: `branchMake`**  
   - Branch out from the `master` branch and create a branch named `branchMake`.  
   - Implement a `Makefile` to build your C++ program.  
   - Add a continuous integration (CI) action on GitHub to compile and link the binary file.

2. **Branch: `branchAutomake`**  
   - Branch out from the `branchMake` branch and create a branch named `branchAutomake`.  
   - Implement `Makefile.am` and `configure.ac` scripts to build your C++ program.  
   - Add a CI action on GitHub to build a tarball distribution file.

3. **Branch: `branchAutoPackage`**  
   - Branch out from the `branchAutomake` branch and create a branch named `branchAutoPackage`.  
   - Update `Makefile.am` and `configure.ac` scripts to build a Debian package.  
   - Add a CI action on GitHub to build the `.deb` package.

4. **Branch: `branchAutoTest`**  
   - Branch out from the `branchAutoPackage` branch and create a branch named `branchAutoTest`.  
   - Prepare a unit test for your project.  
   - Update `Makefile.am` and `configure.ac` scripts to include the unit test.  
   - Add a CI action on GitHub to execute the unit test.

---  
