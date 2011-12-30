#include "common.h"
/** \file
\brief ������Ӽ����ؼ��.
*/
#include <nV/Number.h>

namespace nV {
namespace Number {

/** \brief �ж����������Ƿ���.
\param n1,n2 ����.
\retval 1 ��.
\retval 0 ��.
*/
bool CoprimeQ(const Integer& x, const Integer& y) {
    return mpz_cmp_ui(GCD(x, y).cast<Integer>().mpz, 1) == 0;
}

/** \brief �ж�\f$m\f$�Ƿ�������\f$n\f$.
	\param n ����.
	\param m ��������.
	\retval 1 ��.
	\retval 0 ��.
	\todo �ж�m����.
*/
bool Divisible(const Integer& x, const Integer& y) {
    if (mpz_fits_uint_p(y.mpz)) {
        return mpz_divisible_ui_p(x.mpz, mpz_get_ui(y.mpz)) != 0;
    } else {
        return mpz_divisible_p(x.mpz, y.mpz) != 0;
    }
}
bool Divisible(const Integer& x, uint y) {
    return mpz_divisible_ui_p(x.mpz, y) != 0;
}

var DivideExact(const Integer& x, const Integer& y) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(y.mpz)) {
        mpz_divexact_ui(r->mpz, x.mpz, mpz_get_ui(y.mpz));
    } else {
        mpz_divexact(r->mpz, x.mpz, y.mpz);
    }
    return r;
}
var DivideExact(const Integer& x, uint y) {
    Integer* r = new Integer();
    mpz_divexact_ui(r->mpz, x.mpz, y);
    return r;
}

/** \brief ��\f$m\f$����\f$n\f$����.
	\param m ����.
	\param n ��������.
	\return ��\f$\lfloor m/n\rfloor\f$.
	\todo ���ӷ����ж�, ���ӷ���������.
	\todo ��Ҫ�ĵ�����.
*/
var Quotient(const Integer& x, const Integer& y) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(y.mpz)) {
        mpz_div_ui(r->mpz, x.mpz, mpz_get_ui(y.mpz));
    } else {
        mpz_div(r->mpz, x.mpz, y.mpz);
    }
    return r;
}

/** \brief ��\f$m\f$����\f$n\f$����(��֪\f$n\f$����\f$m\f$).
	\param m ����.
	\param n ��������.
	\return \f$m/n\f$.
*/
var ExactQuotient(const Integer& x, uint y) {
    Integer* r = new Integer();
    mpz_divexact_ui(r->mpz, x.mpz, y);
    return r;
}

/** \brief ��\f$m\f$����\f$n\f$������.
	\param m ����.
	\param n ��������.
	\return ����\f$m \bmod n\f$.
	\note
	\todo ���ӷ����ж�, ���ӷ���������.
	\todo ��Ҫ�ĵ�����.
*/
var Mod(const Integer& x, const Integer& y) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(y.mpz)) {
        mpz_mod_ui(r->mpz, x.mpz, mpz_get_ui(y.mpz));
    } else {
        mpz_mod(r->mpz, x.mpz, y.mpz);
    }
    return r;
}
	//|r|<=|y|/2
var Mod2(const Integer& x, const Integer& y) {
	var r=Mod(x,y);
	mpz_t y_half;
	mpz_init(y_half);
	mpz_div_ui(y_half,y.mpz,2);
	mpz_abs(y_half,y_half);
	if(mpz_cmp(Z(r).mpz,y_half)>0){
		mpz_sub(Z(r).mpz,Z(r).mpz,y.mpz);
	}
	mpz_clear(y_half);
	return r;
}
/** \brief ����������������.
	\param a ����.
	\param b �Ǹ�����.
	\return \f$a^b\f$.
	\note ʹ���������ҵĶ�������.
	\todo a=0
*/
var Power(const Integer& x, uint y) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(x.mpz)) {
        mpz_ui_pow_ui(r->mpz, mpz_get_ui(x.mpz), y);
    } else {
        mpz_pow_ui(r->mpz, x.mpz, y);
    }
    return r;
}

/** \brief ��\f$a^b \bmod m\f$.
	\param a,b ����.
	\param m ��������.
	\return \f$a^b \bmod m\f$.
	\note ģ��mpz_powm����\f$2^k\f$�����ڷ�����\f$k\f$����ָ��ѡ��.
	\note ��Сģʹ����MontgomeryԼ������(ֻ�������ģ),
	���Ҷ�POWM_THRESHOLD����ģʹ�ô������.
	\todo a=0.
*/

var PowerMod(const Integer& x, const Integer& y, const Integer& z) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(y.mpz)) {
        mpz_powm_ui(r->mpz, x.mpz, mpz_get_ui(y.mpz), z.mpz);
    } else {
        mpz_powm(r->mpz, x.mpz, y.mpz, z.mpz);
    }
    return r;
}

/** \brief ��\f$a\f$ģ\f$n\f$����.
	\param a, n ����.
	\return \f$a\f$ģ\f$n\f$����.
	\todo �����ж�.
*/
var InverseMod(const Integer& x, const Integer& y) {
    Integer* r = new Integer();
    mpz_invert(r->mpz, x.mpz, y.mpz);
    return r;
}

/** \brief �������������������.
\param n1, n2 ����.
\return �������.
\note mpz_gcd�Խ�С����ʹ��Binary GCD,
�Գ���GCD_ACCEL_THRESHOLD������ʹ��Jebelean-Weber-Sorenson�����㷨.
*/
var GCD(const Integer& x, const Integer& y) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(y.mpz)) {
        mpz_gcd_ui(r->mpz, x.mpz, mpz_get_ui(y.mpz));
    } else {
        if (mpz_fits_uint_p(x.mpz)) {
            mpz_gcd_ui(r->mpz, y.mpz, mpz_get_ui(x.mpz));
        } else {
            mpz_gcd(r->mpz, x.mpz, y.mpz);
        }
    }
    return r;
}

/** \brief ��������������С������.
\param n1, n2 ����.
\return ��С������.
*/
var LCM(const Integer& x, const Integer& y) {
    Integer* r = new Integer();
    if (mpz_fits_uint_p(y.mpz)) {
        mpz_lcm_ui(r->mpz, x.mpz, mpz_get_ui(y.mpz));
    } else {
        if (mpz_fits_uint_p(x.mpz)) {
            mpz_lcm_ui(r->mpz, y.mpz, mpz_get_ui(x.mpz));
        } else {
            mpz_lcm(r->mpz, x.mpz, y.mpz);
        }
    }
    return r;
}

/** \brief ��������������չ�������.
\param n1, n2 ����.
\return ��չ�������\f$\{g,\{r_1,r_2\}\}\f$, ����\f$g=r_1n_1+r_2n_2\f$.
\note ��GCDEXT_THRESHOLD����ʹ��Lehmer�����㷨.
\todo ��չ�������.
*/
var ExtendedGCD(const Integer& x, const Integer& y) {
    var g = GCD(x, y);
    Integer *r1 = new Integer(), *r2 = new Integer();
    mpz_gcdext(g.cast<Integer>().mpz, r1->mpz, r2->mpz, x.mpz, y.mpz);
    return list(g, list(r1, r2));
}
}
}

using namespace nV;

CAPI void CVALUE(System, CoprimeQ)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 3 || !x[1].isObject($.Integer) || !x[2].isObject($.Integer))
        return;
    r = boolean(Number::CoprimeQ(x[1].cast<Integer>(), x[2].cast<Integer>()));
}
CAPI void CVALUE(System, GCD)(Kernel& k, var& r, Tuple& x) {
    if (x.size == 1 || !x[1].isObject($.Integer))
        return;
    r = x[1];
    for (uint i = 2; i < x.size; ++i)
        if (x[i].isObject($.Integer))
            r = Number::GCD(r.cast<Integer>(), x[i].cast<Integer>());
}
CAPI void CVALUE(System, LCM)(Kernel& k, var& r, Tuple& x) {
    if (x.size == 1 || !x[1].isObject($.Integer))
        return;
    r = x[1];
    for (uint i = 2; i < x.size; ++i)
        if (x[i].isObject($.Integer))
            r = Number::LCM(r.cast<Integer>(), x[i].cast<Integer>());
}
CAPI void CVALUE(System, ExtendedGCD)(Kernel& k, var& r, Tuple& x) {
    if (x.size != 3 || !x[1].isObject($.Integer) || !x[2].isObject($.Integer))
        return;
    r = Number::ExtendedGCD(x[1].cast<Integer>(), x[2].cast<Integer>());
}
