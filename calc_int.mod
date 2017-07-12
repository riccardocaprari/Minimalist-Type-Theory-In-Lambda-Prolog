
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SINGLETON SET
 
accumulate calc_singleton.

% EMPTY SET
accumulate calc_empty.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- calc_setPi.elpi

accumulate calc_setPi.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- calc_empty.elpi

isType empty set.

of (emp Z A) (A Z) IE 
   :- of Z empty IE
    , (pi x\ of x empty IE => isType (A x) _)
    .

of bottom empty IE.


tau empty empty A A.

trad bottom bottom.
trad empty empty.
trad (emp X A) (emp X' A') 
   :- tau' empty X X'
    , (pi xe\ pi xi\ of xe empty ext 
                     => of xi empty int 
                     => trad xe xi 
                     => trad (A xe) (A' xi))
    .

sigm Z Z :- of Z empty int.    


equ empty X1 X2 (propId empty X1 X2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- calc_colSigma.elpi

%% STRONG INDEXED COL SUM

isType (colSigma B C) col :-
    isType B col,
    pi b\ of b B int => isType (C b) col.

of (pair B C BB CC) (colSigma B C) int :-
    isType B col,
    isType (C BB) col,
    of BB B int,
    of CC (C BB) int,
    isType (colSigma B C) col.

of (elim_colSigma Pair M MM) (M Pair) int :-
        of Pair (colSigma B C) int,
        (pi z \ of z (colSigma B C) int => isType (M z) col),
        (pi x \ pi y \
            of x B int => of y (C x) int =>  
                of (MM x y) (M (pair B C x y)) int ).

hstep (elim_colSigma (pair B C Bb Cc) M Mm) (Mm Bb Cc) :-
    of Bb B int,
    of Cc (C Bb) int,
    (pi z\ of z (colSigma B C) int => isType (M z) col),
    (pi x \ pi y \
        of x B int => of y (C x) int =>  
            of (Mm x y) (M (pair B C x y))  int
    ).


dstep (pair B1 C Bb Cc) (pair B2 C Bb Cc) :- dstep B1 B2.

dstep (pair B C1 Bb Cc) (pair B C2 Bb Cc) :- 
    pi b\ of b B int => dstep (C1 b) (C2 b).

dstep (pair B C Bb1 Cc) (pair B C Bb2 Cc) :- dstep Bb1 Bb2.

dstep (pair B C Bb Cc1) (pair B C Bb Cc2) :- dstep Cc1 Cc2.


dstep (elim_colSigma Pair1 M Mm) (elim_colSigma Pair2 M Mm) :- 
    dstep Pair1 Pair2.

dstep (elim_colSigma Pair M Mm1) (elim_colSigma Pair M Mm2) :-
    of Pair (colSigma B C) int, 
    pi x\ pi y\ of x B int => of y (C x) int => dstep (Mm1 x y) (Mm2 x y).

dstep (elim_colSigma Pair M1 Mm) (elim_colSigma Pair M2 Mm) :-
        of Pair Ty int, 
        pi z\ of z Ty int => dstep (M1 z) (M2 z).

dstep (colSigma B C) (colSigma B' C) :- dstep B B'.
dstep (colSigma B C) (colSigma B C') :- (pi x\ of x B int => dstep (C x) (C' x)).








%%colSigma

trad (colSigma B C) (colSigma Bi Ci) :- 
        trad B Bi, 
        spy ( pi xe\ pi xi\ 
            trad xe xi => 
            of xe B ext =>
            of xi Bi int =>
            trad (C xe) (Ci xi) ).

trad (pair B C Bb Cc) (pair Bi Ci Bib Cic) :-
        trad B Bi,
        (pi xe\ pi xi\ 
            trad xe xi => 
            of xe B ext =>
            of xi Bi int => trad (C xe) (Ci xi) 
        ),
        tau' B Bb Bib,
        (pi xe\ pi xi\ 
            trad xe xi => 
            of xe B ext =>
            of xi Bi int => tau' (C xe) Cc Cic  
        ).

sigm DIR W W' :- 
        of W (colSigma B C) int,
        sigm DIR B B',
        (pi x\ pi x'\ 
            of x B int =>
            of x' B' int =>
            sigm DIR x x' =>
            sigm DIR (C x) (C' x')
        ),
        (pi x\
            of x B int =>
            sigm DIR x (F1 x)
        ),
        (pi x\ pi y\
            of x B int =>
            of y (C x) int => 
            sigm DIR x (F1 x) =>
            sigm DIR y (F2 y)
        ),
        W' = (elim_colSigma 
                (W) 
                (colSigma B' C') 
                (w1\ w2\ pair B' C' (F1 w1) (F2 w2) )
             )
        .

%bnf (
%     equ (colSigma B C) Z1 Z2
%    ) 
%    (
%     exist (equ B (p1 Z1) (p1 Z2)
%           ) 
%           (d\
%            subst (p1 Z1) 
%                  (p1 Z2) 
%                  (equ (C (p1 Z2)) (p2 Z1) (p2 Z2))
%           ) 
%    ) :-  of Z1 colSigma B C, of Z2 colSigma B C.

%:- of Z1 (colSigma B C), of Z2 (colSigma B C).

%trad (pair BB CC Bb Cc) (pair (trad BB) (trad CC) (trad Bb) (trad Cc)).

%subst X1 X2 wimSigma




%trad (quotientCol A R ) Ai :- trad A Ai.

%bnf (equ (quotientCol A R) Z1 Z2) (R Z1 Z2) :- of Z1 A, of Z2 A.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- calc_setSum.elpi

%%Disjoint Sum Type

isType (setSum A B) set :- isType A set, isType B set.

of (inr A B BB) (setSum A B) int :- isType B set, isType A set, isa BB B int.

of (inl A B AA) (setSum A B) int :- isType A set, isType B set, isa AA A int.

of (elim_setSum C W Cl Cr) (CW) int :- 
    of W (setSum A B) int,
    (pi z\ of z (setSum A B) int => isType (C z) set),
    (pi x\ of x A int => of (Cl x) (C (inr A B x)) int) ,
    (pi y\ of y B int => of (Cr y) (C (inl A B y)) int) ,
    CW = C W.

hstep (elim_setSum C W Cl Cr) (Cl Wl) :- hnf W (inl A B Wl).
hstep (elim_setSum C W Cl Cr) (Cr Wr) :- hnf W (inr A B Wr).

dstep (elim_setSum C W Cl Cr) (elim_setSum C W' Cl Cr) :- dstep W W'.

dstep (elim_setSum C W Cl Cr) (elim_setSum C W Cl' Cr) :- 
    pi w\ of w (setSum A B) int => dstep (Cl w) (Cl' w).

dstep (elim_setSum C W Cl Cr) (elim_setSum C W Cl Cr') :- 
    pi w\ of w (setSum A B) int => dstep (Cr w) (Cr' w).  

dstep (elim_setSum C W Cl Cr) (elim_setSum C' W Cl Cr) :- 
    pi w\ of w (setSum A B) int => dstep (C w) (C' w).  


dstep (inl A B AA) (inl A B AA') :- dstep AA AA'.
dstep (inr A B BB) (inr A B BB') :- dstep BB BB'.


%%% Interpretation

trad (setSum A B) (setSum Ai Bi)  :- trad A Ai, trad B Bi.
trad (inl A B AA) (inl Ai Bi AAi) :- trad A Ai, trad B Bi, tau' A AA AAi.
trad (inr A B BB) (inr Ai Bi BBi) :- trad A Ai, trad B Bi, tau' B BB BBi.

trad (elim_setSum C W Cl Cr) (elim_setSum Ci Wi Cli Cri) :- 
    of W (setSum A B) ext,
    tau' (setSum A B) W Wi,
    (pi x\ of x (setSum A B) int => trad (C x) (Ci x) ),
    (pi a\ of a A int => tau' (C (inl A B a)) (Cl a) (Cli a)),
    (pi b\ of b B int => tau' (C (inl A B b)) (Cr b) (Cri b)).

sigm X Y :- of X (setSum A B) int,
    (pi a\ of a A int, sigm (Cl a) (Cl' a)),
    (pi b\ of b B int, sigm (Cr b) (Cr' b)),
    Y = elim_setSum (setSum A B) X Cl' Cr'.

%TAU input Type    output Type   input     output
tau (setPi A1 B1) (setPi A2 B2) (inl AA1) (inl AA2) :- tau A1 A2 AA1 AA2.
tau (setPi A1 B1) (setPi A2 B2) (inr BB1) (inr BB2) :- tau B1 B2 BB1 BB2.

%%equ --     non sono sicuro di che cosa dica il teorema 4.20 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- calc_id.elpi

isType (propId A AA1 AA2) prop :- 
    isa AA1 A int,
    isa AA2 A int,
    isType A _.

of (id A AA1) (propId A' AA2 AA3) int :-    
    of AA1 A'' int,
    conv A A'',
    (conv AA1 AA2),
    (conv AA1 AA3),
    (conv A A'),
    isType A col.

of (elim_id P Cc C) (C AA1 AA2) int :-
     (of P (propId A AA1 AA2) int),
    makeline "-",
     (pi x\ pi y\ of x A int => of y A int => isType (C x y) prop),
     (pi x\ of x A int => of (Cc x) (C x x) int).

hstep (elim_id (id A AA) C CC) (CC AA) :-
    (of AA A int),
    (pi x\ pi y\ of x A int => of y A int => isType (C x y) prop),
    (pi x\ of x A int  => of (CC x) (C x x) int).

dstep (id A AA) (id A' AA) :- dstep A A'.

dstep (id A AA) (id A AA') :- dstep AA AA'.

dstep (propId A Aa Ab) (propId A' Aa Ab) :- (dstep A A').
dstep (propId A Aa Ab) (propId A Aa' Ab) :- dstep Aa Aa'.
dstep (propId A Aa Ab) (propId A Aa Ab') :- dstep Ab Ab'.

dstep (elim_id P C CC) (elim_id P' C CC) :- dstep P P'.
dstep (elim_id P C CC) (elim_id P C' CC) :- 
    of P (propId A _ _) int,
    pi x\ pi y\ of x A int => of y A int => dstep (C x y) (C' x y).

dstep (elim_id P C CC) (elim_id P C CC')  :- 
    of P (propId A _ _) int,
    pi x\ of x A int => dstep (CC x) (CC' x).

%macro (id_sym P) (elim_propId P (x\id A x) (y\x\propId A x y)).
%macro (id_tra P Q) (elim_propId Q (x\id A x) (x\y\propId AA1 y))
%   :- of P (propId A AA1 AA2) int
%    , of Q (propId A' AA3 AA4) int
%    , conv A A'
%    , conv AA2 AA3 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%forall

isType  (forall B C) prop :- 
    isType B col,
    (pi x\ of x B int => isType (C x) prop).

isType  (forall B C) props :- 
    isType B set,
    (pi x\ of x B int => isType (C x) props).

of (lam_for B CC) (forall B C) int :- 
        isType B prop,
        (pi x\ of x B int => of (CC x) (C x) int)
        (pi x\ of x B int => isType  (C x) prop).

of (app_for F BB) (C BB) int :- 
        hnf F (lam_for B CC),
        isa BB B int,
        (pi x\ of x B int => of (CC x) (C x) int).

hstep (app_for F BB) (CC BB) :-
        hnf F (lam_for B CC),
        isa BB B int,
        (pi x\ of x B int => of (CC x) (C x) int).
        
dstep (app_for F BB) (app_for F' BB') :- dstep F F'.
dstep (app_for F BB) (app_for F' BB') :- dstep BB BB'. 

dstep (lam_for B CC) (lam_for B' CC') :- dstep B B'.
dstep (lam_for B CC) (lam_for B' CC') :- 
        pi x\ of x B int => dstep (CC x) (CC' x).



dstep (forall A B) (forall A' B) :- dstep A A'.
dstep (forall A B) (forall A B') :- 
    pi x\ of x A int => dstep (B x) (B' x).

%---------------------------------%

of true (forall B C) ext :- 
    (pi x\ of x B ext => of true (C x) ext),
    (pi x\ of x B ext => isType (C x) prop).

% Credo non ci sia modo di non far divergere questa regola 
%of true (C BB) ext :-
%    of BB B ext,
%    of true (forall B C) ext.
%    


%%%Exist

isType (exist B C) prop :- 
    isType B col,
    (pi x\ of x B int => isType (C x) prop).
isType (exist B C) props :- 
    isType B set,
    (pi x\ of x B int => isType (C x) props).

of (exist_p B C BB CC) (exist B C) int :- 
        isType B col,
        of BB B int,
        of CC (C BB) int,
        (pi x\ of x B int => isType (C x) prop).


of (elim_exist Pair M MM) M int :-
        of Pair (exist B C) int,
        isType M prop,
        (pi x \ pi y \
            of x B int => of y (C x) int =>  
                of (MM x y) M int ).

hstep (elim_exist (pair B C Bb Cc) M Mm) (Mm Bb Cc) :-
    of Bb B int,
    of Cc (C Bb) int,
    (pi x \ pi y \
        of x B int => of y (C x) int =>  
            of (Mm x y) M  int).
        
dstep (exist_p B C BB CC) (exist_p B' C BB CC) :- dstep B B'.
dstep (exist_p B C BB CC) (exist_p B C' BB CC) :- (pi x\ of x B int => dstep (C x) (C' x)).
dstep (exist_p B C BB CC) (exist_p B C BB' CC) :- dstep BB BB'.
dstep (exist_p B C BB CC) (exist_p B C BB CC') :- dstep CC CC'.

dstep (elim_exist Pair M MM) (elim_exist Pair' M MM) :- dstep Pair Pair'.

dstep (elim_exist Pair M MM) (elim_exist Pair M MM') :- 
    of Pair (exist B C) int,
    pi x\ pi y\ of x B int => of y (C x) int => dstep (MM x y) (MM' x y).

dstep (elim_exist Pair M MM) (elim_exist Pair M' MM) :- dstep M M'.


dstep (exist A B) (exist A' B) :- dstep A A'.
dstep (exist A B) (exist A B') :- 
    pi x\ of x A int => dstep (B x) (B' x).



%------------------------------%
of true (exist B C) ext :-
    isType B col,
    (pi x\ of x B ext => isType (C x) prop) 
    of BB B ext,
    of true (C BB) ext.

%of true M ext :-
%    isType M prop,
%    of true (exist B C) ext,
%    (pi x\ pi y\
%        of x B ext => of y (C x) ext =>
%            of true M ext).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% LET IN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%locDef X T M

%letIn lDef N

of (letIn (locDef X T M) N) T' IE
    :-  locDef X T M
    =>  of N T' IE
    .

of X T IE :- locDef X T M.

hstep A B :- announce (hstep A B).
hstep X N
    :-  locDef X T M
    ,   conv M N
    .

hstep (letIn (locDef X T M) N) N'
    :-  locDef X T M
    =>  conv N N'.
