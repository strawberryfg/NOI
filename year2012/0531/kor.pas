const maxn=200010; maxmo=2742362;
      mo:array[1..4]of int64=(2742361,2427499,2518267,2681803);
var n,i,j,ans,cnt,pd1,pd2,t,k:longint;
    tmp:int64;
    pow:array[0..maxn,1..4]of int64;
    num:array[0..maxn]of longint;
    hashl,hashr:array[0..maxn,1..4]of int64;
    a:array[0..maxn]of int64;
    flag:array[0..maxmo,1..4]of longint;
begin
assign(input,'kor.in');
reset(input);
assign(output,'kor.out');
rewrite(output);
readln(n);
for i:=1 to n do read(a[i]);
for i:=1 to 4 do pow[0][i]:=1;
for i:=1 to n do
    for j:=1 to 4 do
        pow[i][j]:=pow[i-1][j]*int64(999983) mod mo[j];
for i:=1 to n do for j:=1 to 4 do hashr[i][j]:=(hashr[i-1][j]*int64(999983) mod mo[j]+int64(a[i])-int64(1)) mod mo[j];
for i:=1 to n do for j:=1 to 4 do hashl[i][j]:=(hashl[i-1][j]*int64(999983) mod mo[j]+int64(a[n+1-i])-int64(1)) mod mo[j];
ans:=0;
for i:=1 to n do
    begin
    cnt:=0;
    for j:=1 to n div i do
        begin
        pd1:=1; pd2:=1;
        for k:=1 to 4 do
            begin
            tmp:=(hashr[j*i][k]-hashr[(j-1)*i][k]*pow[i][k] mod mo[k]) mod mo[k];
            if tmp<0 then tmp:=tmp+mo[k];
            if flag[tmp][k]<>i then begin pd1:=0; break; end;
            end; //pd1 all same
        if pd1=1 then continue;
        for k:=1 to 4 do
            begin
            t:=n-(j-1)*i;
            tmp:=(hashl[t][k]-hashl[t-i][k]*pow[i][k] mod mo[k]) mod mo[k];
            if tmp<0 then tmp:=tmp+mo[k];
            if flag[tmp][k]<>i then begin pd2:=0; break; end;
            end;
        if pd2=1 then continue;
        inc(cnt);
        for k:=1 to 4 do
            begin
            tmp:=(hashr[j*i][k]-hashr[(j-1)*i][k]*pow[i][k] mod mo[k]) mod mo[k];
            if tmp<0 then tmp:=tmp+mo[k];
            flag[tmp][k]:=i;
            end; //pd1 all same
        for k:=1 to 4 do
            begin
            t:=n-(j-1)*i;
            tmp:=(hashl[t][k]-hashl[t-i][k]*pow[i][k] mod mo[k]) mod mo[k];
            if tmp<0 then tmp:=tmp+mo[k];
            flag[tmp][k]:=i;
            end;
        end;
    if cnt>ans then begin ans:=cnt; num[0]:=1; num[1]:=i; end
       else if cnt=ans then begin inc(num[0]); num[num[0]]:=i; end;
    end;
writeln(ans,' ',num[0]);
for i:=1 to num[0]-1 do write(num[i],' ');
write(num[num[0]]);
writeln;
close(input);
close(output);
end.
