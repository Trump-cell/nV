#include "StdAfx.h"
/** \file
\brief �������ۺ���.
*/
#include <nV/Number.h>

namespace nV {
namespace Number {
/** \brief ����ģ��

�����������ۺ���.
*/

gmp_randstate_t rstate; /**< ���״̬����. */

/** \brief �������ʼ��.
	\note ���ڵ���::RandomInteger֮ǰִ��.
*/
void Randomize() {
    gmp_randinit_default(rstate);
    gmp_randseed_ui(rstate, static_cast<uint>(time(NULL)));
}

/** \brief ʹ��\f$n\f$��Ϊ������������������������.
	\param n ����.
*/
void SeedRandom(const Integer& x) {
    gmp_randseed(rstate, x.mpz);
}

/** \brief ʹ��ϵͳʱ����Ϊ������������������������.
*/
void SeedRandom() {
    gmp_randseed_ui(rstate, static_cast<uint>(time(NULL)));
}

/** \brief �����������.
	\param n ������.
	\return 0��n֮��һ�·ֲ��������.
	\param {a,b} ��������.
	\return a��b֮��һ�·ֲ��������.
	\note ����ִ��::Randomize.
	\todo �жϽ�.
*/
var RandomInteger(const Integer& x) {
    Integer* r = new Integer();
    mpz_urandomm(r->mpz, rstate, x.mpz);
    return r;
}
var RandomInteger(uint x) {
    mpz_t $x;
    mpz_init_set_ui($x, x);
    Integer* r = new Integer();
    mpz_urandomm(r->mpz, rstate, $x);
    mpz_clear($x);
    return r;
}
var RandomInteger(const Integer& x, const Integer& y) {
    mpz_t diff;
    mpz_init(diff);
    mpz_sub(diff, y.mpz, x.mpz);
    Integer* r = new Integer();
    mpz_urandomm(r->mpz, rstate, diff);
    mpz_add(r->mpz, r->mpz, x.mpz);
    return r;
}

/** \brief �����������.
\param n ����1������.
\return 0��n֮��һ�·ֲ����������.
\param {a,b} ������������������.
\return a��b֮��һ�·ֲ����������.
\note ����ִ��::Randomize.
\todo �жϽ�.
*/
var RandomPrime(const Integer& x) {
    var r = RandomInteger(x);
    Integer& m = Z(r);
    if (EvenQ(m) && mpz_cmp_ui(m.mpz, 2))
        mpz_sub_ui(m.mpz, m.mpz, 1);
    while (mpz_cmp(m.mpz, x.mpz) <= 0 ) {
        if (PrimeQ(m))
            return r;
        else
            mpz_add_ui(m.mpz, m.mpz, 2);
    }
    return $.Fail;
}
var RandomPrime(const Integer& x, const Integer& y) {
    var r = RandomInteger(x, y);
    Integer& m = Z(r);
    if (EvenQ(m) && mpz_cmp_ui(m.mpz, 2))
        mpz_sub_ui(m.mpz, m.mpz, 1);
    while (mpz_cmp(x.mpz, m.mpz) <= 0 && mpz_cmp(y.mpz, m.mpz) >= 0) {
        if (PrimeQ(m))
            return r;
        else
            mpz_add_ui(m.mpz, m.mpz, 2);
    }
    return $.Fail;
}
}
}

using namespace nV;

CAPI void CVALUE(System, RandomInteger)(Kernel& k, var& r, Tuple& x) {
    if (x.size == 2 && x[1].isObject($.Integer)) {
        r = Number::RandomInteger(Z(x[1]));
        return;
    }
    if (x.size == 3 && x[1].isObject($.Integer) && x[2].isObject($.Integer)) {
        r = Number::RandomInteger(Z(x[1]), Z(x[2]));
        return;
    }
}
CAPI void CVALUE(System, RandomPrime)(Kernel& k, var& r, Tuple& x) {
    if (x.size == 2 && x[1].isObject($.Integer)) {
        r = Number::RandomPrime(Z(x[1]));
        return;
    }
    if (x.size == 3 && x[1].isObject($.Integer) && x[2].isObject($.Integer)) {
        r = Number::RandomPrime(Z(x[1]), Z(x[2]));
        return;
    }
}