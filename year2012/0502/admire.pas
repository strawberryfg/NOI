const base=20120427; maxstate=80000;
      num:array[1..9,1..4]of longint=
      ((0,0,0,0),(1,0,0,0),(0,1,0,0),(2,0,0,0),(0,0,1,0),
       (1,1,0,0),(0,0,0,1),(3,0,0,0),(0,2,0,0));
type rec=record x:array[1..4]of longint; end;
     querytype=record ll,rr,n:int64; end;
var now,test,i,j,k,l,tot,xxa,xxb,xxc,xxd,len:longint;
    ll,rr,ans,tmp,max,maxnumber:int64;
    h:array[0..20]of longint;
    sta:array[0..maxstate]of rec;
    f,g:array[0..20,0..maxstate,1..9]of int64;
    bel:array[0..61,0..38,0..26,0..22]of longint;
    que:array[0..5020]of querytype;
procedure init;
begin
tot:=0;
end;
function pow(x,y:longint):int64;
var tx:int64;
begin
pow:=1;
tx:=x;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*tx;
  if y=1 then break;
  tx:=tx*tx;
  y:=y div 2;
  end;
end;
function calc(x:int64; a,b,c,opt:longint):longint;
var res,tmp:int64;
    i:longint;
begin
res:=1;
res:=res*pow(2,a);
res:=res*pow(3,b);
res:=res*pow(5,c);
x:=x div res;
tmp:=1;
for i:=0 to 63 do
    begin
    if (tmp<=x)and(tmp*opt>x) then exit(i);
    tmp:=tmp*opt;
    end;
end;
procedure work;
var i,j,k,a,b,c,d,xa,xb,xc,xd,idx,idy,id:longint;
begin
for i:=1 to 9 do
    begin
    xa:=num[i][1]; xb:=num[i][2]; xc:=num[i][3]; xd:=num[i][4];
    id:=bel[xa][xb][xc][xd];
    f[1][id][i]:=1;
    g[1][id][i]:=i;
    end;
for i:=2 to len do
    for j:=1 to tot do
        begin
        a:=sta[j].x[1]; b:=sta[j].x[2]; c:=sta[j].x[3]; d:=sta[j].x[4];
        idx:=bel[a][b][c][d];
        for k:=1 to 9 do    //the i-th number
            begin
            xa:=num[k][1]; xb:=num[k][2]; xc:=num[k][3]; xd:=num[k][4];
            if (a<xa)or(b<xb)or(c<xc)or(d<xd) then continue;
            for l:=1 to 9 do  //the first number
                begin
                if (a>=xa)and(b>=xb)and(c>=xc)and(d>=xd)then
                   begin
                   idy:=bel[a-xa][b-xb][c-xc][d-xd];
                   if f[i-1][idy][l]<>0 then
                      begin
                      f[i][idx][l]:=(f[i][idx][l]+f[i-1][idy][l])mod base;
                      g[i][idx][l]:=((g[i][idx][l]+g[i-1][idy][l]*10 mod base)mod base+k*f[i-1][idy][l] mod base) mod base;
                      end;
                   end;
                end;
            end;
        end;
end;
function calc2(x:int64):int64;
var tmp,i,j,tlen,xa,xb,xc,xd,id:longint;
    tx,ret,now,last:int64;
begin
if x=0 then exit(0);
tx:=x;
tlen:=0;
while tx>0 do begin inc(tlen); h[tlen]:=tx mod 10; tx:=tx div 10; end;
for i:=1 to tlen div 2 do begin tmp:=h[i]; h[i]:=h[tlen+1-i]; h[tlen+1-i]:=tmp; end;
ret:=0;
for i:=1 to 9 do
    begin
    id:=bel[xxa][xxb][xxc][xxd];
    ret:=(ret+g[tlen-1][id][i])mod base;
    end;
xa:=0; xb:=0; xc:=0; xd:=0;
now:=1;
for i:=1 to tlen-1 do now:=now*10;
last:=0;
for i:=1 to tlen-1 do
    begin
    if h[i]<>0 then
       begin
       xa:=xa+num[h[i]][1]; xb:=xb+num[h[i]][2]; xc:=xc+num[h[i]][3]; xd:=xd+num[h[i]][4];
       end
    else
       break;
    last:=(last*10 mod base+h[i])mod base;
    if xa>xxa then break;
    if xb>xxb then break;
    if xc>xxc then break;
    if xd>xxd then break;
    for j:=1 to h[i+1]-1 do
        begin
        id:=bel[xxa-xa][xxb-xb][xxc-xc][xxd-xd];
        if g[tlen-i][id][j]<>0 then
           ret:=(ret+(last mod base*now mod base*f[tlen-i][id][j] mod base+g[tlen-i][id][j]))mod base;
        end;
    now:=now div 10;
    end;
if h[tlen]<>0 then
   begin
   xa:=xa+num[h[tlen]][1]; xb:=xb+num[h[tlen]][2]; xc:=xc+num[h[tlen]][3]; xd:=xd+num[h[tlen]][4];
   if (xa=xxa)and(xb=xxb)and(xc=xxc)and(xd=xxd) then ret:=(ret+x)mod base;
   end;
for i:=1 to h[1]-1 do
    begin
    id:=bel[xxa][xxb][xxc][xxd];
    ret:=(ret+g[tlen][id][i])mod base;
    end;
exit(ret);
end;
begin
assign(input,'admire.in');
reset(input);
assign(output,'admire.out');
rewrite(output);
readln(test);
for now:=1 to test do
    begin
    readln(que[now].ll,que[now].rr,que[now].n);
    if que[now].n>max then max:=que[now].n;
    if que[now].rr>maxnumber then maxnumber:=que[now].rr;
    end;
len:=0;
while maxnumber>0 do begin inc(len); maxnumber:=maxnumber div 10; end;
for i:=0 to calc(max,0,0,0,2) do
    for j:=0 to calc(max,i,0,0,3) do
        for k:=0 to calc(max,i,j,0,5) do
            for l:=0 to calc(max,i,j,k,7) do
                begin
                inc(tot);
                sta[tot].x[1]:=i; sta[tot].x[2]:=j; sta[tot].x[3]:=k; sta[tot].x[4]:=l;
                bel[i][j][k][l]:=tot;
                end;
work;
for now:=1 to test do
    begin
    tmp:=que[now].n;
    xxa:=0; xxb:=0; xxc:=0; xxd:=0;
    while tmp mod 2=0 do begin inc(xxa); tmp:=tmp div 2; end;
    while tmp mod 3=0 do begin inc(xxb); tmp:=tmp div 3; end;
    while tmp mod 5=0 do begin inc(xxc); tmp:=tmp div 5; end;
    while tmp mod 7=0 do begin inc(xxd); tmp:=tmp div 7; end;
    if tmp<>1 then writeln(0) else
       begin
       ans:=calc2(que[now].rr)-calc2(que[now].ll-1);
       ans:=ans mod base;
       if ans<0 then ans:=ans+base;
       writeln(ans);
       end;
    end;
close(input);
close(output);
end.