const maxn=1211111; inf=maxlongint;
var n,i,k,j,ans,num,mmin,sum:longint;
    a,r,tr,s,ts:array[0..maxn]of longint;
    cnt:array[0..maxn]of longint;
begin
assign(input,'work.in');
reset(input);
assign(output,'work.out');
rewrite(output);
read(n);
for i:=1 to n do begin read(a[i]); inc(cnt[a[i]]); a[n+i]:=a[i]; inc(cnt[a[n+i]]); end;
n:=2*n;
for i:=1 to maxn do cnt[i]:=cnt[i-1]+cnt[i];
for i:=n downto 1 do
    begin
    s[cnt[a[i]]]:=i;
    dec(cnt[a[i]]);
    end;
r[s[1]]:=1;
k:=1;
for i:=2 to n do
    begin
    if a[s[i-1]]<>a[s[i]] then inc(k);
    r[s[i]]:=k;
    end;
j:=1;
while k<n do
  begin
  tr:=r;
  fillchar(cnt,sizeof(cnt),0);
  for i:=1 to n do inc(cnt[r[i+j]]);
  for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
  for i:=n downto 1 do
      begin
      ts[cnt[r[i+j]]]:=i;
      dec(cnt[r[i+j]]);
      end;
  fillchar(cnt,sizeof(cnt),0);
  for i:=1 to n do
      begin
      r[i]:=tr[ts[i]];
      inc(cnt[r[i]]);
      end;
  for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
  for i:=n downto 1 do
      begin
      s[cnt[r[i]]]:=ts[i];
      dec(cnt[r[i]]);
      end;
  k:=1; r[s[1]]:=1; mmin:=n+100; sum:=0;
  for i:=2 to n do
      begin
      if (tr[s[i-1]]<>tr[s[i]])or(tr[s[i-1]+j]<>tr[s[i]+j]) then inc(k);
      if s[i]<=n div 2 then
         begin
         if k=mmin then inc(sum)
            else if k<mmin then begin mmin:=k; sum:=1; end;
         end;
      r[s[i]]:=k;
      end;
  if sum=1 then break;
  j:=j*2;
  end;
ans:=inf; num:=-1;
for i:=1 to n div 2 do if r[i]<ans then begin ans:=r[i]; num:=i; end;
for i:=num to num+(n div 2)-2 do write(a[i],' ');
write(a[num+(n div 2)-1]);
writeln;
close(input);
close(output);
end.