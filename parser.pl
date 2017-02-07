/* This relation checks if an AST is syntactically correct. */
valid(num(N)):-integer(N).
valid(add(E1,E2)):-valid(E1),valid(E2).
valid(sub(E1,E2)):-valid(E1),valid(E2).
valid(mul(E1,E2)):-valid(E1),valid(E2).
valid(dvd(E1,E2)):-valid(E1),valid(E2).

/* This relation is used to compute the value of an expression AST. */
value(num(X),X).
value(add(E1,E2),V):-value(E1,V1),value(E2,V2),V is V1+V2.
value(sub(E1,E2),V):-value(E1,V1),value(E2,V2),V is V1-V2.
value(mul(E1,E2),V):-value(E1,V1),value(E2,V2),V is V1*V2.
value(dvd(E1,E2),V):-value(E1,V1),value(E2,V2),V is V1/V2.


/* This relation defines the set of terms that are valid terminal symbols. */
isToken(numT(N)):-integer(N).
isToken(plusT).
isToken(dashT).
isToken(starT).
isToken(slashT).
isToken(lparenT).
isToken(rparenT).

/* This one checks that a list of tokens is valid. */
isTokenList([]).
isTokenList([H|T]):-isToken(H),isTokenList(T).


/* These relations stores sample lists of tokens for later use. */
e1( [numT(3)] ).
e2( [numT(1), plusT, numT(2)] ).
e3( [numT(1), plusT, numT(2), starT, numT(3)] ).
e4( [lparenT, numT(1), plusT, numT(2), rparenT, starT, numT(3)] ).
ea( [numT(13)] ).
eb( [numT(1), plusT, numT(4), starT, numT(2)] ).
ec( [numT(9), dashT, numT(2), slashT, numT(3)] ).
ed( [lparenT, numT(4), plusT, numT(7), rparenT, starT, numT(5)] ).

/*
Author: AMBUJ NAYAN
Email:  nayan003@umn.edu

Program Logic:
==============
1) apd functor has three arguments. The first two arguments specify the lists to be appended and third argument is the appended list.
2) Six versions of parseA(). They are for parsing numT, plusT, dashT, starT, slashT and parenthesis.
3) Eight versions of parseETF(). They are for parsing E+T, E-T, E*T, E/T, numT and (E).

apd([],L,L).
apd([H|X],Y,[H|Z]) :- apd(X,Y,Z).

*/
parseA([numT(X)], AST) :-
  AST = num(X).

parseA(T, AST) :-
  apd(SL1, [plusT|SL2], T),
  parseA(SL1, AST1),
  parseA(SL2, AST2),
  AST = add(AST1, AST2).

parseA(T, AST) :-
    apd(SL1, [starT|SL2], T),
    parseA(SL1, AST1),
    parseA(SL2, AST2),
    AST = mul(AST1, AST2).

parseA(T, AST) :-
    apd(SL1, [dashT|SL2], T),
    parseA(SL1, AST1),
    parseA(SL2, AST2),
    AST = sub(AST1, AST2).

parseA(T, AST) :-
    apd(SL1, [slashT|SL2], T),
    parseA(SL1, AST1),
    parseA(SL2, AST2),
    AST = dvd(AST1, AST2).

parseA(E, AST) :-
    apd([lparenT|X], [rparenT], E),
    parseA(X, AST).

parseETF(E, AST) :-
  apd(E1, [plusT|T1], E),
  parseETF(E1, AST1),
  parseT(T1, AST2),
  AST = add(AST1, AST2).

parseETF(E, AST) :-
  apd(E1, [dashT|T1], E),
  parseETF(E1, AST1),
  parseT(T1, AST2),
  AST = sub(AST1, AST2).

parseETF(E, AST) :-
  parseT(E, AST).

parseT(T, AST) :-
  apd(T1, [starT|F1], T),
  parseT(T1, AST1),
  parseF(F1, AST2),
  AST = mul(AST1, AST2).

parseT(T, AST) :-
  apd(T1, [slashT|F1], T),
  parseT(T1, AST1),
  parseF(F1, AST2),
  AST = dvd(AST1, AST2).

parseT(E, AST) :-
  parseF(E, AST).

parseF([numT(X)], AST) :-
  AST = num(X).

parseF(E, AST) :-
  apd([lparenT|X], [rparenT], E),
  parseETF(X, AST).
