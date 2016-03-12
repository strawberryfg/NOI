const maxn=111;
type rec=record v,nxt:longint; end;
var n,most,tot,i,j,k,p,t,x,len:longint;
    edge,fa,vis,savefa,sta:array[0..maxn]of longint;
    g:array[0..maxn]of rec;
    c,pow:array[0..maxn+10]of extended;
    res,ans,num:extended;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure cmax(var x:extended; y:extended);
begin
if y>x then x:=y;
end;
procedure dfs(x,d:longint);
var p:longint;
begin
vis[x]:=1;
res:=res+pow[d]*c[x];
p:=edge[x];
while p<>0 do
  begin
  if vis[g[p].v]=0 then dfs(g[p].v,d+1);
  p:=g[p].nxt;
  end;
end;
procedure dfs2(x,opt:longint);
var i,xx,len:longint;
begin
if opt>most then exit;
if x>n then
   begin
   for i:=1 to n do
       if sta[i]=1 then
          begin
          fa[i]:=1;
          end;
   fillchar(edge,sizeof(edge),0);
   fillchar(vis,sizeof(vis),0);
   tot:=0; res:=0;
   for i:=1 to n do
       addedge(fa[i],i);
   fa[i]:=1;
   dfs(1,0);
   len:=0;
   xx:=fa[1];
   while (xx<>1)or(len=0) do
     begin
     inc(len);
     xx:=fa[xx];
     end;
   inc(len);
   res:=res/(1-pow[len]);
   cmax(ans,res);
   fa:=savefa;
   exit;
   end;
for i:=0 to 1 do
    begin
    sta[x]:=i;
    dfs2(x+1,opt+i);
    end;
end;
begin
assign(input,'trans.in');
reset(input);
assign(output,'trans.out');
rewrite(output);
readln(n,most,num);
for i:=1 to n do read(fa[i]);
for i:=1 to n do read(c[i]);
pow[0]:=1;
for i:=1 to n do pow[i]:=pow[i-1]*num;
savefa:=fa;
if most<=1 then
   begin
   len:=0;
   x:=fa[1];
   while (x<>1)or(len=0) do
     begin
     inc(len);
     x:=fa[x];
     end;
   inc(len);
   for i:=1 to n do addedge(fa[i],i);
   res:=0;
   dfs(1,0);
   res:=res/(1-pow[len]);
   ans:=res;
   if most=1 then
      begin
      for i:=2 to n do
          begin
          if fa[i]<>1 then
             begin
             fillchar(edge,sizeof(edge),0);
             fillchar(vis,sizeof(vis),0);
             tot:=0; res:=0;
             t:=fa[i];
             fa[i]:=1;
             for j:=1 to n do
                 addedge(fa[j],j);
             fa[i]:=1;
             dfs(1,0);
             len:=0;
             x:=fa[1];
             while (x<>1)or(len=0) do
               begin
               inc(len);
               x:=fa[x];
               end;
             inc(len);
             res:=res/(1-pow[len]);
             cmax(ans,res);
             fa[i]:=t;
             end;
          end;
      end;
   writeln(ans:0:2);
   end
else if ((n<=6)and(most<=6))or((n<=12)and(most<=12)) then
        begin
        ans:=0;
        dfs2(2,0);
        writeln(ans:0:2);
        end
     else if most=n-2 then
             begin
             ans:=0;
             for i:=2 to n-1 do
                 for j:=i+1 to n do
                     begin
                     for k:=2 to n do
                         begin
                         if (k<>i)and(k<>j) then fa[k]:=1;
                         end;
                     fillchar(edge,sizeof(edge),0);
                     fillchar(vis,sizeof(vis),0);
                     tot:=0; res:=0;
                     for p:=1 to n do
                         addedge(fa[p],p);
                     fa[i]:=1;
                     dfs(1,0);
                     len:=0;
                     x:=fa[1];
                     while (x<>1)or(len=0) do
                       begin
                       inc(len);
                       x:=fa[x];
                       end;
                     inc(len);
                     res:=res/(1-pow[len]);
                     cmax(ans,res);
                     fa:=savefa;
                     end;
             writeln(ans:0:2);
             end;
close(input);
close(output);
end.