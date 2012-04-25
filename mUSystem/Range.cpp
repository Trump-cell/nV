#include "common.h"
#include <mU/Number.h>
#include <mU/System.h>
#include <mU/Kernel.h>
#include <mU/Exceptions.h>
#include <mU/utils.h>

using namespace mU;

CAPI CPROC_INT (System_Range, 3)
{
	//#define MAXIMUM_SIZE_OF_RANGE 10000	//Mathematica��û�д�С��飬ֱ�ӵ���ִ����Range[100000000]��ϵͳ����
	var x1 = At(x, 0), x2 = At(x, 1), x3 = At(x, 2);
	var s = Evalf(Eval(Optimi(Ex(TAG(Divide), Vec(Ex(TAG(Plus), Vec(Ex(TAG(Minus), Vec(x1)), x2)), x3)))));
			//Eval()�޷�����3/Pi�����Σ�NumQ(3/Pi)==false������Evalf������������ʱ���ֻ�����⣬�ʲ�ȡ��Ȩ��֮�ƣ�
			//ϣ���Ժ���Խ����ʽ��д��Ư��һ��
	if (NumQ(s)) {
		//assert(Compare(s,Int(sint(MAXIMUM_SIZE_OF_RANGE)))<=0);
		sint sn = static_cast<sint>(floor(N::D(s)))+1;
		size_t n = sn > 0 ? sn: 0;
		var r = Vec(n);
		for (uint i = 0; i < n; i++) {
			At(r, i) = Plus(x1, Times(Int(i), x3));
		}
		return r;
	}
	else
		return NULL;
}
