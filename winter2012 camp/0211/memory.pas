const maxn=200000; eps=1e-10;
var n,i,p,q:longint;
    a,b,c,d,hash:array[0..maxn]of longint;
    k,bb:array[0..maxn]of extended;
    flag:boolean;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure work1(x,opt:longint);
var
    i,min1,min2,max1,max2:longint;
    x1,x2,x3,x4,y1,y2,y3,y4:extended;
begin
for i:=1 to n do
    begin
    if (hash[i]=1)and(i<>x) then
       begin
       min1:=min(b[i],d[i]); min2:=min(b[x],d[x]);
       max1:=max(b[i],d[i]); max2:=max(b[x],d[x]);
       if (k[i]=k[x]) then
          begin
          if not((min1>=max2)or(min2>=max1)) then begin flag:=false; exit; end;
          end
       else
          begin
          if (max1<=min2)or(max2<=min1) then continue;
          x2:=(d[i]-bb[x])/k[x];
          if (min(a[x],c[x])<=x2)and(x2<=max(a[x],c[x])) then
             begin
             if opt=0 then
                begin
                if x2>c[i] then begin flag:=false; exit; end;
                end
             else
                begin
                if x2<c[i] then begin flag:=false; exit; end;
                end;
             end;
          x1:=(b[i]-bb[x])/k[x];
          if (min(a[x],c[x])<=x1)and(x1<=max(a[x],c[x])) then
             begin
             if opt=0 then
                begin
                if x1>a[i] then begin flag:=false; exit; end;
                end
             else
                begin
                if x1<a[i] then begin flag:=false; exit; end;
                end;
             end;
          x3:=(b[x]-bb[i])/k[i];
          if (min(a[i],c[i])<=x3)and(x3<=max(a[i],c[i])) then
             begin
             if opt=0 then
                begin
                if x3<a[x] then begin flag:=false; exit; end;
                end
             else
                begin
                if x3>a[x] then begin flag:=false; exit; end;
                end;
             end;
          x4:=(d[x]-bb[i])/k[i];
          if (min(a[i],c[i])<=x4)and(x4<=max(a[i],c[i])) then
             begin
             if opt=0 then
                begin
                if x4<c[x] then begin flag:=false; exit; end;
                end
             else
                begin
                if x4>c[x] then begin flag:=false; exit; end;
                end;
             end;
          end;
       end;
    end;
end;
procedure work2(x,opt:longint);
var
    i,min1,min2,max1,max2:longint;
    x1,x2,x3,x4,y1,y2,y3,y4:extended;
begin
for i:=1 to n do
    begin
    if (i<>x)and(hash[i]=0) then
       begin
       min1:=min(a[i],c[i]); min2:=min(a[x],c[x]);
       max1:=max(a[i],c[i]); max2:=max(a[x],c[x]);
       if (k[i]=k[x]) then
          begin
          if not((min1>=max2)or(min2>=max1)) then begin flag:=false; exit; end;
          end
       else
          begin
          if (max1<=min2)or(max2<=min1) then continue;
          y2:=k[i]*c[x]+bb[i];
          if (min(b[i],d[i])<=y2)and(y2<=max(b[i],d[i])) then
             begin
             if opt=1 then
                begin
                if y2>d[x] then begin flag:=false; exit; end;
                end
             else
                begin
                if y2<d[x] then begin flag:=false; exit; end;
                end;
             end;
          y1:=k[i]*a[x]+bb[i];
          if (min(b[i],d[i])<=y1)and(y1<=max(b[i],d[i])) then
             begin
             if opt=1 then
                begin
                if y1>b[x] then begin flag:=false; exit; end;
                end
             else
                begin
                if y1<b[x] then begin flag:=false; exit; end;
                end;
             end;
          y3:=k[x]*a[i]+bb[x];
          if (min(b[x],d[x])<=y3)and(y3<=max(b[x],d[x])) then
             begin
             if opt=1 then
                begin
                if y3<b[i] then begin flag:=false; exit; end;
                end
             else
                begin
                if y3>b[i] then begin flag:=false; exit; end;
                end;
             end;
          y4:=k[x]*c[i]+bb[x];
          if (min(b[x],d[x])<=y4)and(y4<=max(b[x],d[x])) then
             begin
             if opt=1 then
                begin
                if y4<d[i] then begin flag:=false; exit; end;
                end
             else
                begin
                if y4>d[i] then begin flag:=false; exit; end;
                end;
             end;
          end;
       end;
    end;
end;
begin
assign(input,'memory.in');
reset(input);
assign(output,'memory.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(a[i],b[i],c[i],d[i]);
    k[i]:=(d[i]-b[i])/(c[i]-a[i]);
    bb[i]:=b[i]-k[i]*a[i]; //kx1+b1=y1;
    hash[i]:=1;
    end;
for i:=1 to n do
    begin
    readln(p,q);
    flag:=true;
    if (q=0)or(q=2) then
       work1(p,q)
    else
       work2(p,q);
    if not flag then begin writeln(i); break; end
       else hash[p]:=0;  //remove;
    end;
for i:=1 to n do
    begin
    writeln(i,' ',3);
    end;
close(input);
close(output);
end.
