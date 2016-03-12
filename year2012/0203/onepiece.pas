const maxn=100; maxm=10; inf=maxlongint;
type rec=record u,v,w,nxt:longint; end;
var n,m,i,x,y,z,head,tail,j,k,t,tot,ttt:longint;
    max:extended;
    a:array[0..maxm,1..2]of longint;
    p:array[0..maxm]of extended;
    three,h:array[0..maxm]of longint;
    f:array[0..70000,0..maxn]of extended;
    g:array[0..maxn]of rec;
    q,edge,hash:array[0..maxn]of longint;
    dis:array[0..maxn]of extended;
    flag:boolean;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=z;
g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function min(x,y:extended):extended;
begin
if y-x>1e-10 then exit(x) else exit(y);
end;
begin
assign(input,'onepiece.in');
reset(input);
assign(output,'onepiece.out');
rewrite(output);
readln(n,m);
for i:=1 to m do read(a[i][1]);
for i:=1 to m do read(a[i][2]);
for i:=1 to m do
    begin
    read(p[i]);
    p[i]:=p[i];
    end;
for i:=1 to n-1 do
    begin
    readln(x,y,z);
    addedge(x,y,z);
    addedge(y,x,z);
    end;
three[0]:=1;
for i:=1 to maxm do three[i]:=three[i-1]*3;
for i:=0 to three[m] do
    for j:=1 to n do
        f[i][j]:=inf;
for i:=three[m]-1 downto 0 do
    begin
    flag:=false;
    for j:=1 to m do
        begin
        h[j]:=(i mod three[j])div three[j-1];
        if h[j]=0 then flag:=true;
        end;
    if not flag then
       begin
       for j:=1 to n do dis[j]:=inf;
       dis[1]:=0;
       head:=1; tail:=1; q[1]:=1;
       max:=-inf;
       while head<=tail do
         begin
         x:=q[head];
         t:=edge[x];
         while t<>0 do
           begin
           if dis[g[t].v]-(dis[x]+a[g[t].w][h[g[t].w]])>1e-10 then
              begin
              dis[g[t].v]:=dis[x]+a[g[t].w][h[g[t].w]];
              inc(tail);
              q[tail]:=g[t].v;
              end;
           t:=g[t].nxt;
           end;
         inc(head);
         end;
       for j:=1 to n do if dis[j]-max>1e-10 then max:=dis[j];
       for j:=1 to n do
           begin
           if abs(dis[j]-max)<1e-10 then f[i][j]:=0;
           end;
       end
    else
       begin
       for j:=1 to n do
           begin
           for k:=1 to m do
               begin
               if h[k]=0 then
                  begin
                  f[i][j]:=min(f[i][j],(f[i+three[k-1]][j]*p[k]+(100-p[k])*f[i+2*three[k-1]][j])/100);
                  if (i=1)and(j=1) then
                     ttt:=1;
                  end;
               end;
           t:=edge[j];
           while t<>0 do
             begin
             if h[g[t].w]=0 then
                begin
                f[i][j]:=min(f[i][j],((f[i+three[g[t].w-1]][g[t].v]+a[g[t].w][1])*p[g[t].w]+(f[i+2*three[g[t].w-1]][g[t].v]+a[g[t].w][2])*(100-p[g[t].w]))/100);
                if (i=1)and(j=1) then
                     ttt:=1;
                end;
             t:=g[t].nxt;
             end;
           end;
       end;
    for j:=1 to n do hash[j]:=0;
    for j:=1 to n do
        begin
        head:=1; tail:=1; q[1]:=j;
        if hash[j]<>0 then continue;
        while head<=tail do
          begin
          x:=q[head];
          t:=edge[x];
          while t<>0 do
            begin
            if h[g[t].w]<>0 then
               begin
               if (f[i][g[t].v]-(f[i][x]+a[g[t].w][h[g[t].w]])>1e-10) then
                  begin
                  f[i][g[t].v]:=f[i][x]+a[g[t].w][h[g[t].w]];
                  if (i=1)and(g[t].v=1) then
                     ttt:=1;
                  if hash[g[t].v]=0 then
                     begin
                     inc(tail);
                     q[tail]:=g[t].v;
                     hash[g[t].v]:=1;
                     end;
                  end;
               end;
            t:=g[t].nxt;
            end;
          inc(head);
          end;
        end;
    end;
{for i:=0 to three[m]-1 do
    for j:=1 to n do
        writeln(i,' ',j,' ',f[i][j]:0:6);}
writeln(f[0][1]:0:6);
close(input);
close(output);
end.
