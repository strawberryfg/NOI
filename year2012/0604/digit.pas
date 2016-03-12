var i,all,j,k,pd,num,down:longint;
    tot,sum,last,x,n:int64;
    a,cnt,pow,f:array[-1..100]of int64;
    b:array[-1..100]of longint;
begin
assign(input,'digit.in');
reset(input);
assign(output,'digit.out');
rewrite(output);
tot:=0;
for i:=0 to 9 do begin read(a[i]); tot:=tot+a[i]; end;
pow[0]:=1; for i:=1 to 18 do pow[i]:=pow[i-1]*int64(10);
for i:=1 to 18 do
    begin
    for j:=1 to i-1 do
        f[i]:=f[i]+int64(i-j)*int64(pow[j]-pow[j-1]);
    f[i]:=f[i]+i;
    end;
sum:=0;
for i:=1 to 18 do
    begin
    sum:=sum+(pow[i]-pow[i-1])*int64(i);
    if sum>=tot then begin num:=i; break; end;
    last:=sum;
    end;
if (tot-last) mod num<>0 then writeln(-1)
   else begin
        n:=(tot-last) div num+pow[num-1]-1;
        x:=n; all:=0;
        while x>0 do
          begin
          inc(all); b[all]:=x mod 10;
          x:=x div 10;
          end;
        for i:=1 to all div 2 do begin b[i]:=b[i]+b[all+1-i]; b[all+1-i]:=b[i]-b[all+1-i]; b[i]:=b[i]-b[all+1-i]; end;
        for i:=1 to all-1 do
            begin
            cnt[0]:=cnt[0]+int64(i-1)*pow[i-1]-int64(pow[i-1]-1) div 9-(int64(i-2)*pow[i-2]-int64(pow[i-2]-1)div 9);
            for j:=1 to 9 do
               cnt[j]:=cnt[j]+int64(i)*pow[i-1]-int64(i-1)*pow[i-2];
            end;
        for i:=1 to all do
            begin
            down:=0; if i=1 then down:=1;
            for j:=down to b[i]-1 do
                begin
                cnt[j]:=cnt[j]+pow[all-i];
                for k:=1 to i-1 do inc(cnt[b[k]],pow[all-i]);
                if i<>all then
                   begin
                   for k:=1 to 9 do
                       cnt[k]:=cnt[k]+(all-i)*pow[all-i-1];
                   cnt[0]:=cnt[0]+int64(all-i-1)*pow[all-i-1]-int64(pow[all-i-1]-1) div 9+f[all-i];
                   end;
                end;
            end;
        for i:=1 to all do inc(cnt[b[i]]);
        pd:=0;
        for i:=0 to 9 do if cnt[i]<>a[i] then begin pd:=1; break; end;
        if pd=1 then writeln(-1)
           else writeln(n);
        end;
close(input);
close(output);
end.
