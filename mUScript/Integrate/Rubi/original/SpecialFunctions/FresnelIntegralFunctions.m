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
Int[FresnelS[a_.+b_.*x_],x_Symbol] :=
  (a+b*x)*FresnelS[a+b*x]/b + Cos[Pi/2*(a+b*x)^2]/(b*Pi) /;
FreeQ[{a,b},x]


(* ::Code:: *)
Int[FresnelC[a_.+b_.*x_],x_Symbol] :=
  (a+b*x)*FresnelC[a+b*x]/b - Sin[Pi/2*(a+b*x)^2]/(b*Pi) /;
FreeQ[{a,b},x]


(* ::Code:: *)
Int[FresnelS[a_.+b_.*x_]^2,x_Symbol] :=
  (a+b*x)*FresnelS[a+b*x]^2/b -
  Dist[2,Int[(a+b*x)*Sin[Pi/2*(a+b*x)^2]*FresnelS[a+b*x],x]] /;
FreeQ[{a,b},x]


(* ::Code:: *)
Int[FresnelC[a_.+b_.*x_]^2,x_Symbol] :=
  (a+b*x)*FresnelC[a+b*x]^2/b -
  Dist[2,Int[(a+b*x)*Cos[Pi/2*(a+b*x)^2]*FresnelC[a+b*x],x]] /;
FreeQ[{a,b},x]


(* ::Code:: *)
Int[x_^m_.*FresnelS[a_.+b_.*x_],x_Symbol] :=
  x^(m+1)*FresnelS[a+b*x]/(m+1) -
  Dist[b/(m+1),Int[x^(m+1)*Sin[Pi/2*(a+b*x)^2],x]] /;
FreeQ[{a,b,m},x] && NonzeroQ[m+1]


(* ::Code:: *)
Int[x_^m_.*FresnelC[a_.+b_.*x_],x_Symbol] :=
  x^(m+1)*FresnelC[a+b*x]/(m+1) -
  Dist[b/(m+1),Int[x^(m+1)*Cos[Pi/2*(a+b*x)^2],x]] /;
FreeQ[{a,b,m},x] && NonzeroQ[m+1]


(* ::Code:: *)
Int[x_^m_*FresnelS[b_.*x_]^2,x_Symbol] :=
  x^(m+1)*FresnelS[b*x]^2/(m+1) -
  Dist[2*b/(m+1),Int[x^(m+1)*Sin[Pi/2*b^2*x^2]*FresnelS[b*x],x]] /;
FreeQ[b,x] && IntegerQ[m] && m+1!=0 && (m>0 && EvenQ[m] || Mod[m,4]==3)


(* ::Code:: *)
Int[x_^m_*FresnelC[b_.*x_]^2,x_Symbol] :=
  x^(m+1)*FresnelC[b*x]^2/(m+1) -
  Dist[2*b/(m+1),Int[x^(m+1)*Cos[Pi/2*b^2*x^2]*FresnelC[b*x],x]] /;
FreeQ[b,x] && IntegerQ[m] && m+1!=0 && (m>0 && EvenQ[m] || Mod[m,4]==3)


(* ::Code:: *)
(* Int[x_^m_.*FresnelS[a_+b_.*x_]^2,x_Symbol] :=
  Dist[1/b,Subst[Int[(-a/b+x/b)^m*FresnelS[x]^2,x],x,a+b*x]] /;
FreeQ[{a,b},x] && IntegerQ[m] && m>0 *)


(* ::Code:: *)
(* Int[x_^m_.*FresnelC[a_+b_.*x_]^2,x_Symbol] :=
  Dist[1/b,Subst[Int[(-a/b+x/b)^m*FresnelC[x]^2,x],x,a+b*x]] /;
FreeQ[{a,b},x] && IntegerQ[m] && m>0 *)


(* ::Code:: *)
Int[x_*Sin[c_.*x_^2]*FresnelS[b_.*x_],x_Symbol] :=
  -Cos[Pi/2*b^2*x^2]*FresnelS[b*x]/(Pi*b^2) +
  Dist[1/(2*Pi*b),Int[Sin[Pi*b^2*x^2],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2]


(* ::Code:: *)
Int[x_*Cos[c_.*x_^2]*FresnelC[b_.*x_],x_Symbol] :=
  Sin[Pi/2*b^2*x^2]*FresnelC[b*x]/(Pi*b^2) -
  Dist[1/(2*Pi*b),Int[Sin[Pi*b^2*x^2],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2]


(* ::Code:: *)
Int[x_^m_*Sin[c_.*x_^2]*FresnelS[b_.*x_],x_Symbol] :=
  -x^(m-1)*Cos[Pi/2*b^2*x^2]*FresnelS[b*x]/(Pi*b^2) +
  Dist[1/(2*Pi*b),Int[x^(m-1)*Sin[Pi*b^2*x^2],x]] +
  Dist[(m-1)/(Pi*b^2),Int[x^(m-2)*Cos[Pi/2*b^2*x^2]*FresnelS[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m>1 && Not[Mod[m,4]==2]


(* ::Code:: *)
Int[x_^m_*Cos[c_.*x_^2]*FresnelC[b_.*x_],x_Symbol] :=
  x^(m-1)*Sin[Pi/2*b^2*x^2]*FresnelC[b*x]/(Pi*b^2) -
  Dist[1/(2*Pi*b),Int[x^(m-1)*Sin[Pi*b^2*x^2],x]] -
  Dist[(m-1)/(Pi*b^2),Int[x^(m-2)*Sin[Pi/2*b^2*x^2]*FresnelC[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m>1 && Not[Mod[m,4]==2]


(* ::Code:: *)
Int[x_^m_*Sin[c_.*x_^2]*FresnelS[b_.*x_],x_Symbol] :=
  x^(m+1)*Sin[Pi/2*b^2*x^2]*FresnelS[b*x]/(m+1) - b*x^(m+2)/(2*(m+1)*(m+2)) +
  Dist[b/(2*(m+1)),Int[x^(m+1)*Cos[Pi*b^2*x^2],x]] -
  Dist[Pi*b^2/(m+1),Int[x^(m+2)*Cos[Pi/2*b^2*x^2]*FresnelS[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m<-2 && Mod[m,4]==0


(* ::Code:: *)
Int[x_^m_*Cos[c_.*x_^2]*FresnelC[b_.*x_],x_Symbol] :=
  x^(m+1)*Cos[Pi/2*b^2*x^2]*FresnelC[b*x]/(m+1) - b*x^(m+2)/(2*(m+1)*(m+2)) -
  Dist[b/(2*(m+1)),Int[x^(m+1)*Cos[Pi*b^2*x^2],x]] +
  Dist[Pi*b^2/(m+1),Int[x^(m+2)*Sin[Pi/2*b^2*x^2]*FresnelC[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m<-2 && Mod[m,4]==0


(* ::Code:: *)
Int[x_*Cos[c_.*x_^2]*FresnelS[b_.*x_],x_Symbol] :=
  Sin[Pi/2*b^2*x^2]*FresnelS[b*x]/(Pi*b^2) - x/(2*Pi*b) +
  Dist[1/(2*Pi*b),Int[Cos[Pi*b^2*x^2],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2]


(* ::Code:: *)
Int[x_*Sin[c_.*x_^2]*FresnelC[b_.*x_],x_Symbol] :=
  -Cos[Pi/2*b^2*x^2]*FresnelC[b*x]/(Pi*b^2) + x/(2*Pi*b) +
  Dist[1/(2*Pi*b),Int[Cos[Pi*b^2*x^2],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2]


(* ::Code:: *)
Int[x_^m_*Cos[c_.*x_^2]*FresnelS[b_.*x_],x_Symbol] :=
  x^(m-1)*Sin[Pi/2*b^2*x^2]*FresnelS[b*x]/(Pi*b^2) - x^m/(2*b*m*Pi) +
  Dist[1/(2*Pi*b),Int[x^(m-1)*Cos[Pi*b^2*x^2],x]] -
  Dist[(m-1)/(Pi*b^2),Int[x^(m-2)*Sin[Pi/2*b^2*x^2]*FresnelS[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m>1 && Not[Mod[m,4]==0]


(* ::Code:: *)
Int[x_^m_*Sin[c_.*x_^2]*FresnelC[b_.*x_],x_Symbol] :=
  -x^(m-1)*Cos[Pi/2*b^2*x^2]*FresnelC[b*x]/(Pi*b^2) + x^m/(2*b*m*Pi) +
  Dist[1/(2*Pi*b),Int[x^(m-1)*Cos[Pi*b^2*x^2],x]] +
  Dist[(m-1)/(Pi*b^2),Int[x^(m-2)*Cos[Pi/2*b^2*x^2]*FresnelC[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m>1 && Not[Mod[m,4]==0]


(* ::Code:: *)
Int[x_^m_*Cos[c_.*x_^2]*FresnelS[b_.*x_],x_Symbol] :=
  x^(m+1)*Cos[Pi/2*b^2*x^2]*FresnelS[b*x]/(m+1) -
  Dist[b/(2*(m+1)),Int[x^(m+1)*Sin[Pi*b^2*x^2],x]] +
  Dist[Pi*b^2/(m+1),Int[x^(m+2)*Sin[Pi/2*b^2*x^2]*FresnelS[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m<-1 && Mod[m,4]==2


(* ::Code:: *)
Int[x_^m_*Sin[c_.*x_^2]*FresnelC[b_.*x_],x_Symbol] :=
  x^(m+1)*Sin[Pi/2*b^2*x^2]*FresnelC[b*x]/(m+1) -
  Dist[b/(2*(m+1)),Int[x^(m+1)*Sin[Pi*b^2*x^2],x]] -
  Dist[Pi*b^2/(m+1),Int[x^(m+2)*Cos[Pi/2*b^2*x^2]*FresnelC[b*x],x]] /;
FreeQ[{b,c},x] && ZeroQ[c-Pi/2*b^2] && IntegerQ[m] && m<-1 && Mod[m,4]==2



