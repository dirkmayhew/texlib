
[status, octpkgtargz] = system(['ls *.tar.gz']);

tokens = strsplit(octpkgtargz, '-');
octpkg = [tokens{1}];
# eval([ 'pkg uninstall ' octpkg]);
eval([ 'pkg install ' octpkgtargz ]);
eval([ 'pkg describe ' octpkg ]);
