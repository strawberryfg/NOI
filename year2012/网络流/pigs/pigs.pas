const maxn=1050; inf=100000000;
type rec=record u,v,nxt,op,c:longint; end;
var n,m,s,t,i,j,x,num,p,min,now,ans,tot:longint;
    a:array[0..maxn]of longint;
    info,edge,hash,h,last,fa,his:array[0..maxn]of longint;
    g:array[0..maxn*maxn*4]of rec;
    flag:boolean;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1; g[tot].c:=z;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1; g[tot].c:=0;
end;
begin
assign(input,'pigs.in');
reset(input);
assign(output,'pigs.out');
rewrite(output);
readln(m,n);
s:=0;
t:=n+m+1;
for i:=1 to m do read(a[i]);
for i:=1 to m do addedge(s,i,a[i]);
for i:=1 to n do
    begin
    read(num);
    for j:=1 to num do
        begin
        read(x);
        if last[x]=0 then addedge(x,i+m,inf)
           else begin
                addedge(last[x]+m,i+m,inf);
                end;
        last[x]:=i;
        end;
    read(x);
    addedge(i+m,t,x);
    end;
now:=inf;
hash[0]:=n+m+2;
info:=edge;
i:=s;
ans:=0;
while h[s]<n+m+1 do
  begin
  his[i]:=now;
  flag:=false;
  p:=info[i];
  while p<>0 do
    begin
    x:=g[p].v;
    if (g[p].c>0)and(h[g[p].v]+1=h[i]) then
       begin
       flag:=true;
       fa[g[p].v]:=p;
       info[i]:=p;
       i:=g[p].v;
       if g[p].c<now then now:=g[p].c;
       if i=t then
          begin
          ans:=ans+now;
          while i<>s do
            begin
            dec(g[fa[i]].c,now);
            inc(g[g[fa[i]].op].c,now);
            i:=g[fa[i]].u;
            end;
          now:=inf;
          end;
       break;
       end;
    p:=g[p].nxt;
    end;
  if not flag then
     begin
     min:=n+m; num:=-1;
     p:=edge[i];
     while p<>0 do
       begin
       if (g[p].c>0)and(h[g[p].v]<min) then
          begin
          min:=h[g[p].v];
          num:=p;
          end;
       p:=g[p].nxt;
       end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     inc(hash[h[i]]);
     info[i]:=num;
     if i<>s then begin i:=g[fa[i]].u; now:=his[i]; end;
     end;
  end;
writeln(ans);
close(input);
close(output);
end.
