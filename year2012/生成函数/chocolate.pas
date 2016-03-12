const maxn=11111; eps=1e-18;
type rec=record bef:extended; aft:longint; end;
var test,c,n,m,cnt1,cnt2,tot,i,j:longint;
    ret,tmp,opt,ans:extended;
    f:array[0..111,0..111]of extended;
    h:array[0..2*maxn]of longint;
    a,b:array[0..2*maxn]of rec;
    bel,flag:array[-maxn..maxn]of longint;
    res:array[0..2*maxn]of extended;
    now:longint;
    save:extended;
function com(x,y:longint):extended;
begin
if abs(f[x][y])>eps then exit(f[x][y]);
if y=0 then exit(1.0);
if x=y then exit(1.0);
if x<y then exit(0.0);
f[x][y]:=com(x-1,y)+com(x-1,y-1);
exit(f[x][y]);
end;
function cmp(x:extended):boolean;
begin
if (x>eps) then exit(true) else exit(false);
end;
begin
{assign(input,'chocolate.in');
reset(input);
assign(output,'e:\chocolate.out');
rewrite(output);}
read(c);
test:=0;
while c<>0 do
  begin
  inc(test);
  read(n,m);
  if (m>n)or(m>c)or((n-m) mod 2<>0) then writeln('0.000')
     else begin
          cnt1:=0; cnt2:=0;
          for i:=0 to m do
              begin
              if i mod 2=0 then opt:=1 else opt:=-1;
              inc(cnt1);
              a[cnt1].bef:=opt*com(m,i); a[cnt1].aft:=m-2*i;
              end;
          for i:=0 to c-m do
              begin
              inc(cnt2);
              b[cnt2].bef:=com(c-m,i); b[cnt2].aft:=c-m-2*i;
              end;
          tot:=0;
          for i:=1 to cnt1 do
              for j:=1 to cnt2 do
                  begin
                  now:=a[i].aft+b[j].aft;
                  if flag[now]<>test then
                     begin
                     flag[now]:=test;
                     inc(tot);
                     h[tot]:=now;
                     bel[now]:=tot;
                     res[tot]:=0.0;
                     end;
                  res[bel[now]]:=res[bel[now]]+a[i].bef*b[j].bef;
                  end;
          ret:=0;
          for i:=1 to tot do
              begin
              if abs(h[i])<eps then continue;
              tmp:=1;
              save:=h[i];
              if not cmp(h[i]) then begin save:=-h[i]; if n mod 2=0 then tmp:=1 else tmp:=-1; end;
//              if n>=2000 then if abs(save-c)>eps then continue;
              save:=save/c;
              ret:=ret+res[i]*tmp*exp(ln(save)*n);
              end;
          for i:=1 to c do ret:=ret/2;
          ret:=ret*com(c,m);
          if abs(ret)<eps then writeln('0.000')
             else writeln(ret:0:3);
          end;
  read(c);
  end;
{close(input);
close(output);}
end.