# polyominoes
MATLAB code for solving tiling problems involving polyominoes

      polyominoes is
      a MATLAB code which
      considers polyominoes, and the question of tiling a region R.
    
      A region R is a connected subset of an MRxNR grid of squares.
      "Holes" are allowed in R.

      A polyomino is a shape formed by connecting unit squares edgewise.
  
      Regions and polyominoes can be represented by rectangular matrices, 
      whose entries are 1 for squares that are part of the polyomino, 
      and 0 otherwise.
   
      In a tiling problem, a region R is given, as well as a set of one
      or more polyominoes.  Each polyomino will also have a duplication
      factor D, indicating how many times it must be used in the tiling.
      The task is to determine how to arrange the polyominoes so that
      each cell of R is covered exactly once, and no other cells are 
      covered.
    
      If the tiling is to be done using only a single type of polyomino,
      this is termed a "monohedral" tiling problem; otherwise it is 
      called "multihedral".  Monohedral problems are easier to set up and
      define, and so this library often provides separate "mono" and "multi"
      versions of the algorithms.
    
      The approach studied here rewrites this problem as a set of
      underdetermined algebraic equations.  Each equation represents
      the covering of a particular cell, or the stipulation on the number
      of times a given polyomino must be used.  Each variable corresponds
      to a particular reflection, rotation, and translation of one of the
      polyomino shapes.
    
      Very small problems can be solved using the row reduced echelon form
      of the linear system.  In general, however, an integer programming
      package, such as CPLEX, GUROBI, or SCIP, must be invoked to obtain
      solutions which are integer, and in fact binary (only 0 or 1 values
      allowed.)
