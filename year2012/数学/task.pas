//21:30;
const base=10000;
type arr=array[-1..200]of longint;
var n,i,t:longint;
    a,id:array[0..25]of longint;
    c,ansa,ansb,ans,tmp:arr;
    fac:array[0..111]of arr;
    hash:array[0..111]of longint;
    sta:array[0..111]of longint;
    s,ts:string;
    code:integer;
procedure print(x:arr);
var i:longint;
begin
write(x[x[-1]]);
for i:=x[-1]-1 downto 0 do
    begin
    if x[i]>999 then write(x[i])
       else if x[i]>99 then write('0',x[i])
               else if x[i]>9 then write('00',x[i])
                       else write('000',x[i]);
    end;
writeln;
end;
function mul(x,y:arr):arr;
var i,j,k,max:longint;
begin
fillchar(c,sizeof(c),0);
max:=x[-1]+y[-1];
for i:=0 to x[-1] do
    for j:=0 to y[-1] do
        begin
        c[i+j]:=c[i+j]+x[i]*y[j];
        k:=i+j;
        while c[k]>=base do
          begin
          if k>max then max:=k;
          c[k+1]:=c[k+1]+c[k] div base;
          c[k]:=c[k] mod base;
          inc(k);
          end;
        end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
exit(c);
end;
function add(x,y:arr):arr;
var i,max:longint;
begin
fillchar(c,sizeof(c),0);
if x[-1]>y[-1] then max:=x[-1] else max:=y[-1];
for i:=0 to max do
    begin
    c[i]:=c[i]+x[i]+y[i];
    c[i+1]:=c[i+1]+c[i] div base;
    c[i]:=c[i] mod base;
    end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
exit(c);
end;
function decline(x,y:arr):arr;
var i,max:longint;
begin
fillchar(c,sizeof(c),0);
if x[-1]>y[-1] then max:=x[-1] else max:=y[-1];
for i:=0 to max do
    begin
    c[i]:=c[i]+x[i]-y[i];
    if c[i]<0 then begin c[i+1]:=c[i+1]-1; c[i]:=c[i]+base; end;
    end;
if c[max]=0 then dec(max);
c[-1]:=max;
exit(c);
end;
procedure work(opt,cnt:longint);
begin
if opt=1 then ansa:=add(ansa,fac[n-cnt]) else ansb:=add(ansb,fac[n-cnt]);
end;
procedure dfs(x,opt,cnt:longint);
begin
if x>a[0] then
   begin
   work(opt,cnt);
   exit;
   end;
if (hash[a[x]]=1)or(sta[id[x]]<>0) then begin dfs(x+1,opt,cnt); exit; end;
hash[a[x]]:=1; sta[id[x]]:=a[x]; dfs(x+1,-opt,cnt+1);
hash[a[x]]:=0; sta[id[x]]:=0; dfs(x+1,opt,cnt);
end;
begin
assign(input,'task.in');
reset(input);
assign(output,'task.out');
rewrite(output);
readln(n); a[0]:=0;
for i:=1 to n do
    begin
    readln(s);
    t:=pos(' ',s);
    while t<>0 do
      begin
      ts:=copy(s,1,t-1);
      inc(a[0]);
      val(ts,a[a[0]],code);
      id[a[0]]:=i;
      delete(s,1,t);
      t:=pos(' ',s);
      end;
    if s<>'' then
       begin
       inc(a[0]); val(s,a[a[0]],code);
       id[a[0]]:=i;
       end;
    end;
fac[0][-1]:=0; fac[0][0]:=1;
for i:=1 to n do
    begin
    tmp[-1]:=0; tmp[0]:=i;
    fac[i]:=mul(fac[i-1],tmp);
    end;
ansa[-1]:=0; ansa[0]:=0; ansb[-1]:=0; ansb[0]:=0; ans[-1]:=0; ans[0]:=0;
dfs(1,1,0);
ans:=decline(ansa,ansb);
print(ans);
close(input);
close(output);
end.