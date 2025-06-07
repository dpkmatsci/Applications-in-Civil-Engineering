## Documentation

The details of concrete mix design principles incorporated in the above script can be found in the following document.

[IS 10262:2009](https://law.resource.org/pub/in/bis/S03/is.10262.2009.pdf)

## Deployment

To deploy this project, open MATLAB and run mixdsn.m.
```bash
    Provide characteristics of coarse aggregate, fine aggregate, cement, and other necessary details like
    grade of concrete mix, water-cement ratio, volume and air entrapped. 

    Click on "CALCULATE" button to find the required amount of constituents. 
```
The calculation is done by another script, guimixdsgn.m provided in the same folder. It is necessary to keep this file in the same folder. 

Additional options related to the amount of superplasticizer are available in guimixdsgn.m, but yet to be added in the main file mixdsn.m.
