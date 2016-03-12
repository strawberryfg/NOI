var
	i,j,k,n:longint;
	tot,a1,a2,a3,a4,a5,a6:int64;
	a:array[0..5000]of longint;

procedure gaojingchu(n,m:int64);
var
	num:longint;
begin
	if n=m then writeln('1.00000000000000000000')
	else
	begin
		write('0.');
		num:=0;
		n:=n*10;
		while num<20 do
		begin
			write(n div m);
			n:=(n mod m)*10;
			inc(num);
		end;
	end;
	writeln;	
end;

begin
	
	assign(input,'shape.in');
	reset(input);
	assign(output,'shape.out');
	rewrite(output);
	
	readln(n);
	tot:=0;
	a1:=0;a2:=0;a3:=0;a4:=0;a5:=0;a6:=0;
	for i:=1 to n do read(a[i]);
	for j:=2 to n-1 do
	  for i:=1 to j-1 do
	    for k:=j+1 to n do
	    begin
	    	if (a[i]<>a[j])and(a[j]<>a[k])and(a[k]<>a[i]) then
	    	begin
	    		tot:=tot+1;
	    		if  a[i]<a[j] then
	    		begin
	    			if a[j]<a[k] then a1:=a1+1
	    			else
	    			begin
	    				if a[i]<a[k] then a2:=a2+1
	    				else a4:=a4+1;
	    			end;
	    		end
	    		else
	    		begin
	    			if a[k]>a[i] then a3:=a3+1
	    			else
	    			begin
	    				if a[k]>a[j] then a5:=a5+1
	    				else a6:=a6+1;
	    				
	    			end;
	    		end;
	    	end;
	    end;
	gaojingchu(a1,tot);
	gaojingchu(a2,tot);
	gaojingchu(a3,tot);
	gaojingchu(a4,tot);
	gaojingchu(a5,tot);
	gaojingchu(a6,tot);
	
	close(input);
	close(output);

end.
