type jz=record
       n,m:longint;
       a:array[1..4,1..4] of int64;
     end;

var n,p,i,j,k:longint;
    c1,c2:jz;
operator *(a,b:jz)c:jz;
var i,j:longint;
  begin
    c.n:=a.n; c.m:=b.m;
    for i:=1 to c.n do
      for j:=1 to c.m do
        begin
          c.a[i,j]:=0;
          for k:=1 to a.m do
            c.a[i,j]:=c.a[i,j]+a.a[i,k]*b.a[k,j];
          c.a[i,j]:=c.a[i,j] mod p;
        end;
  end;
begin
  assign(input,'brick.in');
  assign(output,'brick.out');
  reset(input);
  rewrite(output);
  readln(n,p);
  case n of
    1:writeln(1);
    2:writeln(3);
    3:writeln(12);
    4:writeln(51);
    else begin
  n:=n-4;
  c1.n:=1; c1.m:=4;
  c1.a[1,1]:=1;
  c1.a[1,2]:=3;
  c1.a[1,3]:=12;
  c1.a[1,4]:=51;
  fillchar(c2,sizeof(c2),0);
  c2.n:=4; c2.m:=4;
  c2.a[1,4]:=p-2;
  c2.a[2,1]:=1; c2.a[2,4]:=11;
  c2.a[3,2]:=1; c2.a[3,4]:=p-14;
  c2.a[4,3]:=1; c2.a[4,4]:=7;
  for i:=0 to 31 do
    begin
      if n and (1<<i)<>0 then c1:=c1*c2;
      c2:=c2*c2;
    end;
  writeln(c1.a[1,4]);
  end; end;
  close(input);
  close(output);
end.
