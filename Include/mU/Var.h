/* var_t
 *   |
 *   |-----|-----|-----|-----|-----|----|-----|
 * int_t rat_t flt_t str_t sym_t vec_t ex_t obj_t    
 *                                            |
 *                                      |-----|-----|
 *                                    tab_t pat_t complex_t
 * */

#pragma once
#include <climits>
#include <external/gmp.h>

namespace mU {
struct var_t;
typedef var_t* Var;
#ifndef _WIN32
	#define uint another_uint_type
#endif
typedef unsigned long uint;
typedef signed long sint;
typedef wchar_t wchar;
typedef const wchar* wcs;
#define __W(x) L ## x
#define _W(x) __W(x)
using std::string;
using std::wstring;
using std::istream;
using std::wistream;
using std::ostream;
using std::wostream;
using std::iostream;
using std::wiostream;
using std::istringstream;
using std::wistringstream;
using std::ostringstream;
using std::wostringstream;
using std::stringstream;
using std::wstringstream;
using std::ifstream;
using std::wifstream;
using std::ofstream;
using std::wofstream;
using std::fstream;
using std::wfstream;
using std::cin;
using std::wcin;
using std::cout;
using std::wcout;
using std::cerr;
using std::wcerr;
using std::ios;
using std::wios;
using std::endl;
using std::flush;
}

#ifdef _MSC_VER
#pragma comment(lib,"gmp")
#endif

#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>

inline std::size_t hash_value(const mU::Var &x)
{
	return reinterpret_cast<std::size_t>(x);
}

namespace stdext 
{
	template<typename T>
	class hash_set : public boost::unordered_set<T>
	{
	};

	template<typename TKey, typename TValue>
	class hash_map : public boost::unordered_map<TKey, TValue>
	{
	};
}

#undef DLL
#ifdef _WIN32
#ifdef MUKERNEL_EXPORTS
#define DLL __declspec(dllexport)
#else
#define DLL __declspec(dllimport)
#pragma comment(lib,"mUKernel")
#endif
#else
#define DLL
#endif

#undef API
#define API DLL extern
#undef CAPI
#ifdef _WIN32
#define CAPI extern "C" __declspec(dllexport)
#else
#define CAPI extern "C"
#endif

namespace mU {
//////////////////////////////////////
/*!
 * \brief
 * 变量基类
 *
 * \remarks
 * 默认采用句柄型复制控制，可覆盖为值型复制控制。
 */
#define TYPE(x) type_##x
enum type_t
{
	type_null = -1,
	type_int = 0,type_rat,type_flt,type_str,
	type_sym,type_obj,type_vec,type_ex
};

const size_t TYPE_BITS = 3;
const size_t TYPE_SIZE = 1 << TYPE_BITS;
const size_t TYPE_MASK = TYPE_SIZE - 1;

struct var_t
{
private:
	size_t type : TYPE_BITS;
	size_t refcount : sizeof(size_t) * CHAR_BIT - TYPE_BITS;

public:
	var_t(type_t t) : type(t), refcount(0) {}
	virtual ~var_t() {}

	friend type_t Type(Var x);
	friend void intrusive_ptr_add_ref(var_t *);
	friend void intrusive_ptr_release(var_t *);
};
inline type_t Type(Var x)
{
	return x ? static_cast<type_t>(x->type) : TYPE(null);
}

inline void intrusive_ptr_add_ref(var_t *pv)
{
	++(pv->refcount);
}

inline void intrusive_ptr_release(var_t *pv)
{
	--(pv->refcount);
	if (pv->refcount == 0)
	{
		delete pv;
	}
}

/*!
 * \brief
 * 句柄
 *
 * \remarks
 * 为指针Var提供自动复制控制，便于标准库容器使用。
 */

class var
{
private:
	boost::intrusive_ptr<var_t> ptr;
public:
	var() : ptr(0) {}
	var(var_t *x) : ptr(x) {}
	var(const var &x) : ptr(x.ptr) {}
	Var operator =(var_t *x) { ptr = x; return ptr.get(); }
	Var operator =(const var &x) { ptr = x.ptr; return ptr.get(); }
	~var() {}
	operator Var() const { return ptr.get(); }
	Var get() const { return ptr.get(); }
	Var operator ->() const { return ptr.operator->(); }
};

//////////////////////////////////////
/*!
* \brief
* 对象
*
* \remarks
* 为其他对象提供自动内存管理。
*/
struct obj_t : var_t
{
//	static void ruin(Var x) { delete (obj_t*)x; }
	obj_t() : var_t(TYPE(obj)) {}
	virtual ~obj_t() {}
	virtual var tag() { return this; }
	virtual var normal() { return this; }
	virtual void print(wostream &f) { f << this; }
};
template <class T>
inline T& CObj(Var x) {
	return reinterpret_cast<T&>(*reinterpret_cast<obj_t*>(x));
}
inline bool ObjQ(Var x) { return Type(x) == TYPE(obj); }
inline bool ObjQ(Var x, Var y) { return ObjQ(x) && CObj<obj_t>(x).tag() == y; }

/*!
* \brief
* 整数
*
* \remarks
* mpz_t
*/
struct int_t : var_t
{
//	static void ruin(Var x) { mpz_clear(INT_REP(x)); delete (int_t*)x; }
	int_t() : var_t(TYPE(int)) { mpz_init(rep); }
	int_t(Var x);
	int_t(uint x) : var_t(TYPE(int)) { mpz_init_set_ui(rep,x); }
	//int_t(std::size_t x) : var_t(TYPE(int)) { mpz_init_set_ui(rep, static_cast<mU::uint>(x)); }
	int_t(sint x) : var_t(TYPE(int)) { mpz_init_set_si(rep,x); }
	int_t(double x) : var_t(TYPE(int)) { mpz_init_set_d(rep,x); }
	int_t(const char *x,int y) : var_t(TYPE(int)) { mpz_init_set_str(rep,x,y); }
	virtual ~int_t();
	typedef mpz_t rep_t;
	rep_t rep;
};
inline mpz_t &INT_REP(var_t *x)
{
	return reinterpret_cast<int_t*>(x)->rep;
}
inline int_t::int_t(Var x) : var_t(TYPE(int))
{
	mpz_init_set(rep,INT_REP(x));
}
inline int_t::~int_t()
{
	mpz_clear(INT_REP(this));
}
inline bool IntQ(Var x) { return Type(x) == TYPE(int); }
inline var Int() { return new int_t; }
// TODO: can we resolve the ambiguity in the call Int(1)?
template <typename T>
inline var Int(const T& x) { return new int_t(x); }
inline var Int(const char *x, int y) { return new int_t(x,y); }
inline int_t::rep_t& CInt(Var x) { return INT_REP(x); }

/*!
* \brief
* 有理数
*
* \remarks
* mpq_t
*/
struct rat_t : var_t
{
//	static void ruin(Var x) { mpq_clear(RAT_REP(x)); delete (rat_t*)x; }
	virtual ~rat_t() { mpq_clear(rep); }
	rat_t() : var_t(TYPE(rat)) { mpq_init(rep); }
	typedef mpq_t rep_t;
	rep_t rep;
};
inline rat_t::rep_t &RAT_REP(Var x)
{
	return reinterpret_cast<rat_t*>(x)->rep;
}
inline rat_t::rep_t &RAT_REP(const var &x)
{
	return reinterpret_cast<rat_t*>(x.get())->rep;
}
inline bool RatQ(Var x) { return Type(x) == TYPE(rat); }
inline var Rat() { return new rat_t; }
inline var Rat(Var x)
{
	var r = Rat();
	mpq_set(RAT_REP(r),RAT_REP(x));
	return r;
}
inline var Rat(uint x, uint y)
{
	var r = Rat();
	mpq_set_ui(RAT_REP(r),x,y);
	return r;
}
inline var Rat(sint x, uint y)
{
	var r = Rat();
	mpq_set_si(RAT_REP(r),x,y);
	return r;
}
inline var Rat(double x)
{
	var r = Rat();
	mpq_set_d(RAT_REP(r),x);
	return r;
}
inline var Rat(const char *x, int y)
{
	var r = Rat();
	mpq_set_str(RAT_REP(r),x,y);
	return r;
}
inline rat_t::rep_t& CRat(Var x) { return RAT_REP(x); }

/*!
* \brief
* 浮点数
*
* \remarks
* mpf_t
*/
struct flt_t : var_t
{
//	static void ruin(Var x) { mpf_clear(FLT_REP(x)); delete (flt_t*)x; }
	flt_t() : var_t(TYPE(flt)) { mpf_init(rep); }
	flt_t(Var x);
	flt_t(uint x) : var_t(TYPE(flt)) { mpf_init_set_ui(rep,x); }
	flt_t(sint x) : var_t(TYPE(flt)) { mpf_init_set_si(rep,x); }
	flt_t(double x) : var_t(TYPE(flt)) { mpf_init_set_d(rep,x); }
	flt_t(const char *x,int y) : var_t(TYPE(flt)) { mpf_init_set_str(rep,x,y); }
	virtual ~flt_t() { mpf_clear(rep); }
	typedef mpf_t rep_t;
	rep_t rep;
};
inline flt_t::rep_t &FLT_REP(Var x)
{
	return reinterpret_cast<flt_t*>(x)->rep;
}
inline flt_t::flt_t(Var x) : var_t(TYPE(flt))
{
	mpf_init_set(rep,FLT_REP(x));
}
inline bool FltQ(Var x) { return Type(x) == TYPE(flt); }
inline var Flt() { return new flt_t; }
template <typename T>
inline var Flt(const T& x) { return new flt_t(x); }
inline var Flt(const char *x, int y) { return new flt_t(x,y); }
inline flt_t::rep_t& CFlt(Var x) { return FLT_REP(x); }

/*!
* \brief
* 字符串
*
* \remarks
* wstring
*/
struct str_t : var_t
{
//	static void ruin(Var x) { delete (str_t*)x; }
	str_t() : var_t(TYPE(str)) {}
	str_t(Var x);
	str_t(const wchar *x) : var_t(TYPE(str)),rep(x) {}
	str_t(const wstring &x) : var_t(TYPE(str)),rep(x) {}
	typedef wstring rep_t;
	rep_t rep;
};
inline str_t::rep_t &STR_REP(Var x)
{
	return reinterpret_cast<str_t*>(x)->rep;
}
inline str_t::str_t(Var x) : var_t(TYPE(str)),rep(STR_REP(x)) {}
inline bool StrQ(Var x) { return Type(x) == TYPE(str); }
inline var Str() { return new str_t; }
template <typename T>
inline var Str(const T& x) { return new str_t(x); }
inline str_t::rep_t& CStr(Var x) { return STR_REP(x); }

/*!
* \brief
* 符号表“上下文（context）”
*
* \remark
* 存储从符号名称到符号sym_t变量的映射关系
*/
struct tab_t : obj_t
{
	typedef stdext::hash_map<wstring,var> rep_t;
	rep_t rep;
};
inline tab_t::rep_t &TAB_REP(Var x)
{
	return reinterpret_cast<tab_t*>(x)->rep;
}
inline var Tab() { return new tab_t; }
inline tab_t::rep_t& CTab(Var x) { return TAB_REP(x); }

/*!
 * \brief
 * 符号
 *
 * \remarks
 * 仅存储符号名称及符号所属的“上下文（context）”
 */
struct sym_t : var_t
{
//	static void ruin(Var x) { delete (sym_t*)x; }
	sym_t(const wchar *x,Var y) : var_t(TYPE(sym)),rep(x,y) {}
	typedef std::pair<const wchar*,Var> rep_t;
	rep_t rep;
};
inline sym_t::rep_t &SYM_REP(Var x)
{
	return reinterpret_cast<sym_t*>(x)->rep;
}
inline bool SymQ(Var x) { return Type(x) == TYPE(sym); }
template <typename T>
inline var Sym(const T& x, Var y)
{
	std::pair<tab_t::rep_t::iterator,bool>
		iter = CTab(y).insert(
		tab_t::rep_t::value_type(x,var()));
	if(iter.second)
		iter.first->second = new sym_t(
		iter.first->first.c_str(),y);
	return iter.first->second;
}
inline const wchar*& Name(Var x) { return SYM_REP(x).first; }
inline Var& Context(Var x) { return SYM_REP(x).second; }
inline sym_t::rep_t& CSym(Var x) { return SYM_REP(x); }
API var
Global, System, Null, True, False, Nil, Aborted, Failed;

/*!
* \brief
* 向量
*
* \remarks
* 包装标准库vector以形成广义表嵌套结构，表达式以其为主体。
*
* \see
* ex_t
*/
struct vec_t : var_t
{
//	static void ruin(Var x) { delete (vec_t*)x; }
	vec_t() : var_t(TYPE(vec)) {}
	vec_t(size_t n) : var_t(TYPE(vec)),rep(n) {}
	typedef std::vector<var> rep_t;
	rep_t rep;
};
inline vec_t::rep_t &VEC_REP(Var x)
{
	return reinterpret_cast<vec_t*>(x)->rep;
}
inline bool VecQ(Var x) { return Type(x) == TYPE(vec); }
inline var Vec() { return new vec_t; }
inline var Vec(size_t n) { return new vec_t(n); }
inline var Vec(Var a)
{
	std::auto_ptr<vec_t> r(new vec_t(1));
	r->rep[0] = a;
	return r.release();
}
inline var Vec(Var a, Var b)
{
	std::auto_ptr<vec_t> r(new vec_t(2));
	r->rep[0] = a;
	r->rep[1] = b;
	return r.release();
}
inline var Vec(Var a, Var b, Var c)
{
	std::auto_ptr<vec_t> r(new vec_t(3));
	r->rep[0] = a;
	r->rep[1] = b;
	r->rep[2] = c;
	return r.release();
}
inline var Vec(Var a, Var b, Var c, Var d)
{
	std::auto_ptr<vec_t> r(new vec_t(4));
	r->rep[0] = a;
	r->rep[1] = b;
	r->rep[2] = c;
	r->rep[3] = d;
	return r.release();
}
inline var& At(Var x, size_t y) { return VEC_REP(x)[y]; }
inline size_t Size(Var x) { return VEC_REP(x).size(); }
inline void Resize(Var x, size_t y) { VEC_REP(x).resize(y); }
inline void Reserve(Var x, size_t y) { VEC_REP(x).reserve(y); }
inline void Push(Var x, Var y) { VEC_REP(x).push_back(y); }
inline void Pop(Var x) { VEC_REP(x).pop_back(); }
inline var& Top(Var x) { return VEC_REP(x).back(); }
inline vec_t::rep_t& CVec(Var x) { return VEC_REP(x); }
inline bool ListQ(Var x) { return Type(x) == TYPE(vec); }

/*!
* \brief
* 表达式
*
* \remarks
* 包括head与向量构成的body两部分，注意head也可能为表达式。
*
* \see
* vec_t
*/
struct ex_t : var_t
{
//	static void ruin(Var x) { delete (ex_t*)x; }
	virtual ~ex_t() {}
	ex_t(Var x, Var y) : var_t(TYPE(ex)),rep(x,y) {}
	typedef std::pair<var,var> rep_t;
	rep_t rep;
};
inline ex_t::rep_t &EX_REP(Var x)
{
	return reinterpret_cast<ex_t*>(x)->rep;
}
inline var& Head(Var x) { return EX_REP(x).first; }
inline var& Body(Var x) { return EX_REP(x).second; }
inline bool ExQ(Var x) { return Type(x) == TYPE(ex); }
inline bool ExQ(Var x, Var y) { return ExQ(x) && Head(x) == y; }
inline var Ex(Var x, Var y) { return new ex_t(x,y); }
inline size_t Len(Var x) { return CVec(Body(x)).size(); }
inline var& Left(Var x) { return CVec(Body(x)).front(); }
inline var& Right(Var x) { return CVec(Body(x)).back(); }
inline var& Part(Var x, size_t y) { return CVec(Body(x))[y]; }
inline ex_t::rep_t& CEx(Var x) { return EX_REP(x); }

// FIXME: check all references to NumQ, see if they should use NumberQ instead
inline bool NumQ(Var x)
{
	switch(Type(x))
	{
	case TYPE(int):
	case TYPE(rat):
	case TYPE(flt):
		return true;
    default:
        return false;
	}
}

inline bool AtomQ(Var x)
{
	switch(Type(x))
	{
	case TYPE(vec):
	case TYPE(ex):
		return false;
    default:
        return true;
	}
}
//////////////////////////////////////
}
