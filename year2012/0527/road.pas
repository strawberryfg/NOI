const maxn=1720; maxm=6020; maxq=5000020; base=1000000007; inf=maxlongint;
type rec=record v,w,nxt:longint; end;
var n,m,tot,i,x,y,z,head,tail,p,j,tot2,cnt:longint;
    q:array[0..maxq]of longint;
    dis,edge,edge2,sta,inner,deg:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    g,tg,h:array[0..maxm]of rec;
    ans:array[0..maxm]of qword;
    flag:array[0..maxm]of longint;
    f,ff:array[0..maxn]of qword;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure addedge2(x,y,z:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].w:=z; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
inc(inner[y]);
end;
procedure addedge3(x,y,z:longint);
begin
inc(cnt); h[cnt].v:=y; h[cnt].w:=z; h[cnt].nxt:=sta[x]; sta[x]:=cnt;
inc(deg[y]);
end;
begin
assign(input,'road.in');
reset(input);
assign(output,'road.out');
rewrite(output);
readln(n,m);
tot:=0;
for i:=1 to m do
    begin
    readln(x,y,z);
    addedge(x,y,z);
    end;
for i:=1 to n do
    begin
    head:=1; tail:=1; q[1]:=i;
    fillchar(mark,sizeof(mark),false);
    mark[i]:=true;
    for j:=1 to n do dis[j]:=inf;
    dis[i]:=0;
    while head<=tail do
      begin
      p:=edge[q[head]];
      while p<>0 do
        begin
        if (dis[q[head]]+g[p].w<dis[g[p].v]) then
           begin
           dis[g[p].v]:=dis[q[head]]+g[p].w;
           if not mark[g[p].v] then
              begin
              mark[g[p].v]:=true;
              inc(tail);
              q[tail]:=g[p].v;
              end;
           end;
        p:=g[p].nxt;
        end;
      mark[q[head]]:=false;
      inc(head);
      end;
    tot2:=0;
    fillchar(edge2,sizeof(edge2),0);
    fillchar(inner,sizeof(inner),0);
    fillchar(flag,sizeof(flag),0);
    for j:=1 to n do
        begin
        p:=edge[j];
        if dis[j]=inf then continue;
        while p<>0 do
          begin
          if (dis[j]+g[p].w=dis[g[p].v]) then
             begin
             flag[p]:=1;
             addedge2(j,g[p].v,g[p].w);
             end;
          p:=g[p].nxt;
          end;
        end;
    head:=1; tail:=0;
    for j:=1 to n do if inner[j]=0 then begin inc(tail); q[tail]:=j; f[j]:=1; end else f[j]:=0;
    while head<=tail do
      begin
      p:=edge2[q[head]];
      while p<>0 do
        begin
        f[tg[p].v]:=(f[tg[p].v]+f[q[head]]) mod base;
        dec(inner[tg[p].v]);
        if inner[tg[p].v]=0 then begin inc(tail); q[tail]:=tg[p].v; end;
        p:=tg[p].nxt;
        end;
      inc(head);
      end;
    fillchar(sta,sizeof(sta),0);
    fillchar(deg,sizeof(deg),0);
    cnt:=0;
    for j:=1 to n do
        begin
        p:=edge2[j];
        while p<>0 do
          begin
          addedge3(tg[p].v,j,tg[p].w);
          p:=tg[p].nxt;
          end;
        end;
    head:=1; tail:=0;
    for j:=1 to n do if deg[j]=0 then begin inc(tail); q[tail]:=j; ff[j]:=1; end else ff[j]:=1;
    while head<=tail do
      begin
      p:=sta[q[head]];
      while p<>0 do
        begin
        ff[h[p].v]:=(ff[h[p].v]+ff[q[head]]) mod base;
        dec(deg[h[p].v]);
        if deg[h[p].v]=0 then begin inc(tail); q[tail]:=h[p].v; end;
        p:=h[p].nxt;
        end;
      inc(head);
      end;
    for j:=1 to n do
        begin
        p:=edge[j];
        while p<>0 do
          begin
          if flag[p]=1 then ans[p]:=(ans[p]+f[j]*ff[g[p].v] mod base) mod base;
          p:=g[p].nxt;
          end;
        end;
    end;
for i:=1 to m do writeln(ans[i]);
close(input);
close(output);
end.