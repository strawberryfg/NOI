type
	tlist=array[1..4,1..4]of int64;

var
	n,p,i:longint;
	ansx:int64;
	ans,b:tlist;
	a:array[1..4]of int64;

function cheng(a,b:tlist):tlist;
var
	i,j,k:longint;
begin
	fillchar(cheng,sizeof(cheng),0);
	for i:=1 to 4 do
	  for j:=1 to 4 do
	    for k:=1 to 4 do
	    begin
	    	cheng[i,j]:=(cheng[i,j]+a[i,k]*b[k,j]) mod p;
	    end;
end;

function fast(k:longint):tlist;
var
	temp:tlist;
begin
	if k=1 then exit(b)
	else 
	begin
		temp:=fast(k div 2);
		temp:=cheng(temp,temp);
		if k mod 2=1 then temp:=cheng(temp,b);
		exit(temp);
	end;
end;

begin
	
	assign(input,'brick.in');
	reset(input);
	assign(output,'brick.out');
	rewrite(output);
	
	readln(n,p);
	a[1]:=1;a[2]:=3;a[3]:=12;a[4]:=51;
	b[1,1]:=0;b[1,2]:=0;b[1,3]:=0;b[1,4]:=-2;
	b[2,1]:=1;b[2,2]:=0;b[2,3]:=0;b[2,4]:=11;
	b[3,1]:=0;b[3,2]:=1;b[3,3]:=0;b[3,4]:=-14;
	b[4,1]:=0;b[4,2]:=0;b[4,3]:=1;b[4,4]:=7;
	if n<=4 then writeln(a[n] mod p)
	else
	begin
		n:=n-4;
		ans:=fast(n);
		ansx:=0;
		for i:=1 to 4 do
		begin
			ansx:=(ansx+a[i]*ans[i,4])mod p;
		end;
		writeln(ansx);
	end;
	
	close(input);
	close(output);

end.
