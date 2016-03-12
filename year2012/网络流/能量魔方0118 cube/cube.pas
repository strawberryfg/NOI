const di:array[1..6]of longint=(-1,1,0,0,0,0);
      dj:array[1..6]of longint=(0,0,-1,1,0,0);
      dk:array[1..6]of longint=(0,0,0,0,-1,1);
      maxn=100;
      inf=100000000;
type rec=record u,v,nxt,op,w:longint; end;
var n,sum,i,j,k,l,s,t,p,ans,ti,tj,tk,tot:longint;
    g:array[0..10*maxn*maxn*maxn]of rec;
    hash,his,info,edge,h,pre:array[0..maxn*maxn*maxn]of longint;
    a:array[0..maxn,0..maxn,0..maxn]of char;
    ind,adj:array[0..maxn,0..maxn,0..maxn]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1; g[tot].w:=z;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1; g[tot].w:=0;
end;
function sap:longint;
var i,now,p,k,min,num,ans:longint;
    flag:boolean;
begin
hash[0]:=n*n*n+2;
for i:=0 to n*n*n+2 do info[i]:=edge[i];
i:=s;
ans:=0;
now:=inf;
while h[s]<n*n*n+2 do
  begin
  his[i]:=now;
  flag:=false;
  p:=info[i];
  while p<>0 do
    begin
    k:=g[p].v;
    if (g[p].w>0)and(h[k]+1=h[i]) then
       begin
       flag:=true;
       if g[p].w<now then now:=g[p].w;
       pre[k]:=p;
       info[i]:=p;
       i:=k;
       if i=t then
          begin
          ans:=ans+now;
          while i<>s do
            begin
            dec(g[pre[i]].w,now);
            inc(g[g[pre[i]].op].w,now);
            i:=g[pre[i]].u;
            end;
          now:=maxlongint;
          end;
       break;
       end;
    p:=g[p].nxt;
    end;
  if not flag then
     begin
     min:=inf;
     num:=-1;
     p:=edge[i];
     while p<>0 do
       begin
       k:=g[p].v;
       if (g[p].w>0)and(h[k]<min) then
          begin
          min:=h[k];
          num:=p;
          end;
       p:=g[p].nxt;
       end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     inc(hash[h[i]]);
     info[i]:=num;
     if i<>s then begin i:=g[pre[i]].u; now:=his[i]; end;
     end;
  end;
exit(ans);
end;
begin
assign(input,'cube.in');
reset(input);
assign(output,'cube.out');
rewrite(output);
readln(n);
sum:=0;
s:=0;
t:=n*n*n+1;
for i:=1 to n do  //layer
    begin
    if i<>1 then readln;
    for j:=1 to n do //col
        begin
        for k:=1 to n do  //grid
            begin
            ind[i][j][k]:=(i-1)*n*n+(j-1)*n+k;
            p:=6;
            if (i=1)or(i=n) then dec(p);
            if (j=1)or(j=n) then dec(p);
            if (k=1)or(k=n) then dec(p);
            adj[i][j][k]:=p;
            sum:=sum+p;
            read(a[i][j][k]);
            end;
        readln;
        end;
    end;
for i:=1 to n do  //layer
    begin
    for j:=1 to n do //col
        begin
        for k:=1 to n do //grid
            begin
            p:=i-1+j-1+k-1;
            if p mod 2=0 then
               begin
               for l:=1 to 6 do
                   begin
                   ti:=i+di[l]; tj:=j+dj[l]; tk:=k+dk[l];
                   if (ti>=1)and(ti<=n)and(tj>=1)and(tj<=n)and(tk>=1)and(tk<=n) then
                      begin
                      addedge(ind[i][j][k],ind[ti][tj][tk],2);
                      end;
                   end;
               end;
            if p mod 2=0 then
               begin
               addedge(s,ind[i][j][k],adj[i][j][k]);
               if a[i][j][k]='P' then addedge(s,ind[i][j][k],inf)
                  else if a[i][j][k]='N' then addedge(ind[i][j][k],t,inf);
               end
            else
               begin
               addedge(ind[i][j][k],t,adj[i][j][k]);
               if a[i][j][k]='P' then addedge(ind[i][j][k],t,inf)
                  else if a[i][j][k]='N' then addedge(s,ind[i][j][k],inf);
               end;
            end;
        readln;
        end;
    end;
ans:=sap;
writeln(sum-ans);
close(input);
close(output);
end.