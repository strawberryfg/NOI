Program 		data;
var n,m,k,q,p : int64;
i,j : longint;
begin
Assign(output,'cover10.in');
reset(input); rewrite(output);
randomize;
	n := 100000;m:=300000;k := 10000000;
	writeln(n,' ',m,' ',k);
	for i :=1 to N do
	write(char(97+random(5)));writeln;
	for i :=1 to m do
	begin
		p := random(50000)+1;
		q := p+random(n)+9000;
		if (q>n) then q := n;
		writeln(p,' ',q);
	end;
Close(input); Close(output);
end.
