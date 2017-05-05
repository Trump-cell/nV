BeginPackage["Product`"]
Begin["`Private`"]
DownValuesDefaultType[0]
A[i_, {i_, n_}] := n!
A[i_, {i_, m_, n_}] := n! / (m - 1)!
A[i_^e_, {i_, n_}] := (n!)^e
A[i_^e_, {i_, m_, n_}] := (n! / (m - 1)!)^e
A[1 - (4 x_^2) / (Pi^2 (2k_-1)^2),{k_,1,Infinity}]:=Cos[x]
DownValuesDefaultType[1]
End[]
SetAttributes[Product, {HoldFirst}]
Product := `Private`A;
EndPackage[]