const maxn=200000; maxm=200000; maxdianming=200000; maxlen=200000; maxq=200000;
type rec=record u,v,nxt:longint; end;
     treetype=record fall,flag:longint; end;
     newtype=record ll,rr:longint; end;
var n,m,tot,cnt,total,edg,i,j,len,k,x,t,v,head,tail,p,pp,tx:longint;
    h:array[0..maxlen]of longint;   //maioxingren mingzizongchang
    s:array[1..2,0..maxn]of newtype;    //maxn miaoxingrengeshu
    a:array[0..maxm]of longint;     //dianmingchuanzongchang
    edge,edge2:array[0..maxm]of longint;
    g:array[0..maxm]of rec;
    tg:array[0..maxm]of rec;
    tree:array[0..maxm]of treetype;
    hash,ret:array[0..maxdianming]of longint;
    ans:array[0..maxn]of longint;
    root:array[1..2]of longint;
    q:array[0..maxq]of longint;
    gg:array[0..1000,0..10000]of longint;
procedure addedge(x,y:longint);
begin
inc(edg); g[edg].u:=x; g[edg].v:=y; g[edg].nxt:=edge[x]; edge[x]:=edg;
end;
procedure addedge2(x,y:longint);
begin
inc(cnt); tg[cnt].u:=x; tg[cnt].v:=y; tg[cnt].nxt:=edge2[x]; edge2[x]:=cnt;
end;
function check(x,y:longint):longint;
var p:longint;
begin
if (x<=1000)and(y<=10000) then if gg[x][y]<>0 then exit(gg[x][y]);
p:=edge[x];
while p<>0 do
  begin
  if a[g[p].v]=y then begin if (x<=1000)and(y<=10000) then gg[x][y]:=g[p].v; exit(g[p].v); end;
  p:=g[p].nxt;
  end;
exit(-1);
end;
begin
assign(input,'name.in');
reset(input);
assign(output,'name.out');
rewrite(output);
readln(n,m);
tot:=0;
cnt:=0;
total:=0;
edg:=0;
for i:=1 to n do
    begin
    for j:=1 to 2 do
        begin
        read(len);
        for k:=1 to len do
            begin
            inc(tot);
            read(h[tot]);
            if k=1 then s[j][i].ll:=tot;
            if k=len then s[j][i].rr:=tot;
            end;
        end;
    end;
root[1]:=1;
total:=1;
for i:=1 to m do
    begin
    for j:=1 to 1 do
        begin
        read(len);
        x:=root[j];
        for k:=1 to len do
            begin
            read(v);
            t:=check(x,v);
            if t=-1 then
               begin
               inc(total);
               a[total]:=v;
               addedge(x,total);
               x:=total;
               end
            else
               x:=t;
            end;
        addedge2(x,i);
        end;
    end;
for i:=1 to 1 do
    begin
    head:=1; tail:=1; q[1]:=root[i];
    tree[root[i]].fall:=0;
    while head<=tail do
      begin
      p:=edge[q[head]];
      while p<>0 do
        begin
        if q[head]=root[i] then tree[g[p].v].fall:=root[i]
           else begin
                pp:=tree[q[head]].fall;
                while pp<>0 do
                  begin
                  t:=check(pp,a[g[p].v]);
                  if t<>-1 then
                     begin
                     tree[g[p].v].fall:=t;
                     break;
                     end;
                  pp:=tree[pp].fall;
                  end;
                if pp=0 then tree[g[p].v].fall:=root[i];
                end;
        inc(tail);
        q[tail]:=g[p].v;
        p:=g[p].nxt;
        end;
      inc(head);
      end;
    end;
for i:=1 to n do
    begin
    ans[i]:=0;
    for j:=1 to 2 do
        begin
        x:=root[1];
        for k:=s[j][i].ll to s[j][i].rr do
            begin
            t:=check(x,h[k]);
            while (x<>root[1])and(t=-1) do
               begin
               x:=tree[x].fall;
               t:=check(x,h[k]);
               end;
            t:=check(x,h[k]);
            if t=-1 then x:=root[1] else x:=t;
            tx:=x;
            while (tx<>root[1])and(tree[tx].flag<>i) do
              begin
              p:=edge2[tx];
              while p<>0 do
                begin
                if hash[tg[p].v]<>i then
                   begin
                   hash[tg[p].v]:=i;    //count
                   inc(ans[i]);
                   inc(ret[tg[p].v]);
                   end;
                p:=tg[p].nxt;
                end;
              tree[tx].flag:=i;
              tx:=tree[tx].fall;
              end;
            end;
        end;
    end;
for i:=1 to m do writeln(ret[i]);
for i:=1 to n-1 do write(ans[i],' ');
write(ans[n]);
writeln;
close(input);
close(output);
end.