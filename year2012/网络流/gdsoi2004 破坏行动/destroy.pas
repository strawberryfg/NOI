
type
 net=record
 c,f:longint;
 end;
 node=record
 s,b:integer;
 end;
var
  n,s,t,x,a,nx:longint;
  dian:array[1..150]of node;
  xian,xiann:array[1..150,1..150]of net;
  mm:array[1..9000,1..2]of longint;
procedure init;
var
 i,j:longint;
begin
 read(n);
 read(nx);
 read(s,t);
 for i:=1 to nx do
  begin
   read(mm[i,1],mm[i,2],xian[mm[i,1],mm[i,2]].c);
   xian[mm[i,2],mm[i,1]].c:=xian[mm[i,1],mm[i,2]].c;
  end;
end;
function find:longint;
var
 i:longint;
begin
 for i:=1 to n do
  if (dian[i].s<>0)and(dian[i].b=0) then begin find:=i; exit; end;
 find:=0;
end;
function ford:boolean;
var
 i,j,m:longint;
begin
 m:=s-1;
 fillchar(dian,sizeof(dian),0);
 dian[s].s:=s;
 while m<>t do
  begin
   m:=find;
   if m=0 then exit(true);
    for i:=1 to n do
    if (dian[i].s=0)and((xian[m,i].c<>0)or(xian[i,m].c<>0)) then
    begin
     if (xian[m,i].f<xian[m,i].c)and(xian[m,i].f>=0) then dian[i].s:=m;
     if (xian[i,m].f>0) then dian[i].s:=-m;
    end;
   dian[m].b:=1;
  end;
 m:=t;
 a:=maxlongint;
 while m<>s do
  begin
  j:=m; m:=abs(dian[m].s);
  if dian[j].s>0 then x:=xian[m,j].c-xian[m,j].f;
  if dian[j].s<0 then x:=xian[j,m].c;
  if x<a then a:=x;
  end;
 ford:=false;
end;
procedure change;
var
 i,m,j:longint;
begin
 m:=t;
 while m<>s do
  begin
   j:=m; m:=abs(dian[m].s);
   if dian[j].s>0 then  begin inc(xian[m,j].f,a); dec(xian[j,m].f,a); end;
   if dian[j].s<0 then  begin dec(xian[j,m].f,a); inc(xian[m,j].f,a); end;
  end;
end;
procedure print;
var
 i,tot:longint;
begin
 tot:=0;
 for i:=1 to nx do
 if (xian[mm[i,1],mm[i,2]].f=xian[mm[i,1],mm[i,2]].c)
 or (xian[mm[i,2],mm[i,1]].f=xian[mm[i,2],mm[i,1]].c) then inc(tot);
 writeln(tot);
 for i:=1 to nx do
 if (xian[mm[i,1],mm[i,2]].f=xian[mm[i,1],mm[i,2]].c)
 or (xian[mm[i,2],mm[i,1]].f=xian[mm[i,2],mm[i,1]].c) then writeln(i);
end;
procedure floyd;
var
 i,j,k:longint;
begin
 xiann:=xian;
 for i:=1 to n do
  for j:=1 to n do
    xian[i,j].c:=xian[i,j].c-xian[i,j].f;
 for k:=1 to n do
  for i:=1 to n do
   for j:=1 to n do
   if (xian[i,k].c<>0)and(xian[k,j].c<>0) then
   begin
   if (xian[i,j].f<>0) then
   xiann[i,j].f:=-1;
   xian[i,j].c:=1;
   end;
 xian:=xiann;
end;
procedure work;
var i:longint;
begin
 while not ford do change;
 for i:=1 to nx do
     begin
     writeln(mm[i][1],'   -       > ',mm[i][2],' :             ',xian[mm[i][1]][mm[i][2]].f);
     writeln(mm[i][2],'   -       > ',mm[i][1],' :             ',xian[mm[i][2]][mm[i][1]].f);
     end;
 floyd;
 print;
end;
begin
assign(input,'destroy.in');
reset(input);
assign(output,'destroy.out');
rewrite(output);
 init;
 work;
 
close(input);
close(output);
end.
