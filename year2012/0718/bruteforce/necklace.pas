const maxn=2111;
var n,opt,i,num,x,y,j,tmp,k,p,col,ans:longint;
    a,b:array[0..maxn]of longint;
    ch1,ch2,v:char;
begin
assign(input,'necklace.in');
reset(input);
assign(output,'necklace.out');
rewrite(output);
readln(n,col);
for i:=1 to n do begin read(a[i]); a[i+n]:=a[i]; end;
read(opt); readln;
for i:=1 to opt do
    begin
    read(ch1);
    if ch1='R' then
       begin
       read(ch2);
       read(num);
       b:=a;
       for j:=1 to n do
           begin
           tmp:=(j+num) mod n; if tmp=0 then tmp:=n;
           a[tmp]:=b[j];
           a[tmp+n]:=b[j];
           end;
       readln;
       end
    else if ch1='F' then
            begin
            for j:=2 to (n+2) div 2 do
                begin
                tmp:=a[j]; a[j]:=a[n+2-j]; a[n+2-j]:=tmp;
                a[j+n]:=a[j]; a[n+2-j+n]:=a[n+2-j];
                end;
            readln;
            end
         else if ch1='S' then
                 begin
                 read(ch2); read(x,y);
                 tmp:=a[x]; a[x]:=a[y]; a[y]:=tmp;
                 a[x+n]:=a[x]; a[y+n]:=a[y];
                 readln;
                 end
              else if ch1='P' then
                      begin
                      read(x,y,num);
                      if y<x then y:=y+n;
                      for j:=x to y do begin a[j]:=num; if j>n then a[j-n]:=num; if j+n<=2*n then a[j+n]:=num; end;
                      readln;
                      end
                   else if ch1='C' then
                           begin
                           read(ch2);
                           if ch2='S' then
                              begin
                              read(v); read(x,y);
                              if y<x then y:=y+n;
                              j:=x; ans:=0;
                              while j<=y do
                                begin
                                k:=j;
                                while (k+1<=y)and(a[k+1]=a[j]) do inc(k);
                                inc(ans);
                                j:=k+1;
                                end;
                              writeln(ans);
                              readln;
                              end
                           else
                              begin
                              j:=n+1;
                              while (j-1>1)and(a[j-1]=a[n+1]) do dec(j);
                              ans:=1;
                              k:=1;
                              while (k<j)and(a[k]=a[1]) do inc(k);
                              while (k<j) do
                                begin
                                p:=k;
                                while (p+1<j)and(a[p+1]=a[k]) do inc(p);
                                inc(ans);
                                k:=p+1;
                                end;
                              writeln(ans);
                              readln;
                              end;
                           end;
    end;
close(input);
close(output);
end.
