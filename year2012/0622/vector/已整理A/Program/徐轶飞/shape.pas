var big,sma:array[0..5000,0..5000]of longint;
    a:array[0..5000]of longint;
    ans:array[1..6]of int64;
    tot:int64;
    i,j,n:longint;
begin
assign(input,'shape.in');
assign(output,'shape.out');
reset(input);rewrite(output);
readln(n);
for i:=1 to n do
    begin
    read(a[i]);
    end;
for i:=1 to n do
    for j:=i+1 to n do
        begin
        if a[j]>a[i] then big[i,j]:=big[i,j-1]+1
           else big[i,j]:=big[i,j-1];
        if a[j]<a[i] then sma[i,j]:=sma[i,j-1]+1
           else sma[i,j]:=sma[i,j-1];
        end;
fillchar(ans,sizeof(ans),0);
for i:=1 to n do
    for j:=i+1 to n do
    begin
    if a[i]=a[j] then continue;
    if a[i]<a[j] then begin
       ans[1]:=ans[1]+big[j,n];
       ans[4]:=ans[4]+sma[i,n]-sma[i,j];
       ans[2]:=ans[2]+big[i,n]-big[i,j]-big[j,n];
       end
       else begin
       ans[3]:=ans[3]+big[i,n]-big[i,j];
       ans[5]:=ans[5]+sma[i,n]-sma[i,j]-sma[j,n];
       ans[6]:=ans[6]+sma[j,n];
       end;
    end;
tot:=0;
for i:=1 to 6 do
    begin
    tot:=tot+ans[i];
    end;
for i:=1 to 6 do
    begin
    write('0.');
    for j:=1 to 20 do
        begin
        ans[i]:=ans[i]*10;
        write(ans[i] div tot);
        ans[i]:=ans[i] mod tot;
        end;
    writeln;
    end;
end.
