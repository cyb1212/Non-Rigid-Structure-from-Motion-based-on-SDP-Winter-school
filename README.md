# Non-Rigid-Structure-from-Motion-based-on-SDP-Winter-school

This project is a learning material for 2021 Winter school on SLAM in deformable environments. The cited reference is: Ji P, Li H, Dai Y, et al. " Maximizing rigidity" revisited: a convex programming approach for generic 3D shape reconstruction from multiple perspective views[C]//Proceedings of the IEEE International Conference on Computer Vision. 2017: 929-937.

The network parts of this code has been delated as a potential homework for the winter school. The pre-operations, including basic data loading, CVX toolbox installing, and nearest-neighbour graph (NNG) generation, and the later-evaluation/vision operations have been provided. The readers can complete the following steps:

## Configuration
This code is build based on CVX toolbox. Please install CVX (version later than Version 2.2) before running this code. Unzip file: toolbox_fast_marching.zip. Run main.m and answer the question: "Have you installed CVX? Y/N [Y]:"

## adding the constaints part based on the following convex problem:
Based on the perspective projection and the nearest-neighbourhood graph (NNG), the camera center and two connected 3D features can be parameterized based on the triangle edges. Combining with the scale limitations, positive limitations, and SDP relaxation, we can get the convex optimziation formulation.

![图片](https://user-images.githubusercontent.com/32351126/122766816-49a7a780-d2e5-11eb-9275-645d87b2e364.png)

![图片](https://user-images.githubusercontent.com/32351126/122768218-ba9b8f00-d2e6-11eb-81d8-f5ea21d20fec.png)

## testing more provided datasets
In our provided code, only the reduced T-shirt dataset with 4 scenes is offered. The participants are asked to add some other datasets in this project, including: (1) Flag dataset with 30 images, (2) full T-shirt dataset with 10 scenes; (3) Hulk dataset wiht 10 scenes. Because this formulation is relatively slow and the full datasets with too many images are time-consuming, it is totally fine to pick out partial dataset or divide the full one into multiple sub-parts.

![图片](https://user-images.githubusercontent.com/32351126/122768640-254cca80-d2e7-11eb-9bbe-42f22253e9c4.png)

## dealing with the missing data
The case with some missing data is very common in the NRSfM problem and its later applications. The provided code is only suitable for the result with full dataset. If some of the feature correspondences are missing, the inextensibility constaints connected with them need to be delete. The readers is encourage to consider this sitation.

## speeding up your codes (optional)
As menton before, this formulaion is time-consuming. Any ways to improve the running ability of the code is welcome.
