const maxn=201111;
var p,w,nxt,fst,s,c:array[1..maxn] of longint;
    hash,d:array[1..maxn] of boolean;
    f:array[1..maxn] of extended;
    n,m,i,xx,yy,ww,tot,cnt,flag,st:longint;
    ans:extended;

procedure build(x,y,ww:longint);
begin
 inc(tot);
 p[tot]:=y;
 w[tot]:=ww;
 nxt[tot]:=fst[x];
 fst[x]:=tot;
end;

procedure dfs(x:longint);
 var tmp:longint;
begin
 hash[x]:=true; s[x]:=0; f[x]:=0;
 tmp:=fst[x];
 while tmp>0 do
   begin
     if not hash[p[tmp]] then
        begin
          inc(s[x]);
          dfs(p[tmp]);
          f[x]:=f[x]+f[p[tmp]]+w[tmp];
        end;
     tmp:=nxt[tmp];
   end;
 if s[x]<>0 then f[x]:=f[x]/s[x];
end;

procedure work(x:longint);
 var tmp,k:longint;
     tt,ttt:extended;
begin
 ans:=ans+f[x]/n; hash[x]:=true;
 tmp:=fst[x];
 while tmp>0 do
   begin
     k:=p[tmp];
     if (not hash[k]) then
        begin
          tt:=f[x];ttt:=f[k];
          if s[x]=1 then f[x]:=0
                    else f[x]:=(f[x]*s[x]-(f[k]+w[tmp]))/(s[x]-1);
          dec(s[x]);
          f[k]:=(f[k]*s[k]+f[x]+w[tmp])/(s[k]+1); inc(s[k]);
          work(k);
          f[x]:=tt; inc(s[x]);
          f[k]:=ttt; dec(s[k]);
        end;
     tmp:=nxt[tmp];
   end;
end;

procedure solve(x:longint);
 var tmp,k:longint;
     tt,ttt:extended;
begin
 ans:=ans+f[x]/n; hash[x]:=true; d[x]:=true;
 tmp:=fst[x];
 while tmp>0 do
   begin
     k:=p[tmp];
     if (not hash[k]) and (not d[k]) then
        begin
          tt:=f[x];ttt:=f[k];
          if s[x]=1 then f[x]:=0
                    else f[x]:=(f[x]*s[x]-(f[k]+w[tmp]))/(s[x]-1);
          dec(s[x]);
          f[k]:=(f[k]*s[k]+f[x]+w[tmp])/(s[k]+1); inc(s[k]);
          solve(k);
          f[x]:=tt; inc(s[x]);
          f[k]:=ttt; dec(s[k]);
        end;
     tmp:=nxt[tmp];
   end;
end;
procedure dfs2(x:longint);
 var tmp:longint;
begin
 hash[x]:=true; s[x]:=0; f[x]:=0;
 tmp:=fst[x];
 while tmp>0 do
   begin
     if not hash[p[tmp]] then
        begin
          inc(s[x]);
          dfs2(p[tmp]);
          f[x]:=f[x]+f[p[tmp]]+w[tmp];
        end;
     tmp:=nxt[tmp];
   end;
 if s[x]<>0 then f[x]:=f[x]/s[x];
 hash[x]:=false;
end;

procedure find(x,fa:longint);
 var tmp:longint;
begin
 hash[x]:=true;
 tmp:=fst[x];
 while tmp>0 do
   begin
     if not hash[p[tmp]] then
        begin
          find(p[tmp],x);
          if flag=1 then
             begin
               inc(cnt);
               c[cnt]:=x;
               d[x]:=true;
               if x=st then flag:=2;
             end;
        end else
         if p[tmp]<>fa then
            begin
              st:=p[tmp];
              flag:=1;
              cnt:=1; c[1]:=x;
              d[x]:=true;
            end;
     if flag>0 then exit;
     tmp:=nxt[tmp];
   end;
end;

begin
assign(input,'park.in');reset(input);
assign(output,'park.out');rewrite(output);
 readln(n,m);
 fillchar(d,sizeof(d),false);
 for i:=1 to m do
   begin
     readln(xx,yy,ww);
     build(xx,yy,ww);
     build(yy,xx,ww);
   end;
if m=n-1 then
   begin
     ans:=0; fillchar(hash,sizeof(hash),false);
     dfs(1);
     fillchar(hash,sizeof(hash),false);
     work(1);
     writeln(ans:0:5);
   end else
begin
 fillchar(hash,sizeof(hash),false);
 flag:=0; ans:=0;
 find(1,0);
 for i:=1 to cnt do
   begin
     fillchar(hash,sizeof(hash),false);
     dfs2(c[i]);
     ans:=ans+f[c[i]]/n;
   end;
 for i:=1 to n do
   if not d[i] then
      begin
        fillchar(hash,sizeof(hash),false);
        dfs2(i);
        fillchar(hash,sizeof(hash),false);
        solve(i);
      end;
 writeln(ans:0:5);
end;
close(input);close(output);
end.
