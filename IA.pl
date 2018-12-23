selecciona(X,[X|L],L).
selecciona(X,[Y|L1],[Y|L2]):- selecciona(X,L1,L2).

traspuesta_columna([],[],[]).
traspuesta_columna([[V1|VALS]|OTHER],[V1|C],[VALS|REST]):-traspuesta_columna(OTHER,C,REST).

traspuesta([[]|_],[]).
traspuesta([[V1|VALS]|OTHER],[C|COL]):-
    traspuesta_columna([[V1|VALS]|OTHER],C,[VALS|REST]),
    traspuesta([VALS|REST], COL).

kakuro(VALS,SUMX,SUMY):-check_rows(VALS,SUMX,0,[1,2,3,4,5,6,7,8,9]), traspuesta(VALS,TVALS), check_rows(TVALS,SUMY,0,[1,2,3,4,5,6,7,8,9]),imprimir_kakuro(VALS,SUMX,SUMY).

check_rows([],[],_,_).
check_rows([[V1|VALS]|OTHER], SUMS, AC ,ND):- selecciona(V1,ND,ND2),NAC is AC + V1,check_rows([VALS|OTHER],SUMS,NAC,ND2).

check_rows([[V1|VALS]|OTHER], SUMS, 0,ND):- nonvar(V1), V1 == 0 ,check_rows([VALS|OTHER],SUMS,0,ND).
check_rows([[V1|VALS]|OTHER], [S1|SUMS], S1,_):- nonvar(V1), V1 == 0 ,check_rows([VALS|OTHER],SUMS,0,[1,2,3,4,5,6,7,8,9]), S1 \== 0.

check_rows([[]|OTHER], SUMS, 0,ND):- check_rows(OTHER,SUMS,0,ND).
check_rows([[]|OTHER], [S1|SUMS], S1,_):- check_rows(OTHER,SUMS,0,[1,2,3,4,5,6,7,8,9]), S1 \== 0.

imprimir([]):-nl.
imprimir([0|A]):-write('-'),tab(1),imprimir(A).
imprimir([V1|A]):-V1 \== 0, write(V1),tab(1), imprimir(A).
imprimir_matrix([]).
imprimir_matrix([A|VALS]):-[A|VALS] \== [] ,tab(1),imprimir(A),nl,imprimir_matrix(VALS).
imprimir_kakuro(VALS,SUMX,SUMY):-nl,imprimir_matrix(VALS),tab(1),write('X-sum:'),imprimir(SUMX),tab(1),write('Y-sum:'),imprimir(SUMY),nl.

%Ejemplos:

%kakuro([[9,5,0,0,3,9],[8,2,0,8,1,2],[2,1,3,9,0,0],[0,0,1,4,2,7],[1,4,2,0,1,3],[7,8,0,0,8,9]],[14,12,10,11,15,14,7,4,15,17],[19,8,8,12,6,21,4,11,11,19]).

%kakuro([[0,A,B,0,0],[C,D,E,F,0],[G,H,0,I,J],[0,K,L,M,N],[0,0,P,O,0]],[9,10,12,11,21,13],[13,13,5,17,11,17]).

%kakuro([[0,0,A,B],[0,C,D,E],[F,G,H,0],[I,J,0,0]],[3,7,18,11],[4,21,11,3]).
%A=1,B=2,C=4,D=2,E=1,F=1,G=9,H=8,I=3,J=8;

%kakuro([[A,B,0],[0,C,D],[E,F,G]],[5,15,12],[2,4,15,11]).
%A=2,B=3,C=7,D=8,E=4,F=5,G=3;

%kakuro([[2,3],[0,7]],[5,7],[2,10]).
