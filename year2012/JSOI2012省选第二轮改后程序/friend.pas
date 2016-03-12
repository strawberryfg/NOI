const maxnum=120; maxbina=64; base=1000000007;
type rec=record x,y,id:longint; end;
     newtype=record l,r:longint; end;
     stacktype=record opt,ll,rr:longint; end;
     matrix=array[0..maxbina,0..maxbina]of qword;
     handtype=record v:array[1..4]of longint; end;
var n,m,num,i,j,cnt,top,max,final,u,k:longint;
    a:array[0..maxnum]of rec;
    g:array[0..maxnum,0..10]of longint;
    po:array[0..maxnum]of longint;
    b:array[0..maxnum]of newtype;
    stack:array[0..maxnum*2]of stacktype;
    hand:array[1..2,0..10]of handtype;
    wall,zero:array[0..10]of longint;
    f:array[0..3,0..10]of longint;
    sta:array[1..2]of longint;
    c,h,ans,std,ret,tt:matrix;
    spe:array[0..32,0..64,0..64]of qword;
procedure sort(l,r: longint);
var i,j,cmp: longint;
    swap:rec;
begin
i:=l; j:=r; cmp:=a[(l+r) div 2].y;
repeat
while a[i].y<cmp do inc(i);
while cmp<a[j].y do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure relabel;
var i,j,k:longint;
begin
i:=1; cnt:=0;
while i<=num do
  begin
  j:=i;
  while (j+1<=num)and(a[j+1].y=a[i].y) do inc(j);
  inc(cnt); po[cnt]:=a[i].y;
  for k:=i to j do g[cnt][a[k].x]:=-1;
  if a[i].y-2>=1 then b[cnt].l:=a[i].y-2 else b[cnt].l:=1;
  if a[i].y+2<=m then b[cnt].r:=a[i].y+2 else b[cnt].r:=m;
  i:=j+1;
  end;
end;
procedure cutit;
var i,j:longint;
begin
top:=0;
if b[1].l<>1 then begin inc(top); stack[top].opt:=1; stack[top].ll:=1; stack[top].rr:=b[1].l; end;
i:=1;
while i<=cnt do
  begin
  if i<>1 then begin inc(top); stack[top].opt:=1; stack[top].ll:=b[i-1].r; stack[top].rr:=b[i].l; end;
  j:=i;
  while (j+1<=cnt)and(b[j+1].l<=b[i].r) do inc(j);
  inc(top); stack[top].opt:=2; stack[top].ll:=b[i].l; stack[top].rr:=b[j].r;
  i:=j+1;
  end;
if b[cnt].r<m then begin inc(top); stack[top].opt:=1; stack[top].ll:=b[cnt].r; stack[top].rr:=m; end;
end;
function mul(x,y:matrix):matrix;
var i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
for k:=0 to max do
    for i:=0 to max do
        begin
        if x[i][k]=0 then continue;
        for j:=0 to max do
            c[i][j]:=(c[i][j]+x[i][k]*y[k][j] mod base)mod base;
        end;
exit(c);
end;
function find(x:longint):longint;
var ll,rr,mid:longint;
begin
ll:=1; rr:=cnt;
while ll<=rr do
  begin
  mid:=(ll+rr)div 2;
  if po[mid]=x then exit(mid)
     else if po[mid]<x then ll:=mid+1
             else rr:=mid-1;
  end;
exit(-1);
end;
procedure make(col:longint);
var i,x:longint;
begin
for i:=-1 to 2 do
    begin
    if (int64(col)+i<1)or(int64(col)+i>m) then f[i+1]:=wall
        else begin
             x:=find(col+i);
             if x=-1 then f[i+1]:=zero else f[i+1]:=g[x];
             end;
    end;
fillchar(h,sizeof(h),0);
end;
procedure dfs(x,y:longint);
var tmp:longint;
begin
if (x=1)and(y=1) then begin sta[1]:=0; sta[2]:=0; end;
if y>n then begin dfs(x+1,1); exit; end;
if x>2 then begin inc(h[sta[1]][sta[2]]); exit; end;
if f[x][y]=-1 then begin dfs(x,y+1); exit; end;
tmp:=0;
if (x>1)and(hand[x-1][y].v[2]<>0) then begin inc(tmp); hand[x][y].v[3]:=1; end;
if (y>1)and(hand[x][y-1].v[4]<>0) then begin inc(tmp); hand[x][y].v[1]:=1; end;
if tmp=2 then begin dfs(x,y+1); hand[x][y].v[3]:=0; hand[x][y].v[1]:=0; exit; end;
if tmp=0 then begin
              if x=2 then
                 begin
                 if (y+1<=n)and(f[x+1][y]<>-1)and(f[x][y+1]<>-1) then
                     begin hand[x][y].v[2]:=1; hand[x][y].v[4]:=1; sta[x]:=sta[x]+1 shl (y-1); dfs(x,y+1);
                           hand[x][y].v[2]:=0; hand[x][y].v[4]:=0; sta[x]:=sta[x]-1 shl (y-1); exit;
                     end;
                 end
              else
                 begin
                 if (f[x+1][y]<>-1)and(y+1<=n)and(f[x][y+1]<>-1) then    // | -
                    begin
                    hand[x][y].v[2]:=1; hand[x][y].v[4]:=1; sta[x]:=sta[x]+1 shl (y-1); dfs(x,y+1);
                    hand[x][y].v[2]:=0; hand[x][y].v[4]:=0; sta[x]:=sta[x]-1 shl (y-1);
                    end;
                 if (f[x+1][y]<>-1)and(f[x-1][y]<>-1) then               // - -
                    begin
                    hand[x][y].v[2]:=1; sta[x]:=sta[x]+1 shl (y-1); dfs(x,y+1);
                    hand[x][y].v[2]:=0; sta[x]:=sta[x]-1 shl (y-1);
                    end;
                 if (y+1<=n)and(f[x-1][y]<>-1)and(f[x][y+1]<>-1) then    // - |
                    begin
                    hand[x][y].v[4]:=1; dfs(x,y+1);
                    hand[x][y].v[4]:=0;
                    end;
                 end;
              exit;
              end;
if tmp=1 then
   begin
   if x=2 then
      begin         // -     |
      if (f[x+1][y]<>-1) then begin hand[x][y].v[2]:=1; sta[x]:=sta[x]+1 shl (y-1); dfs(x,y+1); sta[x]:=sta[x]-1 shl (y-1); hand[x][y].v[2]:=0; end;
      if (y+1<=n)and(f[x][y+1]<>-1) then begin hand[x][y].v[4]:=1; dfs(x,y+1); hand[x][y].v[4]:=0; end;
      end
   else
      begin
      if (f[x-1][y]<>-1) then begin dfs(x,y+1); end;     // - |                                         // |
      if (y+1<=n)and(f[x][y+1]<>-1) then begin hand[x][y].v[4]:=1; dfs(x,y+1); hand[x][y].v[4]:=0; end; // |
      if (f[x+1][y]<>-1) then begin hand[x][y].v[2]:=1; sta[x]:=sta[x]+1 shl (y-1); dfs(x,y+1); hand[x][y].v[2]:=0; sta[x]:=sta[x]-1 shl (y-1); end; // | -
      end;
   hand[x][y].v[1]:=0; hand[x][y].v[3]:=0;    //clear Important!!!!!!
   exit;
   end;
end;
procedure init;
var i,j:longint;
begin
fillchar(f,sizeof(f),0);
for i:=0 to max do
    begin
    sta[1]:=i;
    for j:=1 to n do
        if i and (1 shl (j-1))<>0 then hand[1][j].v[2]:=1;
    dfs(2,1);
    for j:=1 to n do
        if i and (1 shl (j-1))<>0 then hand[1][j].v[2]:=0;
    std[i]:=h[i];
    end;
end;
function quick(x:longint):matrix;
var now:longint;
begin
ret:=std;
dec(x);
now:=-1;
while x>0 do
  begin
  inc(now);
  if x mod 2=1 then ret:=mul(ret,spe[now]);
  x:=x div 2;
  end;
quick:=ret;
end;
procedure work;
var flag,kk1,kk2,i,j:longint;
    res:matrix;
begin
i:=1;
flag:=0;
if stack[1].opt=1 then
   begin
   make(1);   //include fillchar;
   dfs(1,1);
   ans:=h;
   if stack[1].rr-1-1>0 then
      begin
      res:=quick(stack[1].rr-1-1);
      ans:=mul(ans,res);
      end;
   i:=2;
   flag:=1;        //modified;
   end;
while i<=top do
  begin
  if stack[i].opt=2 then
     begin
     for j:=stack[i].ll to stack[i].rr-1 do
         begin
         make(j);
         if j=1 then dfs(1,1)
            else for kk1:=0 to max do
                     begin
                     sta[1]:=kk1;
                     for kk2:=1 to n do
                         if kk1 and (1 shl (kk2-1))<>0 then hand[1][kk2].v[2]:=1;
                     dfs(2,1);
                     for kk2:=1 to n do
                         if kk1 and (1 shl (kk2-1))<>0 then hand[1][kk2].v[2]:=0;
                     end;
         if flag=0 then ans:=h else ans:=mul(ans,h);
         flag:=1;
         end;
     end
  else
     begin
     if stack[i].rr<>m then
        begin
        res:=quick(stack[i].rr-stack[i].ll);
        if flag=0 then ans:=res else ans:=mul(ans,res);
        flag:=1;
        end
     else
        begin
        if stack[i].rr-stack[i].ll+1>2 then
           begin
           res:=quick(stack[i].rr-stack[i].ll-1);
           if flag=0 then ans:=res else ans:=mul(ans,res);
           end;
        if stack[i].rr-stack[i].ll+1>=2 then
           begin
           make(m-1);
           for kk1:=0 to max do
               begin
               sta[1]:=kk1;
               for kk2:=1 to n do
                   if kk1 and (1 shl (kk2-1))<>0 then hand[1][kk2].v[2]:=1;
               dfs(2,1);
               for kk2:=1 to n do
                   if kk1 and (1 shl (kk2-1))<>0 then hand[1][kk2].v[2]:=0;
               end;
           if flag=0 then ans:=h else ans:=mul(ans,h);
           end;
        end;
     end;
  inc(i);
  end;
end;
begin
assign(input,'friend.in');
reset(input);
assign(output,'friend.out');
rewrite(output);
readln(n,m,num);
max:=1 shl n-1;
for i:=1 to n do wall[i]:=-1;
for i:=1 to n do zero[i]:=0;
for i:=1 to num do
    begin
    readln(a[i].x,a[i].y);
    a[i].id:=i;
    end;
sort(1,num);
relabel;
if num=0 then
   begin
   top:=3;
   stack[1].opt:=1; stack[1].ll:=1; stack[1].rr:=2;
   stack[2].opt:=1; stack[2].ll:=2; stack[2].rr:=m-1;
   stack[3].opt:=1; stack[3].ll:=m-1; stack[3].rr:=m;
   end
else
   cutit;
init;
spe[0]:=std;
for u:=1 to 32 do
    begin
    for k:=0 to max do
        for i:=0 to max do
            begin
            if spe[u-1][i][k]=0 then continue;
            for j:=0 to max do
                spe[u][i][j]:=(spe[u][i][j]+spe[u-1][i][k]*spe[u-1][k][j])mod base;
            end;
    end;
work;
final:=0;
for i:=0 to max do
    for j:=0 to max do
        final:=(final+ans[i][j])mod base;
writeln(final);
close(input);
close(output);
end.