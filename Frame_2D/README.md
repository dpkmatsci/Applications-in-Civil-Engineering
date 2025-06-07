## Documentation

The details of stiffness matrix method for Frame analysis can be found in chapter 16 of [Structural Analysis, 8th Edition](https://www.candle.center/references/structural-analysis-eighth-edition-by-r.c.-hibbeler) by R.C. Hibbeler.

Here three different sample inputs have been provided which correspond to the exercise problems of Chapter 16. 

test_input1 : Problem 16-1 and 16-2

test_input2 : Problem 16-3 and 16-4

test_input3 : Problem 16-5 and 16-6

## Instructions

Create or edit input files using following instructions.

```bash
   Provide these joint details in jntdt.xlsx. joint no.  X-coordinate  Y-coordinate
   angle of joint with respect to global X-Y direction and degree of freedom (DOF always 3 here) 

   Give joint displacement details in jntdisp.xlsx. joint no. x-displacement(mm) y-displacement(mm) rotation(radian)
   For fixed joints all three are 0 while for pinned joints only X- and Y-displacements are 0.
   Rotation is unknown so just write NaN

   Give Joint loading conditions in jntload.xlsx. Joint no. X-load(kN) y-Load(kN) Moment(kNm)
   Mention only free joints with or without any load. No need to mention joints at support conditions
   like fixed or hinged. Mention hinged joint only if external moment is acting there.

   Provide member details in membdt.xlsx.
   Member no. nearend farend area(in mm^2) Moment of Inertia (in mm^4) and Elastic Modulus (in GPa)

   Give details of pinned joints and members passing through it in pinned.xlsx.

   Give details of concentrated load or moment on members in membcload.txt. Type of load Global or Local.
   Frame member can be inclined. Hence if load or moment does not align with global X or Y direction,
   mention type of load as local. Provide position of load with respect to near end.
   If no such load exists, add a row of 0 for all columns. 

   Give details of uniform or triangular distributed load on members in trload.txt. The initial and final give
   the range of member length on which distributed load is acting. Provide both initial and final with respect
   to near end. Provide inudlload and fnudlload accordingly as these will be different for triangular distributed
   load but same for uniformly distributed load. If no such load exists, add a row of 0 for all columns.  

   Keep all these input files with matlab files in the same folder. Finally run frame2d.m file.
   This will generate "framedeformationresult.txt" (joint displacements and member rotations) and
   "framereactionresult.txt" (joint or support reactions and moments) files. 
```
