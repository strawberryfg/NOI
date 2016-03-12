const maxn=70333;maxm=201111;
var u,v,w,nxt,pp:array[1..maxm] of longint;
    c:array[1..2*maxm] of longint;
    fa,fst,dfn,low,hash:array[1..maxn] of longint;
    n,m,res,ans,i,tot,time,cnt:longint;

function getfa(x:longint):longint;
begin
 if fa[x]<>x then fa[x]:=getfa(fa[x]);
 exit(fa[x]);
end;

procedure build(x,y:longint);
begin
 inc(tot);
 pp[tot]:=y;
 nxt[tot]:=fst[x];
 fst[x]:=tot;
end;

procedure clear;
begin
 cnt:=0;
 time:=0;
 fillchar(hash,sizeof(hash),0);
 fillchar(nxt,sizeof(nxt),0);
 fillchar(fst,sizeof(fst),0);
end;

function min(x,y:longint):longint;
begin
 if x<y then exit(x)
        else exit(y);
end;

{function check(x,y:longint):boolean;
 var p,q:longint;
begin
 p:=getfa(x);
 q:=getfa(y);
 if p<>q then exit(true);
 exit(false);
end; }

procedure dfs(x,fa:longint);
 var tmp,tc:longint;
begin
 hash[x]:=1;
 inc(time);
 dfn[x]:=time;
 low[x]:=time;
 tmp:=fst[x];
 tc:=0;
 while tmp>0 do
   begin
    if hash[pp[tmp]]=0 then dfs(pp[tmp],x);
    if (low[pp[tmp]]<low[x]) and (pp[tmp]<>fa) then low[x]:=low[pp[tmp]];
    if (pp[tmp]=fa) then inc(tc);
    tmp:=nxt[tmp];
   end;
 if tc>1 then exit;
 if (fa<>0) and (low[x]>dfn[fa]) then inc(res);
end;

procedure kruskal;
 var i,j,sum,p,q,h,t:longint;
begin
 sum:=0;
 for i:=1 to n do fa[i]:=i;
 h:=1;
 while h<=m do
   begin
     t:=h;
     while w[t]=w[t+1] do inc(t);
     clear;
     for j:=h to t do
       begin
         p:=getfa(u[j]);
         q:=getfa(v[j]);
         build(p,q);
         build(q,p);
         inc(cnt);
         c[cnt]:=p;
         inc(cnt);
         c[cnt]:=q;
       end;
     for j:=1 to cnt do if hash[c[j]]=0 then dfs(c[j],0);
     for j:=h to t do
       begin
         p:=getfa(u[j]);
         q:=getfa(v[j]);
         if p<>q then fa[p]:=q;
       end;
    h:=t+1;
   end;
end;

procedure sort(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=w[(l+r) div 2];
         repeat
           while w[i]<x do
            inc(i);
           while x<w[j] do
            dec(j);
           if not(i>j) then
             begin
                y:=u[i];u[i]:=u[j];u[j]:=y;
                y:=v[i];v[i]:=v[j];v[j]:=y;
                y:=w[i];w[i]:=w[j];w[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;

begin
assign(input,'road.in');reset(input);
assign(output,'ans.out');rewrite(output);
 readln(n,m);
 for i:=1 to m do readln(u[i],v[i],w[i]);
 sort(1,m);
 kruskal;
 writeln(res);
close(input);close(output);
end.
