Gesture prediction using GMMs
---------------------------------

This matlab code provides GMM fiting of a library of motions, it outputs
    - GMM specification for each class
    - GMR trajectories for each class

It is based on Sylvain Calinon's code for GMM fitting of motion 
trajectories. Several enhancement have been added provided. 

The library of motion taken as input has to be divided in M files 
(one file per class). In each file motions are represented by one row 
per posture (configuration), motions are set one after the other. For an
example look at gestures/8classes_rafi. Preceeding the posture 
specification, each row must start with the time, or a simple id. 

The parameters of the learning algorithm are set at the begining of the 
IROS_learning.m file.

    - "nb of states" : the number of components per GMM.
    - "nb of test" : the number of leave one out test, has to be smaller 
       or equal to the number of trajectories on the library
    - "nb of trajectory" : the number of trajectories per class in 
       the library
    - "nb of point per traj" : the number of configurations per 
       trajectory in the library

Important files:
    - IROS_learning.m  : Clears the workspace, loads the motion library, 
      computes the GMM model, performs a leave one out testing on the GMMs 
      and finaly computes GMR for each class. The number of trained GMM is 
      the number of classes times the number of tests. This procedure might
      be time consuming.
    - IROS_plot_leave_one_out.m : Plots the result of leave-one-out phase.
    - save_gmms_to_csv.m  : Exports the GMM model for external usage.

Jim Mainprice
