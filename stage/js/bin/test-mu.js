mu=require('./mu');
mu._mU_init();
meval = mu.cwrap('mU_eval', 'string', ['string']);
r = meval('100!');
console.log(r);
r = meval('Integrate[x*Sin[x],x]');
console.log(r);
r = meval('<< "/etc/test.m"');
