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
Int[1/(a_+b_.*x_^2),x_Symbol] :=
  Rt[a/b,2]/a*ArcTan[x/Rt[a/b,2]] /;
FreeQ[{a,b},x] && PosQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^2),x_Symbol] :=
  Rt[-a/b,2]/a*ArcTanh[x/Rt[-a/b,2]] /;
FreeQ[{a,b},x] && NegQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^3),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,3]], s=Denominator[Rt[a/b,3]]},
  Dist[r/(3*a),Int[1/(r+s*x),x]] +
  Dist[r/(3*a),Int[(2*r-s*x)/(r^2-r*s*x+s^2*x^2),x]]] /;
FreeQ[{a,b},x] && PosQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^3),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,3]], s=Denominator[Rt[-a/b,3]]},
  Dist[r/(3*a),Int[1/(r-s*x),x]] +
  Dist[r/(3*a),Int[(2*r+s*x)/(r^2+r*s*x+s^2*x^2),x]]] /;
FreeQ[{a,b},x] && NegQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,4]], s=Denominator[Rt[a/b,4]]},
  Dist[r/(2*Sqrt[2]*a),Int[(Sqrt[2]*r-s*x^(n/4))/(r^2-Sqrt[2]*r*s*x^(n/4)+s^2*x^(n/2)),x]] +
  Dist[r/(2*Sqrt[2]*a),Int[(Sqrt[2]*r+s*x^(n/4))/(r^2+Sqrt[2]*r*s*x^(n/4)+s^2*x^(n/2)),x]]] /;
FreeQ[{a,b},x] && IntegerQ[n/4] && n>2 && PositiveQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,2]], s=Denominator[Rt[-a/b,2]]},
  Dist[r/(2*a),Int[1/(r-s*x^(n/2)),x]] +
  Dist[r/(2*a),Int[1/(r+s*x^(n/2)),x]]] /;
FreeQ[{a,b},x] && IntegerQ[n/4] && n>2 && Not[PositiveQ[a/b]]


(* ::Code:: *)
Int[1/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,n/2]], s=Denominator[Rt[a/b,n/2]]},
  Dist[2*r/(a*n),Int[1/(r+s*x^2),x]] +
  Dist[4*r/(a*n),Int[Sum[(r-s*Cos[2*(2*k-1)*Pi/n]*x^2)/(r^2-2*r*s*Cos[2*(2*k-1)*Pi/n]*x^2+s^2*x^4),
    {k,1,(n-2)/4}],x]]] /;
FreeQ[{a,b},x] && IntegerQ[(n-2)/4] && n>2 && PosQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,n/2]], s=Denominator[Rt[-a/b,n/2]]},
  Dist[2*r/(a*n),Int[1/(r-s*x^2),x]] +
  Dist[4*r/(a*n),Int[Sum[(r-s*Cos[4*k*Pi/n]*x^2)/(r^2-2*r*s*Cos[4*k*Pi/n]*x^2+s^2*x^4),
    {k,1,(n-2)/4}],x]]] /;
FreeQ[{a,b},x] && IntegerQ[(n-2)/4] && n>2 && NegQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,n]], s=Denominator[Rt[a/b,n]]},
  Int[r/(a*n*(r+s*x)) +
	Sum[2*r*(r-s*Cos[(2*k-1)*Pi/n]*x)/(a*n*(r^2-2*r*s*Cos[(2*k-1)*Pi/n]*x+s^2*x^2)),
      {k,1,(n-1)/2}],x]] /;
FreeQ[{a,b},x] && OddQ[n] && n>1 && PosQ[a/b]


(* ::Code:: *)
Int[1/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,n]], s=Denominator[Rt[-a/b,n]]},
  Int[r/(a*n*(r-s*x)) +
	Sum[2*r*(r+s*Cos[(2*k-1)*Pi/n]*x)/(a*n*(r^2+2*r*s*Cos[(2*k-1)*Pi/n]*x+s^2*x^2)),
      {k,1,(n-1)/2}],x]] /;
FreeQ[{a,b},x] && OddQ[n] && n>1 && NegQ[a/b]


(* ::Code:: *)
Int[x_/(a_+b_.*x_^3),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,3]], s=Denominator[Rt[a/b,3]]},
  Dist[-r^2/(3*a*s),Int[1/(r+s*x),x]] +
  Dist[r^2/(3*a*s),Int[(r+s*x)/(r^2-r*s*x+s^2*x^2),x]]] /;
FreeQ[{a,b},x] && PosQ[a/b]


(* ::Code:: *)
Int[x_/(a_+b_.*x_^3),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,3]], s=Denominator[Rt[-a/b,3]]},
  Dist[r^2/(3*a*s),Int[1/(r-s*x),x]] -
  Dist[r^2/(3*a*s),Int[(r-s*x)/(r^2+r*s*x+s^2*x^2),x]]] /;
FreeQ[{a,b},x] && NegQ[a/b]


(* ::Code:: *)
Int[x_^m_./(a_+b_.*x_^n_),x_Symbol] :=
  Module[{g=GCD[m+1,n]},
  Dist[1/g,Subst[Int[x^((m+1)/g-1)/(a+b*x^(n/g)),x],x,x^g]] /;
 g>1] /;
FreeQ[{a,b},x] && IntegersQ[m,n] && 0<m+1<n


(* ::Code:: *)
Int[x_^m_/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,4]], s=Denominator[Rt[a/b,4]]},
  Dist[s^3/(2*Sqrt[2]*b*r),Int[x^(m/2)/(r^2-Sqrt[2]*r*s*x^(m/2)+s^2*x^m),x]] -
  Dist[s^3/(2*Sqrt[2]*b*r),Int[x^(m/2)/(r^2+Sqrt[2]*r*s*x^(m/2)+s^2*x^m),x]]] /;
FreeQ[{a,b},x] && IntegerQ[m/2] && m>0 && ZeroQ[n-2*m] && PositiveQ[a/b]


(* ::Code:: *)
Int[x_^m_/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,2]], s=Denominator[Rt[-a/b,2]]},
  Dist[s/(2*b),Int[1/(r+s*x^m),x]] -
  Dist[s/(2*b),Int[1/(r-s*x^m),x]]] /;
FreeQ[{a,b},x] && EvenQ[m] && m>0 && ZeroQ[n-2*m] && Not[PositiveQ[a/b]]


(* ::Code:: *)
Int[x_^m_./(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,n/2]], s=Denominator[Rt[a/b,n/2]]},
  Dist[-2*(-r)^(m/2+1)/(a*n*s^(m/2)),Int[1/(r+s*x^2),x]] +
  Dist[4*r^(m/2+1)/(a*n*s^(m/2)),
	Int[Sum[(r*Cos[(2*k-1)*m*Pi/n]-s*Cos[(2*k-1)*(m+2)*Pi/n]*x^2)/
      (r^2-2*r*s*Cos[2*(2*k-1)*Pi/n]*x^2+s^2*x^4),{k,1,(n-2)/4}],x]]] /;
 FreeQ[{a,b},x] && IntegersQ[(n-2)/4,m/2] && 0<m<n && CoprimeQ[m+1,n] && PosQ[a/b]


(* ::Code:: *)
Int[x_^m_./(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,n/2]], s=Denominator[Rt[-a/b,n/2]]},
  Dist[2*r^(m/2+1)/(a*n*s^(m/2)),Int[1/(r-s*x^2),x]] +
  Dist[4*r^(m/2+1)/(a*n*s^(m/2)),
	Int[Sum[(r*Cos[2*k*m*Pi/n]-s*Cos[2*k*(m+2)*Pi/n]*x^2)/
      (r^2-2*r*s*Cos[4*k*Pi/n]*x^2+s^2*x^4),{k,1,(n-2)/4}],x]]] /;
 FreeQ[{a,b},x] && IntegersQ[(n-2)/4,m/2] && 0<m<n && CoprimeQ[m+1,n] && NegQ[a/b]


(* ::Code:: *)
Int[x_^m_./(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,n]], s=Denominator[Rt[a/b,n]]},
  Int[-(-r)^(m+1)/(a*n*s^m*(r+s*x)) +
    Sum[2*r^(m+1)*(r*Cos[(2*k-1)*m*Pi/n]-s*Cos[(2*k-1)*(m+1)*Pi/n]*x)/
      (a*n*s^m*(r^2-2*r*s*Cos[(2*k-1)*Pi/n]*x+s^2*x^2)),{k,1,(n-1)/2}],x]] /;
FreeQ[{a,b},x] && IntegersQ[(n-1)/2,m] && 0<m<n && CoprimeQ[m+1,n] && PosQ[a/b]


(* ::Code:: *)
Int[x_^m_./(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,n]], s=Denominator[Rt[-a/b,n]]},
  Int[r^(m+1)/(a*n*s^m*(r-s*x)) -
    Sum[2*(-r)^(m+1)*(r*Cos[(2*k-1)*m*Pi/n]+s*Cos[(2*k-1)*(m+1)*Pi/n]*x)/
      (a*n*s^m*(r^2+2*r*s*Cos[(2*k-1)*Pi/n]*x+s^2*x^2)),{k,1,(n-1)/2}],x]] /;
FreeQ[{a,b},x] && IntegersQ[(n-1)/2,m] && 0<m<n && CoprimeQ[m+1,n] && NegQ[a/b]


(* ::Code:: *)
Int[(c_.+d_.*x_^m_)/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[a/b,4]], s=Denominator[Rt[a/b,4]]},
  Dist[r/(2*Sqrt[2]*a*s),
    Int[(Sqrt[2]*c*r*s+(c*s^2-d*r^2)*x^(m/2))/(r^2+Sqrt[2]*r*s*x^(m/2)+s^2*x^m),x]] +
  Dist[r/(2*Sqrt[2]*a*s),
    Int[(Sqrt[2]*c*r*s-(c*s^2-d*r^2)*x^(m/2))/(r^2-Sqrt[2]*r*s*x^(m/2)+s^2*x^m),x]]] /;
FreeQ[{a,b,c,d},x] && IntegerQ[m/2] && m>0 && ZeroQ[n-2*m] && PosQ[a/b]


(* ::Code:: *)
Int[(c_.+d_.*x_^m_)/(a_+b_.*x_^n_),x_Symbol] :=
  Module[{r=Numerator[Rt[-a/b,2]], s=Denominator[Rt[-a/b,2]]},
  Dist[(c*s+d*r)/2, Int[1/(a*s+b*r*x^m),x]] +
  Dist[(c*s-d*r)/2, Int[1/(a*s-b*r*x^m),x]]] /;
FreeQ[{a,b,c,d},x] && IntegerQ[m/2] && m>0 && ZeroQ[n-2*m] && NegQ[a/b] && NonzeroQ[b*c^2+a*d^2]


(* ::Code:: *)
Int[(a_+b_.*x_^n_)^p_,x_Symbol] :=
  x*(a+b*x^n)^(p+1)/a /;
FreeQ[{a,b,n,p},x] && ZeroQ[n*(p+1)+1]


(* ::Code:: *)
Int[(a_+b_.*x_^n_)^p_,x_Symbol] :=
  -x*(a+b*x^n)^(p+1)/(a*n*(p+1)) +
  Dist[(n*(p+1)+1)/(a*n*(p+1)),Int[(a+b*x^n)^(p+1),x]] /;
FreeQ[{a,b},x] && IntegersQ[n,p] && n>1 && p<-1


(* ::Code:: *)
Int[x_^m_.*(a_+b_.*x_^n_)^p_,x_Symbol] :=
  x^(m+1)*(a+b*x^n)^(p+1)/(a*(m+1)) /;
FreeQ[{a,b,m,n,p},x] && ZeroQ[m+n*(p+1)+1] && NonzeroQ[m+1] && NonzeroQ[p+2]


(* ::Code:: *)
Int[x_^m_.*(a_+b_.*x_^n_)^p_,x_Symbol] :=
  x^(m-n+1)*(a+b*x^n)^(p+1)/(b*n*(p+1)) -
  Dist[(m-n+1)/(b*n*(p+1)),Int[x^(m-n)*(a+b*x^n)^(p+1),x]] /;
FreeQ[{a,b},x] && IntegersQ[m,n,p] && 1<n<=m<2*n-1 && p<-1


(* ::Code:: *)
Int[x_^m_.*(a_+b_.*x_^n_)^p_,x_Symbol] :=
  -x^(m+1)*(a+b*x^n)^(p+1)/(a*n*(p+1)) +
  Dist[(m+n*(p+1)+1)/(a*n*(p+1)),Int[x^m*(a+b*x^n)^(p+1),x]] /;
FreeQ[{a,b},x] && IntegersQ[m,n,p] && n>1 && 0<m+1<n && p<-1 && NonzeroQ[m+n*(p+1)+1]


(* ::Code:: *)
Int[x_^m_.*(a_+b_.*x_^n_)^p_,x_Symbol] :=
  x^(m+1)*(a+b*x^n)^(p+1)/(a*(m+1)) -
  Dist[b*(m+n*(p+1)+1)/(a*(m+1)),Int[x^(m+n)*(a+b*x^n)^p,x]] /;
FreeQ[{a,b},x] && IntegersQ[m,n,p,(m+n*(p+1)+1)/n] && m<-1 && n>0 &&
0<n-2(m+n*(p+1)+1)<n*p


(* ::Code:: *)
Int[x_^m_.*(a_+b_.*x_^n_)^p_,x_Symbol] :=
  x^(m-n+1)*(a+b*x^n)^(p+1)/(b*(m+n*p+1)) -
  Dist[a*(m-n+1)/(b*(m+n*p+1)),Int[x^(m-n)*(a+b*x^n)^p,x]] /;
FreeQ[{a,b},x] && IntegersQ[m,n,p,(m+1)/n] && NonzeroQ[m+n*p+1] && 
(m+1)/n>0 && 2*m/n<p+1 && 0<n<=m


(* ::Code:: *)
Int[x_^m_.*(a_+b_.*x_^n_.)^p_.,x_Symbol] :=
  Int[Expand[x^m*(a+b*x^n)^p],x] /;
FreeQ[{a,b,m,n},x] && IntegerQ[p] && p>0 && ExpandIntegrandQ[m,n,p]


(* ::Code:: *)
Int[(c_+d_.*x_)^m_.*(a_+b_.*(c_+d_.*x_)^n_)^p_,x_Symbol] :=
  (c+d*x)^(m-n+1)*(a+b*(c+d*x)^n)^(p+1)/(b*d*n*(p+1)) -
  Dist[(m-n+1)/(b*n*(p+1)),Int[(c+d*x)^(m-n)*(a+b*(c+d*x)^n)^(p+1),x]] /;
FreeQ[{a,b,c,d},x] && IntegersQ[m,n,p] && n>1 && p<-1 && n<=m<2*n-1


(* ::Code:: *)
Int[(a_+b_.*x_^n_.)^m_/(b_+a_.*x_^p_.),x_Symbol] :=
  Int[x^n*(a+b*x^n)^(m-1), x] /;
FreeQ[{a,b,m,n,p},x] && ZeroQ[n+p]


(* ::Code:: *)
Int[(a_.*x_^p_.+b_.*x_^q_.)^n_,x_Symbol] :=
  Int[x^(n*p)*(a+b*x^(q-p))^n,x] /;
FreeQ[{a,b,p,q},x] && IntegerQ[n] && Not[FractionQ[p]] && Not[FractionQ[q]] && Not[NegativeQ[q-p]]


(* ::Code:: *)
Int[x_^m_.*(a_.*x_^p_.+b_.*x_^q_.)^n_,x_Symbol] :=
  Int[x^(m+n*p)*(a+b*x^(q-p))^n,x] /;
FreeQ[{a,b,m,p,q},x] && IntegerQ[n] && 
Not[FractionQ[p]] && Not[FractionQ[q]] && Not[FractionQ[m]] && Not[NegativeQ[q-p]]
