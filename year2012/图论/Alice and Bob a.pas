const maxn=20020; maxm=40020;
type rec=record v,nxt:longint; end;
var now,test,n,m,x,y,i,tot,tme,num,tmp,last:longint;
    edge,dfn,low:array[0..maxn]of longint;
    ans:array[0..maxn,0..2]of longint;
    g:array[0..maxm]of rec;
procedure addedge(x,y:longint); inline;
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure init; inline;
begin
tot:=0; tme:=0;
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
fillchar(ans,sizeof(ans),0);
fillchar(dfn,sizeof(dfn),0);
fillchar(low,sizeof(low),0);
end;
procedure update(x,y:longint); inline;
begin
if x=-1 then exit;
if ans[x][1]=0 then ans[x][1]:=y else ans[x][2]:=y;
end;
procedure dfs(x,fa:longint); inline;
var p,num,child,son:longint;
begin
inc(tme);
low[x]:=tme; dfn[x]:=tme;
p:=edge[x]; num:=-1; child:=-1; son:=0;
while p<>0 do
  begin
  if dfn[g[p].v]=0 then
     begin
     dfs(g[p].v,x);
     inc(son);
     child:=g[p].v;
     if low[g[p].v]<low[x] then
        begin
        low[x]:=low[g[p].v];
        num:=g[p].v;
        end;
     end
  else if (g[p].v<>fa)and(dfn[g[p].v]<low[x]) then
          begin
          low[x]:=dfn[g[p].v];
          num:=g[p].v;
          end;
  p:=g[p].nxt;
  end;
if son=0 then
   begin
   ans[x][1]:=fa; ans[x][2]:=num;
   update(fa,x); update(num,x);
   end
else if (son=1)and(x<>1) then
        begin
        if fa=1 then
           begin
           ans[x][2]:=fa;
           update(fa,x);
           end
        else
           begin
           if low[child]<dfn[fa] then begin update(x,fa); update(fa,x); end
              else begin update(x,num); update(num,x); end;
           end;
        end;
end;
begin
{assign(input,'a.in');
reset(input);
assign(output,'a.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    readln(n,m);
    init;
    for i:=1 to n+m do
        begin
        read(x,y);
        addedge(x,y);
        addedge(y,x);
        end;
    dfs(1,0);
    if ans[1][1]<ans[1][2] then num:=ans[1][1] else num:=ans[1][2];
    write(1);
    last:=1;
    for i:=1 to n-1 do
        begin
        write(' ');
        write(num);
        tmp:=num;
        if ans[num][1]=last then num:=ans[num][2] else num:=ans[num][1];
        last:=tmp;
        end;
    writeln;
    end;
{close(input);
close(output);}
end.