const maxn=200; inf=maxlongint;
      dx:array[1..4]of longint=(0,1,0,-1);
      dy:array[1..4]of longint=(1,0,-1,0);
type rec=record u,v,nxt,c,op:longint; end;
var n,m,i,j,s,t,x,y,k,tx,ty,now,ans,p,min,tot,tmp,num:longint;
    edge,info,his:array[0..maxn*maxn*10]of longint;
    g:array[0..maxn*maxn*10]of rec;
    h,hash,fa:array[0..maxn*maxn*10]of longint;
    flag:boolean;
    a:array[0..maxn,0..maxn]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z;
g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0;
g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
begin
assign(input,'ws.in');
reset(input);
assign(output,'ws.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    for j:=1 to m do
        read(a[i][j]);
s:=0; t:=n*m+1;
for i:=1 to n do
    for j:=1 to m do
        begin
        x:=i; y:=j;
        for k:=1 to 4 do
            begin
            tx:=x+dx[k]; ty:=y+dy[k];
            if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m) then
               begin
               addedge((x-1)*m+y,(tx-1)*m+ty,1);
               end
            end;
        if a[i][j]=1 then
           addedge(s,(i-1)*m+j,inf)
        else
           if a[i][j]=2 then
              addedge((i-1)*m+j,t,inf);
        end;
hash[0]:=n*m+2;
info:=edge;
now:=inf;
i:=s;
ans:=0;
while h[0]<n*m+2 do
  begin
  his[i]:=now;
  flag:=false;
  p:=info[i];
  while p<>0 do
    begin
    x:=g[p].v;
    if (g[p].c>0)and(h[x]+1=h[i]) then
       begin
       flag:=true;
       if g[p].c<now then now:=g[p].c;
       fa[x]:=p;
       info[i]:=p;
       i:=x;
       if i=t then
          begin
          ans:=ans+now;
          tmp:=p;
          while tmp<>0 do
             begin
             dec(g[tmp].c,now);
             inc(g[g[tmp].op].c,now);
             tmp:=fa[g[tmp].u];
             end;
          now:=maxlongint;
          i:=s;
          end;
       break;
       end;
    p:=g[p].nxt;
    end;
  if not flag then
     begin
     min:=inf;
     p:=edge[i];
     while p<>0 do
       begin
       x:=g[p].v;
       if (g[p].c>0)and(h[x]<min) then
          begin
          min:=h[x];
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
