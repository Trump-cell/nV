#pragma once
#include <nV/Graphics.h>

namespace nV {
	namespace Graphics {
#define ADD_POINT_ANGLE_CURVE_3D 0.05
#define MIN_DELTA_DIS_CURVE_3D 0.001

		class Curve3D {

		public:
			double spx, spy, spz, xmin, xmax, ymin, ymax, zmin, zmax;
			int dataNum;
			ArrayList<Point3d*> vert;

		public:
			virtual void creatCurve() = 0;
			~Curve3D();
		};
	}
}
