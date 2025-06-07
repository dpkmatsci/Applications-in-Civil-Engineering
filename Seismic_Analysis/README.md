## Documentation

The detailed principles of the calculation of response spectra can be found in any standard Structural Dynamics textbook. 
Here, "Dynamics of Structures" by Patrick Paultre has been followed for coding purposes. 

## Deployment

To deploy this project, open MATLAB and run spectrum.m

```bash

   Select "single choice" for a single value of the damping coefficient and provide the value in the white space. 

   Alternatively, select "comparison" for multiple values of damping coefficients and provide a filename with values.
   For example, write zi.txt (provide as an example) in white space.  

   Provide the maximum time period in seconds.

   Select required spectrum: Displacement, Pseudo-velocity or Pseudo-acceleration.

   Provide a function describing earthquake acceleration data or a filename.
   Some files with earthquake acceleration data (elcentro.dat, elcentro_EW.dat, elcentro_NS.dat, elcentro_UP.dat) have been provided in the folder. 

   Click on the "CREATE CURVE" button to generate the curve. 
```

The calculation is done by another script rspsptr.m provided in the same folder. It is necessary to keep this file in the same folder. 
