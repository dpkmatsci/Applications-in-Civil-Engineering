## Documentation

The details of stiffness matrix method for Truss analysis can be found in chapter 14 of [Structural Analysis, 8th Edition](https://www.candle.center/references/structural-analysis-eighth-edition-by-r.c.-hibbeler) by R.C. Hibbeler.

Here three different sample inputs have been provided which correspond to the exercise/example problems of Chapter 14.  

test_input1 : Problem 14-9 and 14-10

test_input2 : Problem 14-11

test_input3 : Example 14.7


## Instructions

Create or edit input files using following instructions.

```bash
   Provide these joint details in jntdet.txt. 
   joint no.  X-coordinate  Y-coordinate  Z-coordinate 

   For 2D problems, give z-coordinate and displacements as 0.

   Give orientation of joint with respect to global X, Y and Z direction in file jntangle.txt.
   Suppose X' and Y' are local directions for joint. Than alphax, betax and gammax are direction cosines of X'
   with respect to global directions. Similar arguments are applicable for Y' also. 
   joint alphax betax gammax alphay betay gammay

   Give joint displacement details in jntdisp.xlsx
   joint no. x-displacement y-displacement z-displacement
   For fixed joints all three are 0 while for other joints with unknown displacement just write NaN.
   No need to mention completely free joints with all displacements as unknown.

   Give Joint loading conditions in jntload.xlsx.
   Joint no. X-load(kN) y-Load(kN) z-load(kN)
   Mention only free joints with or without any load. No need to mention joints at support conditions with no external load.

   Provide member details in membdet.txt. 
   membername nearend farend Elastic Modulus (in GPa) and area(in mm^2)

   Give details of fabrication error (in m) in members in file membfab.txt

   Give details for consideration of thermal effects in file membtemp.txt
   member alpha(coefficient of thermal expansion) delt(rise in temperature)

   Keep all these input files with matlab files in the same folder. Finally run truss.m file.
   This will generate "trussresult.txt" file which contains joint displacements, joint reactions, member forces and stresses. 
```


