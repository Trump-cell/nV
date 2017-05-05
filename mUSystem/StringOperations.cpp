#include "common.h"
#include <mU/Number.h>
#include <mU/String.h>
#include <mU/System.h>
#include <mU/Kernel.h>
#include <mU/Exceptions.h>
#include <mU/utils.h>
#include "PartSpec.h"

using namespace mU;

CAPI CPROC(System_StringLength)
{
	if(StrQ(At(x,0))) return Int(S::Length(At(x,0)));
	return 0;
}
CAPI CPROC(System_StringInsert)
{
	var c = At(x,0);
	if(StrQ(c))
	{
		mU::uint n = S::Length(c);
		var r = Str();
		CStr(r) = CStr(c);
		if(Size(x) > 2 && StrQ(At(x,1)) && IntQ(At(x,2)))
		{
			int a = Z::SI(At(x,2));
			a < 0 ? a += n : --a;
			if(a < 0 || a >= n)
				return r;
			S::Insert(r,At(x,1),a);
			return r;
		}
	}
	return 0;
}
CAPI CPROC(System_StringTake)
{
	var c = At(x,0);
	if(StrQ(c))
	{
		mU::uint n = S::Length(c);
		var d = At(x,1);
		if(VecQ(d))
		{
			int a = Z::SI(At(d,0));
			a < 0 ? a += n : --a;
			if(a < 0 || a >= n)
				return c;
			if(Size(d) > 1)
			{
				int b = Z::SI(At(d,1));
				b < 0 ? b += n : --b;
				if(b < 0 || b >= n)
					return c;
				return S::Substr(c,a,b < a ? 0 : b - a + 1);
			}
			else
				return S::Substr(c,a,1);
		}
		else if(IntQ(d))
		{
			int a = Z::SI(d);
			return a < 0 ? S::Substr(c,a + n,-a) : S::Substr(c,0,a);
		}
	}
	return 0;
}
/*
CAPI CPROC(System_StringDrop)
{
	var c = At(x,0);
	if(StrQ(c))
	{
		mU::uint n = S::Length(c);
		var r = Str();
		CStr(r) = CStr(c);
		var d = At(x,1);
		if(VecQ(d))
		{
			int a = Z::SI(At(d,0));
			a < 0 ? a += n : --a;
			if(a < 0 || a >= n)
				return r;
			if(Size(d) > 1)
			{
				int b = Z::SI(At(d,1));
				b < 0 ? b += n : --b;
				if(b < 0 || b >= n)
					return r;
				S::Erase(r,a,b < a ? 0 : b - a + 1);
			}
			else
				S::Erase(r,a,1);
		}
		else if(IntQ(d))
		{
			int a = Z::SI(d);
			a < 0 ? S::Erase(r,a + n,-a) : S::Erase(r,0,a);
		}
		return r;
	}
	return 0;
}
*/
var StringDrop_uni_str(Var x)
{
	SequenceSpec s(x, 1);
	var c = At(x, 0);
	assert (StrQ(c));

	SequenceSpec::LevelIterator iter(s, S::Length(c), 0);
	var r = Str();
	CStr(r) = CStr(c);
	size_t p=0;
	while (iter.has_next())
	{
		S::Erase(r,iter.next()-(++p),1);
	}
	var d = At(x,1);
	return r;
}

CAPI CPROC(System_StringDrop)
{
	var c = At(x,0);
	if (StrQ(c))
		return StringDrop_uni_str(x);
	else if (VecQ(c))
	{
		size_t i;
		var y = x, r(Vec());
		for (i = 0; i < Size(c); i++)
		{
			At(y,0)=At(c,i);
			Push(r, StringDrop_uni_str(y));	//这条语句是否安全？
		}
		return r;
	}
	return 0;
}

//基本实现了Mathematica样例中的功能，除了由于转义字符功能不够完善，执行以下代码：
// StringDrop["\[FilledDiamond]\[Alpha]\[Beta]\[Gamma]\[LongLeftRightArrow]\[ScriptCapitalA]\[ScriptCapitalB]\[ScriptCapitalC]\[ReturnIndicator]", -4]
//出现如下结果：
//\:25c6
//并且程序崩溃

bool StringMatch_1(Var s, Var sub, uint n)
{
	assert (StrQ(s) && StrQ(sub));
	return (S::Cmp(s, n, S::Length(sub), sub)==0);
}

var StringReplace_uni_str(Var c, Var rul, uint step)
{
	assert (StrQ(c));
	if (step < 0) step = 0;

	var l = Str(), r = Str(), s = c, v, p;
	uint count = 0;
	if (ExQ(rul, TAG(Rule)))
		v = Vec(rul);
	else
		v = rul;
	if (VecQ(v))
	{
		size_t i; uint j;
		for (j = 0; (j < S::Length(s)) && ((step == 0) || (count < step)); j++)
		{
			for (i = 0; i < Size(v); i++)
			{
				p = Body(At(v,i));
				l = At(p, 0); r = At(p, 1);
				if (StringMatch_1(s, l, j))
				{
					S::Erase(s, j, S::Length(l));
					S::Insert(s, r, j);
					j += (S::Length(r) - 1);
					count++;
					break;
				}
			}
		}
	}
	return s;
}

CPROC_INT2_OPT(System_StringReplace, 2, 3, (IgnoreCase, False))
{
	var c = At(x, 0);
	uint step = 0;
	//FIXME: Merely simple substring exchanging.
	//FIXME: IgnoreCase unconsidered.
	if (Size(x) == 3)
		if (!IntQ(At(x, 2)))
			throw LogicError(L"the 3rd argument to StringReplace should be an non-negative integer");
		else
			step = Z::UI(At(x, 2));
	if (StrQ(c))
		return StringReplace_uni_str(c, At(x, 1), step);
	else if (VecQ(c))
	{
		size_t i;
		var y = x, r(Vec());
		for (i = 0; i < Size(c); i++)
		{
			Push(r, StringReplace_uni_str(At(c, i), At(x, 1), step));	//这条语句是否安全？
		}
		return r;
	}
	return 0;
}

//对于最基本的子串替换，实现情况良好。
//包括多个字符串的情形，以及限制替换次数的情形。
//尚不支持任何字符串模式
