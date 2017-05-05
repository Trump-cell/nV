CInstall["mulink"]

Begin["nV`"]

CProc["mulink",`nV,`Eval,`Main,`mU];

End[]

Begin["System`"]

{Graphics2D, Graphics3D, Shape, GraphicsComplex, PlotRange, Polygon, FlatSpace, Color3f, Color255, Axes, Auto, ColorFunction, FillToCurve, FillToAxes, GraphLabel, True, Mesh, DoubleSurface, Surface, LightedSurface, ColorfulLine, PointList, QuadArray, TriangleArray, Curve, Real, Integer, Minus, ColorPolygon, AxesLabel, GraphLabel, Joined, NoFilling, Line, Options, NormalSpace, Hue, Directive, ColorPolygon}

nV`$ImportFunctions = {FactorInteger, Expand, PolynomialGCD, FactorList, Factor, PolynomialLCM, Collect, CharacterSet, PolynomialRemainder, PolynomialQuotient, PolynomialQuotientRemainder, Plot, ListPlot, DiscretePlot, Plot3D, ParametricPlot, PolarPlot, ContourPlot, ParametricRegionPlot, ContourPlot3D, ParametricPlot3D, DensityPlot, ParametricSurfacePlot3D}

End[]

Do[f[args__]:=nV`mU@nV`Eval@nV`nV[f][args],{f,nV`$ImportFunctions}]

Attributes[Plot] = {HoldAll}
Attributes[ListPlot] = {HoldAll}
Attributes[DiscretePlot] = {HoldAll}
Attributes[Plot3D] = {HoldAll}
Attributes[ParametricPlot] = {HoldAll}
Attributes[PolarPlot] = {HoldAll}
Attributes[ContourPlot] = {HoldAll}
Attributes[ParametricRegionPlot] = {HoldAll}
Attributes[ContourPlot3D] = {HoldAll}
Attributes[ParametricPlot3D] = {HoldAll}
Attributes[DensityPlot] = {HoldAll}
Attributes[ParametricSurfacePlot3D] = {HoldAll}