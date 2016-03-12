const maxn=4020; maxm=40020;
type strr=string[10];
     atype=record id:longint; st:strr; end;
     rec=record v,nxt:longint; end;
var n,i,t,x,y,tme,top,tot,cnt,m:longint;
    a:array[0..2*maxn]of atype;
    edge,dfn,low,stack,col,sum:array[0..maxn]of longint;
    instack:array[0..maxn]of boolean;
    g:array[0..maxm]of rec;
    s,s1:string;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure sort(l,r:longint);
var i,j:longint; cmp:strr; swap:atype;
begin
i:=l; j:=r; cmp:=a[(l+r) div 2].st;
repeat
while a[i].st<cmp do inc(i);
while cmp<a[j].st do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function find(ts:strr):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=2*n;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if a[mid].st<ts then le:=mid+1
     else if a[mid].st>ts then ri:=mid-1
             else begin find:=a[mid].id; break; end;
  end;
end;
procedure tarjan(x:longint);
var p:longint;
begin
inc(tme); dfn[x]:=tme; low[x]:=tme; inc(top); stack[top]:=x; instack[x]:=true;
p:=edge[x];
while p<>0 do
  begin
  if dfn[g[p].v]=0 then
     begin
     tarjan(g[p].v);
     if low[g[p].v]<low[x] then low[x]:=low[g[p].v];
     end
  else if (instack[g[p].v])and(dfn[g[p].v]<low[x]) then low[x]:=dfn[g[p].v];
  p:=g[p].nxt;
  end;
if dfn[x]=low[x] then
   begin
   inc(cnt);
   while stack[top+1]<>x do
     begin
     stack[top+1]:=0; instack[stack[top]]:=false;
     col[stack[top]]:=cnt; inc(sum[cnt]); dec(top);
     end;
   end;
end;
begin
{assign(input,'marriage.in');
reset(input);
assign(output,'marriage.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    begin
    readln(s);
    t:=pos(' ',s);
    a[2*i-1].st:=copy(s,1,t-1); a[2*i-1].id:=i;
    delete(s,1,t);
    a[2*i].st:=s; a[2*i].id:=i;
    end;
sort(1,2*n);
readln(m);
for i:=1 to m do
    begin
    readln(s);
    t:=pos(' ',s);
    s1:=copy(s,1,t-1);
    delete(s,1,t);
    x:=find(s1); y:=find(s);
    addedge(x,y);
    end;
tme:=0; top:=0; cnt:=0; fillchar(instack,sizeof(instack),false);
for i:=1 to n do if dfn[i]=0 then tarjan(i);
for i:=1 to n do if sum[col[i]]>1 then writeln('Unsafe') else writeln('Safe');
{close(input);
close(output);}
end.