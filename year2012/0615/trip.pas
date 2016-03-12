const mo=11192869;
      dx:array[1..4] of longint=(0,-1,0,1);
      dy:array[1..4] of longint=(1,0,-1,0);
var s,somea,someb:string;
    a:array[1..3] of string;
    sum,ans,n,m,i,j:longint;
    hash,h:array[1..3,1..55] of boolean;
    flag:boolean;

procedure go(x,y:longint);
 var tx,ty,i:longint;
begin
 h[x,y]:=true;
 inc(sum);
 for i:=1 to 4 do
   begin
     tx:=x+dx[i];
     ty:=y+dy[i];
     if (tx=0) or (ty=0) or (tx>n) or (ty>m) then continue;
     if (not hash[tx,ty]) and (not h[tx,ty]) then go(tx,ty);
   end;
end;

function check(num:longint):boolean;
 var i,j:longint;
begin
 for i:=1 to n do
   for j:=1 to m do
     h[i,j]:=false;
 for i:=1 to n do
   for j:=1 to m do
     if not hash[i,j] then
        begin
          sum:=0;
          go(i,j);
          if sum+num=n*m then exit(true)
                         else exit(false);
        end;
end;

procedure dfs(x,y,now:longint);
 var tx,ty,i:longint;
begin
 hash[x,y]:=true;
 if now=n*m then begin ans:=(ans+1) mod mo;hash[x,y]:=false;exit;end;
 if not check(now) then begin hash[x,y]:=false; exit;end;
 for i:=1 to 4 do
   begin
     tx:=x+dx[i];
     ty:=y+dy[i];
     if (tx=0) or (ty=0) or (tx>n) or (ty>m) then continue;
     if (not hash[tx,ty]) and (s[now+1]=a[tx,ty]) then dfs(tx,ty,now+1);
   end;
 hash[x,y]:=false;
end;

procedure work(x,y:longint);
begin
  fillchar(hash,sizeof(hash),false);
  if a[x,y]=s[1] then dfs(x,y,1);
end;

begin
assign(input,'trip.in');reset(input);
assign(output,'trip.out');rewrite(output);
readln(n,m);
if n=1 then
   begin
    readln(somea);
    readln(someb);
    flag:=true;
    for i:=1 to m do if somea[i]<>someb[i] then begin flag:=false;break;end;
    if flag then inc(ans);
    flag:=true;
    for i:=1 to m do if somea[i]<>someb[m-i+1] then begin flag:=false;break;end;
    if flag then inc(ans);
    writeln(ans);
   end else
begin
 for i:=1 to n do readln(a[i]);
 readln(s);
 ans:=0;
 for i:=1 to m do
    begin
      work(1,i);
      work(n,i);
    end;
 for i:=2 to n-1 do begin work(i,1);work(i,m);end;
 writeln(ans);
end;
close(input);close(output);
end.
