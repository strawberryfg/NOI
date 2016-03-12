const maxn=1020; max=31111; base=10000;
type arr=array[-1..1000]of longint;
var col,n,d,i,t,now,pd,j,cnt,x,sum,opt:longint;
    a:array[0..maxn]of longint;
    prime,fz,fm,hash:array[0..max]of longint;
    check:array[0..max]of boolean;
    ansfz,ansfm,c,std:arr;
procedure prepare;
var i,j:longint;
begin
fillchar(check,sizeof(check),false);
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; hash[i]:=cnt; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>max then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then break;
        end;
    end;
end;
function mul(x,y:arr):arr;
var i,j,k,maxx:longint;
begin
fillchar(c,sizeof(c),0);
maxx:=x[-1]+y[-1];
for i:=0 to x[-1] do
    for j:=0 to y[-1] do
        begin
        c[i+j]:=c[i+j]+x[i]*y[j];
        k:=i+j;
        while c[k]>=base do
          begin
          if k>maxx then maxx:=k;
          c[k+1]:=c[k+1]+c[k] div base;
          c[k]:=c[k] mod base;
          inc(k);
          end;
        end;
if c[maxx+1]<>0 then inc(maxx);
c[-1]:=maxx;
exit(c);
end;
function conv(x:longint):arr;
var ret:arr;
begin
ret[-1]:=-1;
while x>=base do begin inc(ret[-1]); ret[ret[-1]]:=x mod base; x:=x div base; end;
if x<>0 then begin inc(ret[-1]); ret[ret[-1]]:=x; end;
conv:=ret;
end;
procedure print(x:arr);
var i:longint;
begin
write(x[x[-1]]);
for i:=x[-1]-1 downto 0 do
    if x[i]>999 then write(x[i])
       else if x[i]>99 then write('0',x[i])
               else if x[i]>9 then write('00',x[i])
                       else write('000',x[i]);
end;
begin
assign(input,'bag.in');
reset(input);
assign(output,'bag.out');
rewrite(output);
prepare;
read(col,n,d);
for i:=1 to col do begin read(a[i]); sum:=sum+a[i]; end;
pd:=1;
for i:=1 to n do
    begin
    read(t,now);
    if a[now]=0 then begin pd:=0; break; end;
    j:=1; x:=a[now];
    while j<=cnt do
      begin
      if prime[j]*prime[j]>x then break;
      while x mod prime[j]=0 do begin inc(fz[j]); x:=x div prime[j]; end;
      inc(j);
      end;
    if x<>1 then inc(fz[hash[x]]);
    j:=1; x:=sum;
    while j<=cnt do
      begin
      if prime[j]*prime[j]>x then break;
      while x mod prime[j]=0 do begin inc(fm[j]); x:=x div prime[j]; end;
      inc(j);
      end;
    if x<>1 then inc(fm[hash[x]]);
    a[now]:=a[now]+d; sum:=sum+d;
    end;
if pd=0 then write('0/1')
   else begin
        for i:=1 to cnt do if fz[i]<>fm[i] then begin pd:=2; break; end;
        if pd=1 then writeln('1/1')
           else begin
                ansfz[-1]:=0; ansfz[0]:=1; ansfm[-1]:=0; ansfm[0]:=1;
                for i:=1 to cnt do
                    begin
                    if fz[i]=fm[i] then continue;
                    if fz[i]>fm[i] then begin opt:=1; x:=fz[i]-fm[i]; end else begin opt:=2; x:=fm[i]-fz[i]; end;
                    std:=conv(prime[i]);
                    while x>0 do
                      begin
                      if x mod 2=1 then
                         begin
                         if opt=1 then ansfz:=mul(ansfz,std) else ansfm:=mul(ansfm,std);
                         end;
                      x:=x div 2; if x=0 then break;
                      std:=mul(std,std);
                      end;
                    end;
                print(ansfz); write('/'); print(ansfm); writeln;
                end;
        end;
close(input);
close(output);
end.