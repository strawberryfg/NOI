//11:11; 11:17;
const maxn=1020; max=320;
var n,i,j,k:longint;
    a,r,tr,s,ts,cnt,h:array[0..maxn]of longint;
    s1:string;
begin
assign(input,'suffixarray.in');
reset(input);
assign(output,'suffixarray.out');
rewrite(output);
readln(s1);
n:=length(s1);
for i:=1 to n do begin a[i]:=ord(s1[i]); inc(cnt[a[i]]); end;
for i:=1 to max do cnt[i]:=cnt[i-1]+cnt[i];
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
  k:=1;
  r[s[1]]:=1;
  for i:=2 to n do
      begin
      if (tr[s[i-1]]<>tr[s[i]])or(tr[s[i-1]+j]<>tr[s[i]+j]) then inc(k);
      r[s[i]]:=k;
      end;
  j:=j*2;
  end;
h[1]:=0; j:=0;
for i:=1 to n do
    begin
    if r[i]>1 then
       begin
       k:=s[r[i]-1];
       while (a[k+j]=a[i+j])and(a[k+j]<>0)and(a[i+j]<>0) do inc(j);
       h[r[i]]:=j;
       if j>0 then dec(j);
       end;
    end;
for i:=1 to n do writeln(i,'        :',h[i]);
for i:=1 to n do write(r[i],' ');
writeln;
close(input);
close(output);
end.