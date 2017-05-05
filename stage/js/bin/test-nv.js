nv=require('./nv');
k=nv._nV_init();
neval = nv.cwrap('nV_eval', 'string', ['number','string']);
r = neval(k,'100!');
console.log(r);
r = neval(k,'Integrate[x*Sin[x],x]');
console.log(r);
neval(k,'<< "/etc/test.m"');
