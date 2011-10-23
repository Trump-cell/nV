(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Code:: *)
Int[ArcCot[a_.*x_],x_Symbol] :=
  x*ArcCot[a*x] + Log[1+a^2*x^2]/(2*a) /;
FreeQ[a,x]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_,x_Symbol] :=
  x*ArcCot[a*x]^n +
  Dist[a*n,Int[x*ArcCot[a*x]^(n-1)/(1+a^2*x^2),x]] /;
FreeQ[a,x] && IntegerQ[n] && n>1


(* ::Code:: *)
Int[x_*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  ArcCot[a*x]^n/(2*a^2) + x^2*ArcCot[a*x]^n/2 +
  Dist[n/(2*a),Int[ArcCot[a*x]^(n-1),x]] /;
FreeQ[a,x] && IntegerQ[n] && n>0


(* ::Code:: *)
Int[x_^m_*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  x^(m-1)*ArcCot[a*x]^n/(a^2*(m+1)) + x^(m+1)*ArcCot[a*x]^n/(m+1) +
  Dist[n/(a*(m+1)),Int[x^(m-1)*ArcCot[a*x]^(n-1),x]] -
  Dist[(m-1)/(a^2*(m+1)),Int[x^(m-2)*ArcCot[a*x]^n,x]] /;
FreeQ[a,x] && IntegerQ[n] && n>0 && RationalQ[m] && m>1


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_/x_,x_Symbol] :=
  2*ArcCot[a*x]^n*ArcCoth[1-2*I/(I-a*x)] +
  Dist[2*a*n,Int[ArcCot[a*x]^(n-1)*ArcCoth[1-2*I/(I-a*x)]/(1+a^2*x^2),x]] /;
FreeQ[a,x] && IntegerQ[n] && n>1


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./x_^2,x_Symbol] :=
  -ArcCot[a*x]^n/x -
  Dist[a*n,Int[ArcCot[a*x]^(n-1)/(x*(1+a^2*x^2)),x]] /;
FreeQ[a,x] && IntegerQ[n] && n>0


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./x_^3,x_Symbol] :=
  -a^2*ArcCot[a*x]^n/2 - ArcCot[a*x]^n/(2*x^2) -
  Dist[a*n/2,Int[ArcCot[a*x]^(n-1)/x^2,x]] /;
FreeQ[a,x] && IntegerQ[n] && n>0


(* ::Code:: *)
Int[x_^m_*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  x^(m+1)*ArcCot[a*x]^n/(m+1) + a^2*x^(m+3)*ArcCot[a*x]^n/(m+1) +
  Dist[a*n/(m+1),Int[x^(m+1)*ArcCot[a*x]^(n-1),x]] -
  Dist[a^2*(m+3)/(m+1),Int[x^(m+2)*ArcCot[a*x]^n,x]] /;
FreeQ[a,x] && IntegerQ[n] && n>0 && RationalQ[m] && m<-3


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./(c_+d_.*x_),x_Symbol] :=
  -ArcCot[a*x]^n*Log[2*c/(c+d*x)]/d -
  Dist[a*n/d,Int[ArcCot[a*x]^(n-1)*Log[2*c/(c+d*x)]/(1+a^2*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[a^2*c^2+d^2] && IntegerQ[n] && n>0


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./(x_*(c_+d_.*x_)),x_Symbol] :=
  ArcCot[a*x]^n*Log[2-2*c/(c+d*x)]/c +
  Dist[a*n/c,Int[ArcCot[a*x]^(n-1)*Log[2-2*c/(c+d*x)]/(1+a^2*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[a^2*c^2+d^2] && IntegerQ[n] && n>0


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./(c_.*x_+d_.*x_^2),x_Symbol] :=
  ArcCot[a*x]^n*Log[2-2*c/(c+d*x)]/c +
  Dist[a*n/c,Int[ArcCot[a*x]^(n-1)*Log[2-2*c/(c+d*x)]/(1+a^2*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[a^2*c^2+d^2] && IntegerQ[n] && n>0


(* ::Code:: *)
Int[x_^m_.*ArcCot[a_.*x_]^n_./(c_+d_.*x_),x_Symbol] :=
  Dist[1/d,Int[x^(m-1)*ArcCot[a*x]^n,x]] -
  Dist[c/d,Int[x^(m-1)*ArcCot[a*x]^n/(c+d*x),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[a^2*c^2+d^2] && RationalQ[m] && m>0 && IntegerQ[n] && n>0


(* ::Code:: *)
Int[x_^m_*ArcCot[a_.*x_]^n_./(c_+d_.*x_),x_Symbol] :=
  Dist[1/c,Int[x^m*ArcCot[a*x]^n,x]] -
  Dist[d/c,Int[x^(m+1)*ArcCot[a*x]^n/(c+d*x),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[a^2*c^2+d^2] && RationalQ[m] && m<-1 && IntegerQ[n] && n>0


(* ::Code:: *)
Int[1/((c_+d_.*x_^2)*ArcCot[a_.*x_]),x_Symbol] :=
  -Log[ArcCot[a*x]]/(a*c) /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./(c_+d_.*x_^2),x_Symbol] :=
  -ArcCot[a*x]^(n+1)/(a*c*(n+1)) /;
FreeQ[{a,c,d,n},x] && ZeroQ[d-a^2*c] && NonzeroQ[n+1]


(* ::Code:: *)
Int[x_*ArcCot[a_.*x_]^n_./(c_+d_.*x_^2),x_Symbol] :=
  I*ArcCot[a*x]^(n+1)/(d*(n+1)) -
  Dist[1/(a*c),Int[ArcCot[a*x]^n/(I-a*x),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./(x_*(c_+d_.*x_^2)),x_Symbol] :=
  I*ArcCot[a*x]^(n+1)/(c*(n+1)) +
  Dist[I/c,Int[ArcCot[a*x]^n/(x*(I+a*x)),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_./(c_.*x_+d_.*x_^3),x_Symbol] :=
  I*ArcCot[a*x]^(n+1)/(c*(n+1)) +
  Dist[I/c,Int[ArcCot[a*x]^n/(x*(I+a*x)),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0


(* ::Code:: *)
Int[x_^m_*ArcCot[a_.*x_]^n_./(c_+d_.*x_^2),x_Symbol] :=
  Dist[1/d,Int[x^(m-2)*ArcCot[a*x]^n,x]] -
  Dist[c/d,Int[x^(m-2)*ArcCot[a*x]^n/(c+d*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && m>1 && n>0


(* ::Code:: *)
Int[x_^m_*ArcCot[a_.*x_]^n_./(c_+d_.*x_^2),x_Symbol] :=
  Dist[1/c,Int[x^m*ArcCot[a*x]^n,x]] -
  Dist[d/c,Int[x^(m+2)*ArcCot[a*x]^n/(c+d*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && m<-1 && n>0


(* ::Code:: *)
Int[x_^m_.*ArcCot[a_.*x_]^n_/(c_+d_.*x_^2),x_Symbol] :=
  -Dist[1/(a^(m+1)*c),Subst[Int[x^n*Cot[x]^m,x],x,ArcCot[a*x]]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && (n<0 || Not[IntegerQ[n]]) && (IntegerQ[m] || PositiveQ[a])


(* ::Code:: *)
Int[x_^m_.*ArcCot[a_.*x_]^n_/(c_+d_.*x_^2),x_Symbol] :=
  -Dist[1/(a*c),Subst[Int[x^n*(Cot[x]/a)^m,x],x,ArcCot[a*x]]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && (n<0 || Not[IntegerQ[n]]) && Not[IntegerQ[m] || PositiveQ[a]]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_.*ArcCoth[u_]/(c_+d_.*x_^2),x_Symbol] :=
  Dist[1/2,Int[ArcCot[a*x]^n*Log[Regularize[1+1/u,x]]/(c+d*x^2),x]] -
  Dist[1/2,Int[ArcCot[a*x]^n*Log[Regularize[1-1/u,x]]/(c+d*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0 && (ZeroQ[u^2-(1-2*I/(I+a*x))^2] || ZeroQ[u^2-(1-2*I/(I-a*x))^2])


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_.*Log[u_]/(c_+d_.*x_^2),x_Symbol] :=
  I*ArcCot[a*x]^n*PolyLog[2,1-u]/(2*a*c) +
  Dist[n*I/2,Int[ArcCot[a*x]^(n-1)*PolyLog[2,1-u]/(c+d*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0 && ZeroQ[(1-u)^2-(1-2*I/(I+a*x))^2]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_.*Log[u_]/(c_+d_.*x_^2),x_Symbol] :=
  -I*ArcCot[a*x]^n*PolyLog[2,1-u]/(2*a*c) -
  Dist[n*I/2,Int[ArcCot[a*x]^(n-1)*PolyLog[2,1-u]/(c+d*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0 && ZeroQ[(1-u)^2-(1-2*I/(I-a*x))^2]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_.*PolyLog[p_,u_]/(c_+d_.*x_^2),x_Symbol] :=
  -I*ArcCot[a*x]^n*PolyLog[p+1,u]/(2*a*c) -
  Dist[n*I/2,Int[ArcCot[a*x]^(n-1)*PolyLog[p+1,u]/(c+d*x^2),x]] /;
FreeQ[{a,c,d,p},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0 && ZeroQ[u^2-(1-2*I/(I+a*x))^2]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_.*PolyLog[p_,u_]/(c_+d_.*x_^2),x_Symbol] :=
  I*ArcCot[a*x]^n*PolyLog[p+1,u]/(2*a*c) +
  Dist[n*I/2,Int[ArcCot[a*x]^(n-1)*PolyLog[p+1,u]/(c+d*x^2),x]] /;
FreeQ[{a,c,d,p},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>0 && ZeroQ[u^2-(1-2*I/(I-a*x))^2]


(* ::Code:: *)
Int[ArcTan[a_.*x_]^m_.*ArcCot[a_.*x_]^n_./(c_+d_.*x_^2),x_Symbol] :=
  ArcTan[a*x]^(m+1)*ArcCot[a*x]^n/(a*c*(m+1)) +
  Dist[n/(m+1),Int[ArcTan[a*x]^(m+1)*ArcCot[a*x]^(n-1)/(c+d*x^2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n] && 0<n<m


(* ::Code:: *)
Int[ArcCot[a_.*x_]/Sqrt[c_+d_.*x_^2],x_Symbol] :=
  -2*I*ArcCot[a*x]*ArcTan[Sqrt[1+I*a*x]/Sqrt[1-I*a*x]]/(a*Sqrt[c]) -
  I*PolyLog[2,-I*Sqrt[1+I*a*x]/Sqrt[1-I*a*x]]/(a*Sqrt[c]) +
  I*PolyLog[2,I*Sqrt[1+I*a*x]/Sqrt[1-I*a*x]]/(a*Sqrt[c]) /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && PositiveQ[c]


(* ::Code:: *)
Int[ArcCot[a_.*x_]/Sqrt[c_+d_.*x_^2],x_Symbol] :=
  Sqrt[1+a^2*x^2]/Sqrt[c+d*x^2]*Int[ArcCot[a*x]/Sqrt[1+a^2*x^2],x] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && Not[PositiveQ[c]]


(* ::Code:: *)
Int[ArcCot[a_.*x_]/(c_+d_.*x_^2)^(3/2),x_Symbol] :=
  -1/(a*c*Sqrt[c+d*x^2]) +
  x*ArcCot[a*x]/(c*Sqrt[c+d*x^2]) /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c]


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_/(c_+d_.*x_^2)^(3/2),x_Symbol] :=
  -n*ArcCot[a*x]^(n-1)/(a*c*Sqrt[c+d*x^2]) +
  x*ArcCot[a*x]^n/(c*Sqrt[c+d*x^2]) -
  Dist[n*(n-1),Int[ArcCot[a*x]^(n-2)/(c+d*x^2)^(3/2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n>1


(* ::Code:: *)
Int[ArcCot[a_.*x_]^n_/(c_+d_.*x_^2)^(3/2),x_Symbol] :=
  -ArcCot[a*x]^(n+1)/(a*c*(n+1)*Sqrt[c+d*x^2]) +
  x*ArcCot[a*x]^(n+2)/(c*(n+1)*(n+2)*Sqrt[c+d*x^2]) -
  Dist[1/((n+1)*(n+2)),Int[ArcCot[a*x]^(n+2)/(c+d*x^2)^(3/2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n<-1 && n!=-2


(* ::Code:: *)
Int[(c_+d_.*x_^2)^m_.*ArcCot[a_.*x_],x_Symbol] :=
  (c+d*x^2)^m/(2*a*m*(2*m+1)) +
  x*(c+d*x^2)^m*ArcCot[a*x]/(2*m+1) +
  Dist[2*c*m/(2*m+1),Int[(c+d*x^2)^(m-1)*ArcCot[a*x],x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[m] && m>0


(* ::Code:: *)
Int[(c_+d_.*x_^2)^m_*ArcCot[a_.*x_],x_Symbol] :=
  -(c+d*x^2)^(m+1)/(4*a*c*(m+1)^2) -
  x*(c+d*x^2)^(m+1)*ArcCot[a*x]/(2*c*(m+1)) +
  Dist[(2*m+3)/(2*c*(m+1)),Int[(c+d*x^2)^(m+1)*ArcCot[a*x],x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[m] && m<-1 && m!=-3/2


(* ::Code:: *)
Int[(c_+d_.*x_^2)^m_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  -n*(c+d*x^2)^(m+1)*ArcCot[a*x]^(n-1)/(4*a*c*(m+1)^2) -
  x*(c+d*x^2)^(m+1)*ArcCot[a*x]^n/(2*c*(m+1)) +
  Dist[(2*m+3)/(2*c*(m+1)),Int[(c+d*x^2)^(m+1)*ArcCot[a*x]^n,x]] -
  Dist[n*(n-1)/(4*(m+1)^2),Int[(c+d*x^2)^m*ArcCot[a*x]^(n-2),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && m<-1 && m!=-3/2 && n>1


(* ::Code:: *)
Int[(c_+d_.*x_^2)^m_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  -(c+d*x^2)^(m+1)*ArcCot[a*x]^(n+1)/(a*c*(n+1)) +
  Dist[2*a*(m+1)/(n+1),Int[x*(c+d*x^2)^m*ArcCot[a*x]^(n+1),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && m<-1 && n<-1


(* ::Code:: *)
Int[(c_+d_.*x_^2)^m_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  -Dist[c^m/a,Subst[Int[x^n*Csc[x]^(2*(m+1)),x],x,ArcCot[a*x]]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegerQ[m] && RationalQ[n] && m<-1 && (n<0 || Not[IntegerQ[n]])


(* ::Code:: *)
(* Int[(c_+d_.*x_^2)^m_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  c^(m-1/2)*Sqrt[c+d*x^2]/Sqrt[1+a^2*x^2]*Int[(1+a^2*x^2)^m*ArcCot[a*x]^n,x] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && m<-1 && (n<0 || Not[IntegerQ[n]]) && IntegerQ[m-1/2] && Not[PositiveQ[c]] *)


(* ::Code:: *)
Int[x_*(c_+d_.*x_^2)^p_.*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  (c+d*x^2)^(p+1)*ArcCot[a*x]^n/(2*d*(p+1)) +
  Dist[n/(2*a*(p+1)),Int[(c+d*x^2)^p*ArcCot[a*x]^(n-1),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{n,p}] && n>0 && p!=-1


(* ::Code:: *)
Int[x_*(c_+d_.*x_^2)^p_./ArcCot[a_.*x_]^2,x_Symbol] :=
  x*(c+d*x^2)^(p+1)/(a*c*ArcCot[a*x]) -
  Dist[1/a,Int[(1+(2*p+3)*a^2*x^2)*(c+d*x^2)^p/ArcCot[a*x],x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[p]


(* ::Code:: *)
Int[x_*ArcCot[a_.*x_]^n_/(c_+d_.*x_^2)^2,x_Symbol] :=
  -x*ArcCot[a*x]^(n+1)/(a*c*(n+1)*(c+d*x^2)) -
  (1-a^2*x^2)*ArcCot[a*x]^(n+2)/(d*(n+1)*(n+2)*(c+d*x^2)) -
  Dist[4/((n+1)*(n+2)),Int[x*ArcCot[a*x]^(n+2)/(c+d*x^2)^2,x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[n] && n<-1 && n!=-2


(* ::Code:: *)
Int[x_^m_*(c_+d_.*x_^2)^p_.*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  x^(m+1)*(c+d*x^2)^(p+1)*ArcCot[a*x]^n/(c*(m+1)) +
  Dist[a*n/(m+1),Int[x^(m+1)*(c+d*x^2)^p*ArcCot[a*x]^(n-1),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n,2*p] && m<-1 && n>0 && ZeroQ[m+2*p+3]


(* ::Code:: *)
Int[x_^m_*(c_+d_.*x_^2)^p_.*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  -x^m*(c+d*x^2)^(p+1)*ArcCot[a*x]^(n+1)/(a*c*(n+1)) +
  Dist[m/(a*(n+1)),Int[x^(m-1)*(c+d*x^2)^p*ArcCot[a*x]^(n+1),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n,2*p] && n<-1 && ZeroQ[m+2*p+2]


(* ::Code:: *)
Int[x_^m_*(c_+d_.*x_^2)^p_*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  Dist[1/d,Int[x^(m-2)*(c+d*x^2)^(p+1)*ArcCot[a*x]^n,x]] -
  Dist[c/d,Int[x^(m-2)*(c+d*x^2)^p*ArcCot[a*x]^n,x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n,2*p] && m>1 && n!=-1 && p<-1


(* ::Code:: *)
Int[x_^m_*(c_+d_.*x_^2)^p_*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  Dist[1/c,Int[x^m*(c+d*x^2)^(p+1)*ArcCot[a*x]^n,x]] -
  Dist[d/c,Int[x^(m+2)*(c+d*x^2)^p*ArcCot[a*x]^n,x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n,2*p] && m<0 && n!=-1 && p<-1


(* ::Code:: *)
Int[x_^m_*(c_+d_.*x_^2)^p_.*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  x^(m+1)*(c+d*x^2)^(p+1)*ArcCot[a*x]^n/(c*(m+1)) +
  Dist[a*n/(m+1),Int[x^(m+1)*(c+d*x^2)^p*ArcCot[a*x]^(n-1),x]] -
  Dist[a^2*(m+2*p+3)/(m+1),Int[x^(m+2)*(c+d*x^2)^p*ArcCot[a*x]^n,x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n,2*p] && m<-1 && n>0 && NonzeroQ[m+2*p+3]


(* ::Code:: *)
Int[x_^m_.*(c_+d_.*x_^2)^p_.*ArcCot[a_.*x_]^n_.,x_Symbol] :=
  -x^m*(c+d*x^2)^(p+1)*ArcCot[a*x]^(n+1)/(a*c*(n+1)) +
  Dist[m/(a*(n+1)),Int[x^(m-1)*(c+d*x^2)^p*ArcCot[a*x]^(n+1),x]] +
  Dist[a*(m+2*p+2)/(n+1),Int[x^(m+1)*(c+d*x^2)^p*ArcCot[a*x]^(n+1),x]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && IntegersQ[m,n,2*p] && n<-1 && NonzeroQ[m+2*p+2]


(* ::Code:: *)
Int[(e_.+f_.*x_^m_.)*(c_+d_.*x_^2)^p_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  -Dist[c^p/a^(m+1),Subst[Int[Expand[x^n*TrigReduce[Regularize[(e*a^m+f*Cot[x]^m)*Csc[x]^(2*(p+1)),x]]],x],x,ArcCot[a*x]]] /;
FreeQ[{a,c,d,e,f},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && IntegerQ[p] && p<-1 && (n<0 || Not[IntegerQ[n]]) && (IntegerQ[m] || PositiveQ[a])


(* ::Code:: *)
Int[x_^m_.*(c_+d_.*x_^2)^p_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  -Dist[c^p/a,Subst[Int[x^n*(Cot[x]/a)^m*Csc[x]^(2*(p+1)),x],x,ArcCot[a*x]]] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n}] && IntegerQ[p] && p<-1 && (n<0 || Not[IntegerQ[n]]) && Not[IntegerQ[m] || PositiveQ[a]]


(* ::Code:: *)
(* Int[x_^m_.*(c_+d_.*x_^2)^p_*ArcCot[a_.*x_]^n_,x_Symbol] :=
  c^(p-1/2)*Sqrt[c+d*x^2]/Sqrt[1+a^2*x^2]*Int[x^m*(1+a^2*x^2)^p*ArcCot[a*x]^n,x] /;
FreeQ[{a,c,d},x] && ZeroQ[d-a^2*c] && RationalQ[{m,n,p}] && p<-1 && (n<0 || Not[IntegerQ[n]]) && IntegerQ[p-1/2] && Not[PositiveQ[c]] *)


(* ::Code:: *)
Int[ArcCot[a_+b_.*x_],x_Symbol] :=
  (a+b*x)*ArcCot[a+b*x]/b + Log[1+(a+b*x)^2]/(2*b) /;
FreeQ[{a,b},x]


(* ::Code:: *)
Int[ArcCot[a_+b_.*x_^n_],x_Symbol] :=
  x*ArcCot[a+b*x^n] +
  Dist[b*n,Int[x^n/(1+a^2+2*a*b*x^n+b^2*x^(2*n)),x]] /;
FreeQ[{a,b},x] && RationalQ[n]


(* ::Code:: *)
Int[ArcCot[a_.+b_.*x_^n_.]/x_,x_Symbol] :=
  Dist[I/2,Int[Log[1-I/(a+b*x^n)]/x,x]] -
  Dist[I/2,Int[Log[1+I/(a+b*x^n)]/x,x]] /;
FreeQ[{a,b,n},x]


(* ::Code:: *)
Int[x_^m_.*ArcCot[a_+b_.*x_^n_.],x_Symbol] :=
  x^(m+1)*ArcCot[a+b*x^n]/(m+1) +
  Dist[b*n/(m+1),Int[x^(m+n)/(1+a^2+2*a*b*x^n+b^2*x^(2*n)),x]] /;
FreeQ[{a,b},x] && RationalQ[{m,n}] && m+1!=0 && m+1!=n


(* ::Code:: *)
Int[ArcCot[a_+b_.*x_]^n_.,x_Symbol] :=
  Dist[1/b,Subst[Int[ArcCot[x]^n,x],x,a+b*x]] /;
FreeQ[{a,b},x] && IntegerQ[n] && n>1


(* ::Code:: *)
Int[x_^m_.*ArcCot[a_+b_.*x_]^n_,x_Symbol] :=
  Dist[1/b^(m+1),Subst[Int[(x-a)^m*ArcCot[x]^n,x],x,a+b*x]] /;
FreeQ[{a,b},x] && IntegersQ[m,n] && m>0 && n>1


(* ::Code:: *)
Int[ArcCot[b_.*x_]/(c_+d_.*x_^n_.),x_Symbol] :=
  Dist[I/2,Int[Log[1-I/(b*x)]/(c+d*x^n),x]] -
  Dist[I/2,Int[Log[1+I/(b*x)]/(c+d*x^n),x]] /;
FreeQ[{b,c,d},x] && IntegerQ[n] && Not[n==2 && ZeroQ[d-b^2*c]]


(* ::Code:: *)
Int[ArcCot[a_+b_.*x_]/(c_+d_.*x_^n_.),x_Symbol] :=
  Dist[I/2,Int[Log[1-I/(a+b*x)]/(c+d*x^n),x]] -
  Dist[I/2,Int[Log[1+I/(a+b*x)]/(c+d*x^n),x]] /;
FreeQ[{a,b,c,d},x] && IntegerQ[n] && Not[n==1 && ZeroQ[a*d-b*c]]


(* ::Code:: *)
Int[u_.*ArcCot[c_./(a_.+b_.*x_^n_.)]^m_.,x_Symbol] :=
  Int[u*ArcTan[a/c+b*x^n/c]^m,x] /;
FreeQ[{a,b,c,n,m},x]


(* ::Code:: *)
If[ShowSteps,

Int[u_*v_^n_.,x_Symbol] :=
  Module[{tmp=InverseFunctionOfLinear[u,x]},
  ShowStep["","Int[f[x,ArcCot[a+b*x]]/(1+(a+b*x)^2),x]",
		   "-Subst[Int[f[-a/b+Cot[x]/b,x],x],x,ArcCot[a+b*x]]/b",Hold[
  Dist[-(-Discriminant[v,x]/(4*Coefficient[v,x,2]))^n/Coefficient[tmp[[1]],x,1],
	Subst[Int[Regularize[SubstForInverseFunction[u,tmp,x]*Csc[x]^(2*(n+1)),x],x], x, tmp]]]] /;
 NotFalseQ[tmp] && Head[tmp]===ArcCot && ZeroQ[Discriminant[v,x]*tmp[[1]]^2+D[v,x]^2]] /;
SimplifyFlag && QuadraticQ[v,x] && IntegerQ[n] && n<0 && NegQ[Discriminant[v,x]] && MatchQ[u,r_.*f_^w_ /; FreeQ[f,x]],

Int[u_*v_^n_.,x_Symbol] :=
  Module[{tmp=InverseFunctionOfLinear[u,x]},
  Dist[-(-Discriminant[v,x]/(4*Coefficient[v,x,2]))^n/Coefficient[tmp[[1]],x,1],
	Subst[Int[Regularize[SubstForInverseFunction[u,tmp,x]*Csc[x]^(2*(n+1)),x],x], x, tmp]] /;
 NotFalseQ[tmp] && Head[tmp]===ArcCot && ZeroQ[Discriminant[v,x]*tmp[[1]]^2+D[v,x]^2]] /;
QuadraticQ[v,x] && IntegerQ[n] && n<0 && NegQ[Discriminant[v,x]] && MatchQ[u,r_.*f_^w_ /; FreeQ[f,x]]]


(* ::Code:: *)
Int[ArcCot[a_.+b_.*f_^(c_.+d_.*x_)],x_Symbol] :=
  Dist[I/2,Int[Log[1-I/(a+b*f^(c+d*x))],x]] -
  Dist[I/2,Int[Log[1+I/(a+b*f^(c+d*x))],x]] /;
FreeQ[{a,b,c,d,f},x] 


(* ::Code:: *)
Int[x_^m_.*ArcCot[a_.+b_.*f_^(c_.+d_.*x_)],x_Symbol] :=
  Dist[I/2,Int[x^m*Log[1-I/(a+b*f^(c+d*x))],x]] -
  Dist[I/2,Int[x^m*Log[1+I/(a+b*f^(c+d*x))],x]] /;
FreeQ[{a,b,c,d,f},x] && IntegerQ[m] && m>0


(* ::Code:: *)
Int[ArcCot[u_],x_Symbol] :=
  x*ArcCot[u] +
  Int[Regularize[x*D[u,x]/(1+u^2),x],x] /;
InverseFunctionFreeQ[u,x]


(* ::Code:: *)
Int[x_^m_.*ArcCot[u_],x_Symbol] :=
  x^(m+1)*ArcCot[u]/(m+1) +
  Dist[1/(m+1),Int[Regularize[x^(m+1)*D[u,x]/(1+u^2),x],x]] /;
FreeQ[m,x] && NonzeroQ[m+1] && InverseFunctionFreeQ[u,x] && 
	Not[FunctionOfQ[x^(m+1),u,x]] && 
	FalseQ[PowerVariableExpn[u,m+1,x]]


(* ::Code:: *)
Int[v_*ArcCot[u_],x_Symbol] :=
  Module[{w=Block[{ShowSteps=False,StepCounter=Null}, Int[v,x]]},  
  w*ArcCot[u] +
  Int[Regularize[w*D[u,x]/(1+u^2),x],x] /;
 InverseFunctionFreeQ[w,x]] /;
InverseFunctionFreeQ[u,x] && 
	Not[MatchQ[v, x^m_. /; FreeQ[m,x]]] &&
	FalseQ[FunctionOfLinear[v*ArcCot[u],x]]