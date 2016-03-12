const ch:array[1..8]of longint=(-1,-1,-1,-1,-1,-1,-1,-1);
      dir:array[1..8]of char=('C','G','E','A','B','F','D','H');
      maxn=1020; maxkind=1020; maxlen=1020; maxnumber=500020;
type rec=record next:array[1..26]of longint; fall,dep,flag:longint; end;
     querytype=record u,v:longint; w:char; end;
     re=record x,y:longint; end;
var n,m,kind,i,j,tot,root,x,head,tail,p,cnt,tx,ty,k,kk,up,tt:longint;
    f,g,h:array[0..2*maxn,0..maxn]of char;
    belf,belg,belh:array[0..2*maxn,0..maxn]of re;
    ind:array[0..2*maxn]of re;
    len:array[0..maxkind]of longint;
    s:array[0..maxkind,0..maxlen]of char;
    lh,lf:array[0..2*maxn]of longint;
    tree:array[0..maxnumber]of rec;
    q:array[0..maxnumber]of longint;
    s1:array[0..maxlen]of char;
    ans:array[0..maxkind]of querytype;
begin
{assign(input,'e:\wqf\wordpuzzle.in');
reset(input);
assign(output,'e:\wqf\wordpuzzle.out');
rewrite(output);}
readln(n,m,kind);
for i:=1 to n do
    begin
    for j:=1 to m do
        read(g[i][j]);
    readln;
    end;
for i:=1 to kind do
    begin
    len[i]:=0;
    while not eoln do begin inc(len[i]); if len[i]>maxlen then begin len[i]:=0; break; end; read(s[i][len[i]]); end;
    readln;
    end;
root:=1; tot:=1;  tree[1].fall:=0; tree[1].dep:=0;
for i:=1 to kind do
    begin
    x:=root;
    for j:=1 to len[i] do
        begin
        if (ord(s[i][j])-ord('A')+1>=1)and(ord(s[i][j])-ord('A')+1<=26) then
           tt:=ord(s[i][j])-ord('A')+1
        else
           tt:=ord(s[i][j])-ord('a')+1;
        if tree[x].next[tt]=0 then
           begin
           inc(tot);
           tree[x].next[tt]:=tot;
           tree[tot].dep:=tree[x].dep+1;
           end;
        x:=tree[x].next[tt];
        end;
    if x<>root then
       tree[x].flag:=i;
    end;
head:=1; tail:=1; q[1]:=root;
while head<=tail do
  begin
  x:=q[head];
  for i:=1 to 26 do
      begin
      if tree[x].next[i]<>0 then
         begin
         if x=root then tree[tree[x].next[i]].fall:=root
            else begin
                 p:=tree[x].fall;
                 while (p<>0) do
                   begin
                   if tree[p].next[i]<>0 then
                      begin
                      tree[tree[x].next[i]].fall:=tree[p].next[i];
                      break;
                      end;
                   p:=tree[p].fall;
                   end;
                 if p=0 then tree[tree[x].next[i]].fall:=root;
                 end;
         inc(tail); q[tail]:=tree[x].next[i];
         end;
      end;
  inc(head);
  end;
for i:=1 to n+m-1 do
    begin
    if i<=n then begin tx:=i; ty:=1; end
       else begin tx:=n; ty:=i-n+1; end;
    cnt:=0;
    while (tx>=1)and(ty<=m) do
      begin
      inc(cnt); h[i][cnt]:=g[tx][ty];
      belh[i][cnt].x:=tx; belh[i][cnt].y:=ty;
      dec(tx); inc(ty);
      end;
    lh[i]:=cnt;
    end;
for i:=1 to n+m-1 do
    begin
    if i<=m then begin tx:=1; ty:=m+1-i; end
       else begin tx:=i-m+1; ty:=1; end;
    cnt:=0;
    while (tx<=n)and(ty<=m) do
       begin
       inc(cnt); f[i][cnt]:=g[tx][ty];
       belf[i][cnt].x:=tx; belf[i][cnt].y:=ty;
       inc(tx); inc(ty);
       end;
    lf[i]:=cnt;
    end;
for i:=1 to n do
    for j:=1 to m do
        begin
        belg[i][j].x:=i;
        belg[i][j].y:=j;
        end;
for j:=1 to 8 do
    begin
    if j<=2 then up:=n
       else if j<=4 then up:=m
               else up:=n+m-1;
    for i:=1 to up do
        begin
        if j=1 then for k:=1 to m do begin s1[k]:=g[i][k]; ind[k]:=belg[i][k]; end
           else if j=2 then for k:=1 to m do begin s1[k]:=g[i][m+1-k]; ind[k]:=belg[i][m+1-k]; end
                else if j=3 then for k:=1 to n do begin s1[k]:=g[k][i]; ind[k]:=belg[k][i]; end
                         else if j=4 then for k:=1 to n do begin s1[k]:=g[n+1-k][i]; ind[k]:=belg[n+1-k][i]; end
                                 else if j=5 then for k:=1 to lh[i] do begin s1[k]:=h[i][k]; ind[k]:=belh[i][k]; end
                                         else if j=6 then for k:=1 to lh[i] do begin s1[k]:=h[i][lh[i]+1-k]; ind[k]:=belh[i][lh[i]+1-k]; end
                                                 else if j=7 then for k:=1 to lf[i] do begin s1[k]:=f[i][k]; ind[k]:=belf[i][k]; end
                                                         else for k:=1 to lf[i] do begin s1[k]:=f[i][lf[i]+1-k]; ind[k]:=belf[i][lf[i]+1-k]; end;
        if j<=2 then kk:=m
           else if j<=4 then kk:=n
                   else if j<=6 then kk:=lh[i]
                           else kk:=lf[i];
        x:=root;
        if (i=2)and(j=1) then
           x:=x;
        for k:=1 to kk do
            begin
           if (ord(s1[k])-ord('A')+1>=1)and(ord(s1[k])-ord('A')+1<=26) then
               tt:=ord(s1[k])-ord('A')+1
           else
               tt:=ord(s1[k])-ord('a')+1;
            while (tree[x].next[tt]=0)and(x<>root) do
               x:=tree[x].fall;
            x:=tree[x].next[tt];
            if x=0 then x:=root;
            tx:=x;
            while (tree[tx].flag<>-1)and(tx<>root) do
              begin
              if tree[tx].flag<>0 then
                 begin
                 if tree[tx].flag=1 then
                    root:=root;
                 ans[tree[tx].flag].u:=ind[k+ch[j]*(tree[tx].dep-1)].x;
                 ans[tree[tx].flag].v:=ind[k+ch[j]*(tree[tx].dep-1)].y;
                 ans[tree[tx].flag].w:=dir[j];
                 tree[tx].flag:=-1;
                 end;
              tx:=tree[tx].fall;
              end;
            end;
        end;
    end;
for i:=1 to kind do
    if ans[i].u=0 then writeln(-1,' ',-1,' ') else writeln(ans[i].u-1,' ',ans[i].v-1,' ',ans[i].w);
{close(input);
close(output);}
end.
