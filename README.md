# logicProgramming (Prolog)

 Parser for simple expressions that can be represented by the AST:

 Sample interactions:

?- ea(T),parseA(T,AST).
T = [numT(13)],
AST = num(13) ;
false.

?- eb(T),parseA(T,AST).
T = [numT(1), plusT, numT(4), starT, numT(2)],
AST = add(num(1), mul(num(4), num(2))) ;
T = [numT(1), plusT, numT(4), starT, numT(2)],
AST = mul(add(num(1), num(4)), num(2)) ;
false.

?- ec(T),parseA(T,AST).
T = [numT(9), dashT, numT(2), slashT, numT(3)],
AST = sub(num(9), num(2)div num(3)) ;
T = [numT(9), dashT, numT(2), slashT, numT(3)],
AST = sub(num(9), num(2))div num(3) ;
false.

?- ea(T),parseETF(T,AST).
T = [numT(13)],
AST = num(13).

?- eb(T),parseETF(T,AST).
T = [numT(1), plusT, numT(4), starT, numT(2)],
AST = add(num(1), mul(num(4), num(2))) ;
false.

?- ec(T),parseETF(T,AST).
T = [numT(9), dashT, numT(2), slashT, numT(3)],
AST = sub(num(9), num(2)div num(3)) ;
false.
