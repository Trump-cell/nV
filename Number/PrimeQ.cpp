#include "StdAfx.h"
/** \file
\brief ���Լ��.
*/
#include <nV/Number.h>

namespace nV {
namespace Number {

/** \brief �ж�\f$n\f$�Ƿ�Ϊ����.
	\param n ����.
	\retval >0 ��.
	\retval 0 ��.
	\note ʹ��Rabin-Millerǿα�������.
*/
bool PrimeQ(const Integer& x) {
    return mpz_probab_prime_p(x.mpz, 10) > 0;
}

/** \brief �����\f$n\f$�ĵ�һ������.
	\param n ����.
	\return ����\f$n\f$�ĵ�һ������.
	\todo �������ж�.
*/
var NextPrime(const Integer& x) {
    /*if (mpz_cmp_ui(x.mpz, 1) <= 0 && mpz_cmp_si(x.mpz, -2) >= 0)
    	return new Integer(2L);
    if (mpz_cmp_ui(x.mpz, -3) == 0)
    	return new Integer(-3L);
    Integer* r = new Integer();
    if (EvenQ(x))
    	mpz_add_ui(r->mpz, x.mpz, 1);
    while (1) {
    	if (PrimeQ(*r))
    		return r;
    	else
    		mpz_add_ui(r->mpz, r->mpz, 1);
    }
    */
    Integer* r = new Integer();
    mpz_nextprime(r->mpz, x.mpz);
    return r;
}

/** \brief ������\f$n\f$��\f$b\f$���Ʊ�ʾ�µĳ���.
	\param n ����.
	\param b 2 - 62.
	\return ������\f$b\f$���Ʊ�ʾ�µĳ���.
*/
uint IntegerLength(const Integer& x, uint y) {
    return mpz_sizeinbase(x.mpz, y);
}

/** \brief ����\f$n\f$��\f$2^k\f$λΪ1.
	\param n ����.
	\param k �Ǹ�����.
	\return ����\f$n\f$��\f$2^k\f$λΪ1.
*/
var BitSet(const Integer& x, uint y) {
    Integer* r = new Integer(x);
    mpz_setbit(r->mpz, y);
    return r;
}

/** \brief ����\f$n\f$��\f$2^k\f$λΪ0.
\param n ����.
\param k �Ǹ�����.
\return ����\f$n\f$��\f$2^k\f$λΪ0.
*/
var BitClear(const Integer& x, uint y) {
    Integer* r = new Integer(x);
    mpz_clrbit(r->mpz, y);
    return r;
}

/** \brief ��\f$n\f$��\f$2^k\f$λ.
\param n, k ������.
\return \f$n\f$��\f$2^k\f$λ.
*/
bool BitGet(const Integer& x, uint y) {
    return mpz_tstbit(x.mpz, y) != 0;
}

/** \brief �ж�һ�������Ƿ�Ϊ����.
	\param n ����.
	\retval 1 ��.
	\retval 0 ��.
*/
bool OddQ(const Integer& x) {
    return mpz_odd_p(x.mpz) != 0;
}

/** \brief �ж�һ�������Ƿ�Ϊż��.
	\param n ����.
	\retval 1 ��.
	\retval 0 ��.
*/
bool EvenQ(const Integer& x) {
    return mpz_even_p(x.mpz) != 0;
}

/** \brief �������ľ���ֵ.
	\param n ����
	\return n�ľ���ֵ.
*/
var Abs(const Integer& x) {
    Integer* r = new Integer();
    mpz_abs(r->mpz, x.mpz);
    return r;
}

/** \brief ������ƽ��.
	\param n ����.
	\return ƽ��������������\f$\lfloor\sqrt{n}\rfloor\f$.
	\note ʹ��Karatsubaƽ�����㷨.
	\todo �����ĵ�.
*/
var Sqrt(const Integer& x) {
    Integer* r = new Integer();
    mpz_sqrt(r->mpz, x.mpz);
    return r;
}

/** \brief �ж�һ�������Ƿ�Ϊ��ȫƽ����.
	\param n ��������.
	\retval 1 ��.
	\retval 0 ��.
	\note ʹ��\f$\mathbb{Z}/k\mathbb{Z}\f$��ƽ��������.
	��256��45��17��13��7Ϊģ, ����99.25%, ʹ�û��д��mpn_mod_34lsub1����.
*/
bool SquareQ(const Integer& x) {
    return mpz_perfect_square_p(x.mpz) != 0;
}
}
}

using namespace nV;

CAPI void CVALUE(System, PrimeQ)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 2 || !x[1].isObject($.Integer))
        return;
    r = boolean(Number::PrimeQ(x[1].cast<Integer>()));
}
CAPI void CVALUE(System, OddQ)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 2 || !x[1].isObject($.Integer))
        return;
    r = boolean(Number::OddQ(x[1].cast<Integer>()));
}
CAPI void CVALUE(System, EvenQ)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 2 || !x[1].isObject($.Integer))
        return;
    r = boolean(Number::EvenQ(x[1].cast<Integer>()));
}
CAPI void CVALUE(System, SquareQ)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 2 || !x[1].isObject($.Integer))
        return;
    r = boolean(Number::SquareQ(x[1].cast<Integer>()));
}
CAPI void CVALUE(System, NextPrime)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 2 || !x[1].isObject($.Integer))
        return;
    r = Number::NextPrime(x[1].cast<Integer>());
}
CAPI void CVALUE(System, IntegerLength)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 3 || !x[1].isObject($.Integer) || !x[2].isObject($.Integer))
        return;
    r = new Integer(Number::IntegerLength(x[1].cast<Integer>(), mpz_get_ui(x[2].cast<Integer>().mpz)));
}