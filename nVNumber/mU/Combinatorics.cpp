#include "common.h"
#include <mU/Function.h>
#include "../Factorial.sieve.h"

using boost::scoped_array;

namespace {

using boost::uint32_t;

inline mpz_ptr mpz_new()
{
	mpz_ptr r = new __mpz_struct;
	mpz_init(r);
	return r;
}

inline mpz_ptr mpz_new(uint32_t x)
{
	mpz_ptr r = mpz_new();
	mpz_set_ui(r,x);
	return r;
}

inline mpz_ptr mpz_new(mpz_ptr x)
{
	mpz_ptr r = mpz_new();
	mpz_set(r,x);
	return r;
}

inline void mpz_delete(mpz_ptr x)
{
	mpz_clear(x);
	delete x;
}

inline mpz_ptr mpz_clone(mpz_ptr x)
{
	mpz_ptr r = new __mpz_struct;
	*r = *x;
	return r;
}

// unused code
//inline uint32_t expsum(uint32_t N, uint32_t p)
//{
//	N /= p;
//	uint32_t e = N;
//	while(N >= p)
//	{
//		N /= p;
//		e += N;
//	}
//	return e;
//}

inline uint32_t expoddsum(uint32_t N, uint32_t p)
{
	uint32_t e = 0;
	while(N /= p) e += N & 1;
	return e;
}

inline bool compare(const mpz_ptr &a, const mpz_ptr &b)
{
	return a->_mp_size > b->_mp_size;
}

mpz_ptr product(mpz_ptr* v, mpz_ptr* v_end)
{
	if(v >= v_end) return mpz_new(1);
	std::make_heap(v, v_end, compare);
	while(v + 1 != v_end)
	{
		std::pop_heap(v, v_end--, compare);
		mpz_ptr x = *v_end;
		std::pop_heap(v, v_end--, compare);
		mpz_mul(*v_end, *v_end, x);
		mpz_delete(x);
		std::push_heap(v, ++v_end, compare);
	}
	return *v;
}

mpz_ptr product(const uint32_t* u, const uint32_t* u_end)
{
	if(u >= u_end) return mpz_new(1);
	uint32_t size = u_end - u;
	scoped_array<mpz_ptr> v(new mpz_ptr[size]);
	mpz_ptr *vp = v.get();
	uint32_t t = *u;
	while(++u < u_end) 
	{
		if(~(uint32_t)0 / t <= *u) {*vp++ = mpz_new(t); t = 1;}
		t *= *u;
	}
	if(t != 1) *vp++ = mpz_new(t);
	product(v.get(), vp);
	mpz_ptr r = mpz_clone(v[0]);
	return r;
}

const uint32_t small_fac_table[] =
{
	1,1,1,3,3,15,45,315,315,2835,14175,155925,467775,6081075,42567525,638512875,638512875
};

uint32_t const small_swing_table[] =
{
	1,1,1,3,3,15,5,35,35,315,63,693,231,3003,429,6435,6435,109395,12155,230945,46189,969969,88179,
	2028117,676039,16900975,1300075,35102025,5014575,145422675,9694845,300540195,300540195
};

struct swing_cache {uint32_t high; mpz_ptr value;};

// unused code
//void facs(mpz_ptr r,uint32_t N)
//{
//	sieve primes(N);
//	int size = primes.lower(N) + 1;
//	scoped_array<mpz_ptr> v(new mpz_ptr[size]);
//	mpz_ptr *vp = v.get();
//	scoped_array<uint32_t> e(new uint32_t[size]);
//	for(int i = 1; i < size; ++i) e[i] = expsum(N, primes[i]);
//	uint32_t w = 1 << (8 * sizeof(uint32_t) - 1);
//	while((e[1] & w) == 0) w >>= 1;
//
//	mpz_set_ui(r,1);
//	while(w != 0)
//	{
//		mpz_pow_ui(r, r, 2);
//		uint32_t t = 1;
//		for(int i = 1; i < size; ++i)
//		{
//			if(e[i] & w)
//			{
//				uint32_t a = primes[i];
//				if(~(uint32_t)0 / t <= a) {*vp++ = mpz_new(t); t = 1;}
//				t *= a;
//			}
//		}
//		if(t != 1) *vp++ = mpz_new(t);
//		mpz_mul(r,r,product(v.get(), vp)); vp = v.get(); w >>= 1;
//	}
//}

void facz(mpz_ptr r,uint32_t N)
{
	sieve primes(N); int count = 0;
	uint32_t rN = (uint32_t)sqrt((double)N);

	scoped_array<mpz_ptr> swing(new mpz_ptr[8 * sizeof(uint32_t)]);

	std::map<uint32_t, swing_cache> pool;
	std::stack<uint32_t> lows;

	{
		scoped_array<mpz_ptr> u(new mpz_ptr[primes.lower(N) - primes.lower(N >> 1)]);
		mpz_ptr *up = u.get();
		scoped_array<mpz_ptr> v(new mpz_ptr[primes.lower(rN + 30) + rN / 2]);
		mpz_ptr *vp = v.get();
		while(N >= 17)
		{
			if(N <= 32) { swing[count++] = mpz_new(small_swing_table[N]); N >>= 1; break; }
			rN = (uint32_t)sqrt((double)N);
			uint32_t high = N, low = N >> 1, den = 2;
			while(high - low >= 30)
			{
				uint32_t low2 = low;
				while(pool.count(low2)) {lows.push(low2); low2 = pool[low2].high;}
				*up++ = product(primes.begin() + primes.upper(low2 + 1), 
								primes.begin() + primes.lower(high) + 1);
				while(low2 != low)
				{
					pool.erase(low2);
					low2 = lows.top(); lows.pop();
					*up++ = pool[low2].value;
				}
				product(u.get(), up); up = u.get();
				pool[low].high = high;
				pool[low].value = u[0];
				*vp++ = mpz_new(u[0]);
			
				high = N / ++den, low = N / ++den;
				if(low < rN) low = rN;
			}
			/*
			uint32_t size = primes.lower(high);
			const uint32_t *p = primes.begin() + 1;
			for(uint32_t i = 0; i < size; ++i) e[i] = expoddsum(N, p[i]);
			*vp++ = product(p, e, size);
			*/
			const uint32_t *p0 = primes.begin(), *p1 = primes.begin() + primes.lower(high) + 1;
			while(++p0 < p1)
			{
				uint32_t e = expoddsum(N, *p0);
				if(e) {*vp = mpz_new(*p0); mpz_pow_ui(*vp, *vp, e); ++vp;}
			}
			swing[count++] = product(v.get(), vp); vp = v.get(); N >>= 1;
		}
	}
	mpz_set_ui(r,small_fac_table[N]);
	while(count--)
	{
		mpz_pow_ui(r, r, 2);
		mpz_mul(r, r, swing[count]);
		mpz_delete(swing[count]);
	}

	for(std::map<uint32_t,swing_cache>::const_iterator
		p = pool.begin();
		p != pool.end(); ++p)
		mpz_delete(p->second.value);
	/*
	swing[count++] = mpz_new(small_fac_table[N]);
	for(uint32_t e = 1, i = 0; i < count; ++i, e <<= 1)	mpz_pow_ui(swing[i], swing[i], e);
	return product(swing, swing + count);
	*/
}

}

namespace mU {
namespace Function {
var Factorial(unsigned long x)
{
	var r = Int();
	facz(CInt(r),x);
	uint32_t e = 0;
	while(x >>= 1) e += x;
	mpz_mul_2exp(CInt(r),CInt(r),e);
	return r;
}
var Binomial(Var x, unsigned long y)
{
	var r = Int();
	mpz_bin_ui(CInt(r),CInt(x),y);
	return r; 
}
var Binomial(uint32_t x, uint32_t y)
{ 
	var r = Int();
	mpz_bin_uiui(CInt(r),x,y);
	return r; 
}
var Fibonacci(unsigned long x)
{ 
	var r = Int();
	mpz_fib_ui(CInt(r),x);
	return r; 
}
var Lucas(unsigned long x)
{
	var r = Int(); 
	mpz_lucnum_ui(CInt(r),x);
	return r; 
}
}
}
