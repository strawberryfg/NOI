const maxn=1000000000;
var n,m,i,j:longint;
    f,pre,suc,p:array[0..1000001]of longint;
    h,w,v:array[0..1000001]of double;
    sum1,sum2:double;

function getf(i:longint):longint;
  begin
  if f[i]=i then exit(i);
  f[i]:=getf(f[i]);
  exit(f[i]);
  end;

procedure doit(pt:longint;v:double);
  var t,t1,t2:longint;
      tv:double;
  begin
  if v=0 then exit;
  if pt=0 then begin sum1:=sum1+v;exit; end;
  if pt=n+1 then begin sum2:=sum2+v;exit; end;
  t:=getf(pt);
  t1:=getf(pre[t]);
  t2:=getf(suc[t]);
  if (h[t1]>=h[t])and(h[t2]>=h[t]) then
       begin
       if h[t1]<h[t2] then
          begin
          if w[t]*(h[t1]-h[t])>v then
             begin
             h[t]:=h[t]+v/w[t];
             end
                else
             begin
             f[t]:=t1;
             suc[t1]:=suc[t];
             tv:=v-w[t]*(h[t1]-h[t]);
             w[t1]:=w[t1]+w[t];
             doit(t1,tv);
             end;
          exit;
          end;
       if h[t1]>h[t2] then
          begin
          if w[t]*(h[t2]-h[t])>v then
             begin
             h[t]:=h[t]+v/w[t];
             end
                else
             begin
             f[t2]:=t;
             suc[t]:=suc[t2];
             tv:=v-w[t]*(h[t2]-h[t]);
             w[t]:=w[t]+w[t2];
             h[t]:=h[t2];
             doit(t,tv);
             end;
          exit;
          end;
       if h[t1]=h[t2] then
          begin
          if w[t]*(h[t1]-h[t])>v then
             begin
             h[t]:=h[t]+v/w[t];
             end
                else
             begin
             f[t]:=t1;f[t2]:=t1;
             suc[t1]:=suc[t2];
             w[t1]:=w[t1]+w[t]+w[t2];
             doit(t1,v-w[t]*(h[t1]-h[t]));
             end;
          exit;
          end;
       end;
  if (h[t1]<=h[t])and(h[t]>=h[t2]) then
     begin
     doit(t1,v/2);doit(t2,v/2);
     exit;
     end;
  if (h[t1]<=h[t])and(h[t]<=h[t2]) then
     begin
     doit(t1,v);exit;
     end;
  if (h[t1]>=h[t])and(h[t]>=h[t2]) then
     begin
     doit(t2,v);exit;
     end;
  end;
begin
assign(input,'mwf.in');
reset(input);
assign(output,'mwf.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    readln(w[i],h[i]);
for i:=1 to m do
    readln(p[i],v[i]);
for i:=0 to n+1 do
    f[i]:=i;
h[0]:=-maxn;h[n+1]:=-maxn;
for i:=1 to n+1 do
    begin
    pre[i]:=i-1;
    suc[i-1]:=i;
    end;
sum1:=0;sum2:=0;
for i:=1 to m do
    begin
    doit(p[i],v[i]);
    end;
writeln(sum1:0:3);writeln(sum2:0:3);
close(input);close(output);
end.