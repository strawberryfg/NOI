const maxn=15; maxnum=100020; base=1000000001;
var n,i,j,u,max,aa,bb,p,k,flag,found:longint;
    len:array[0..maxn]of longint;
    a:array[0..maxn,0..maxn]of longint;
    f,tf:array[0..3050]of qword;
    hash:array[0..maxnum]of longint;
    ans,res:qword;
begin
assign(input,'set.in');
reset(input);
assign(output,'set.out');
rewrite(output);
readln(n);
ans:=1;
for i:=1 to n do
    begin
    if hash[i]=1 then continue;
    fillchar(a,sizeof(a),0);
    a[1][1]:=i; len[1]:=1;
    hash[i]:=1;
    max:=1;
    for j:=1 to 12 do
        begin
        if a[j][1]*2>n then break;
        len[j+1]:=0;
        inc(len[j+1]);
        found:=0;
        if hash[a[j][1]*2]=0 then
           begin
           found:=1;
           hash[a[j][1]*2]:=1;
           a[j+1][1]:=a[j][1]*2;
           end;
        for k:=1 to len[j] do
            begin
            if a[j][k]*3>n then break;
            inc(len[j+1]);
            if hash[a[j][k]*3]=0 then
               begin
               found:=1;
               hash[a[j][k]*3]:=1;
               a[j+1][len[j+1]]:=a[j][k]*3;
               end;
            end;
        if found=0 then break;
        max:=j+1;
        end;
    f[0]:=1; f[1]:=1; // take it or not
    for u:=2 to max do
        begin
        tf:=f;
        fillchar(f,sizeof(f),0);
        for j:=0 to 1 shl len[u-1]-1 do
            for k:=0 to 1 shl len[u]-1 do
                begin
                flag:=1;
                for p:=1 to len[u] do
                    begin
                    if (p<=len[u-1])and(a[u-1][p]<>0)and(a[u][p]<>0) then
                       begin
                       aa:=j and (1 shl (p-1));
                       bb:=k and (1 shl (p-1));
                       if (aa<>0)and(bb<>0) then begin flag:=0; break; end;
                       end;
                    if (p>=2)and(a[u-1][p-1]<>0)and(a[u][p]<>0) then
                       begin
                       aa:=j and (1 shl (p-2));
                       bb:=k and (1 shl (p-1));
                       if (aa<>0)and(bb<>0) then begin flag:=0; break; end;
                       end;
                    end;
                if flag=1 then f[k]:=(f[k]+tf[j])mod base;
                end;
        end;
    res:=0;
    for u:=0 to 1 shl len[max]-1 do res:=(res+f[u])mod base;
    ans:=ans*res mod base;
    end;
writeln(ans);
close(input);
close(output);
end.
