const maxn=1000020;
var n,ans,i,j,l,r,t:longint;
    a:array[0..maxn]of char;
    left,right:array[0..maxn,1..3]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'a.in');
reset(input);
assign(output,'a.out');
rewrite(output);
n:=0;
ans:=0;
while not eoln do
   begin
   inc(n);
   read(a[n]);
   end;
for i:=1 to n do
    begin
    if a[i]='J' then left[i][1]:=left[i-1][1]+1 else left[i][1]:=0;
    if a[i]='O' then left[i][2]:=left[i-1][2]+1 else left[i][2]:=0;
    if a[i]='I' then left[i][3]:=left[i-1][3]+1 else left[i][3]:=0;
    end;
for i:=n downto 1 do
    begin
    if a[i]='J' then right[i][1]:=right[i+1][1]+1 else right[i][1]:=0;
    if a[i]='O' then right[i][2]:=right[i+1][2]+1 else right[i][2]:=0;
    if a[i]='I' then right[i][3]:=right[i+1][3]+1 else right[i][3]:=0;
    end;
for i:=1 to n do
    begin
    if a[i]='O' then
       begin
       l:=i-left[i][2];
       r:=i+right[i][2];
       if (l>=1)and(r<=n) then
          begin
          t:=min(left[l][1],right[r][3]);
          if t>=left[i][2]+right[i][2]-1 then
             if left[i][2]+right[i][2]-1>ans then
                ans:=left[i][2]+right[i][2]-1;
          end;
       end;
    end;
writeln(ans);
close(input);
close(output);
end.Project1;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils
  { add your units here };

begin
end.

