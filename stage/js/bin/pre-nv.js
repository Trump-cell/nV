var Module = {
'dynamicLibraries': [
//'../lib/libmusystem.so'
],
//'TOTAL_MEMORY': 100000000,
'preRun': [ 
function() {
FS.mkdir('/lib');
FS.mount(NODEFS, { root: '../lib' }, "/lib");
FS.mkdir('/etc');
FS.mount(NODEFS, { root: '../etc' }, "/etc");
ENV.MU_HOME = "";
ENV.NV_HOME = "";
} 
]
}
