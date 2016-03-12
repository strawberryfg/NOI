var opt,i,pd:longint;
    r1,a1,lcm,x,ri,ai,x0,y0,d:int64;
procedure euclid(p,q:int64);
var tmp:int64;
begin
if q=0 then begin x0:=1; y0:=0; d:=p; exit; end;
euclid(q,p mod q);
tmp:=x0;
x0:=y0;
y0:=tmp-p div q*y0;
end;
begin
{assign(input,'strange.in');
reset(input);
assign(output,'strange.out');
rewrite(output);}
while not eof do
  begin
  read(opt);
  if opt=0 then break;
  read(r1,a1); lcm:=r1; x:=a1; pd:=1;
  for i:=2 to opt do
      begin
      read(ri,ai);
      if pd=0 then continue;
      x0:=0; y0:=0; d:=0;
      euclid(lcm,ri);
      if (ai-x) mod d<>0 then begin pd:=0; continue;  end;
      x0:=x0*((ai-x) div d);
      if x0<0 then
         begin
         if (-x0) mod (ri div d)=0 then x0:=0
            else x0:=x0+((-x0) div (ri div d)+1)*(ri div d);
         end;
      if x0-ri div d>=0 then
         begin
         if x0 mod (ri div d)=0 then x0:=0
            else x0:=x0-x0 div (ri div d)*(ri div d);
         end;
      x:=x+x0*lcm;
      lcm:=ri*lcm div d;
      end;
  if pd=0 then writeln(-1)
     else writeln(x);
  end;
{close(input);
close(output);}
end.