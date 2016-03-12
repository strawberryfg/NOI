const maxm=50011;
      maxl=55;
      maxn=13;
var ll,rr,w,v:array[0..maxm*maxl] of longint;
    f:array[0..maxm*maxl,0..maxn] of longint;
    now,m,k,l,n,tot,i:longint;
    ch:char;

procedure insert(x:longint);
begin
 if ll[now]=0 then begin inc(tot);ll[now]:=tot;now:=tot;w[now]:=x;exit;end
              else now:=ll[now];
 while (rr[now]<>0) and (w[now]<>x) do now:=rr[now];
 if w[now]<>x then begin inc(tot);rr[now]:=tot;now:=tot;w[now]:=x;end;
end;

function solve(x,y:longint):longint;
 var k,max,tmp:longint;
begin
 if f[x,y]<>-1 then exit(f[x,y]);
 if y=0 then exit(0);
 if rr[x]=0 then
   begin
    if ll[x]=0 then exit(v[x]);
    f[x,y]:=solve(ll[x],y)+v[x];
   end
else if ll[x]=0 then
        begin
          max:=solve(rr[x],y);
          tmp:=solve(rr[x],y-1)+v[x];
          if tmp>max then max:=tmp;
          f[x,y]:=max;
        end
else
  begin
    max:=solve(rr[x],y);
    for k:=1 to y do
      begin
        tmp:=solve(ll[x],k)+solve(rr[x],y-k);
        if tmp+v[x]>max then max:=tmp+v[x];
      end;
    f[x,y]:=max;
  end;
 exit(f[x,y]);
end;

begin
assign(input,'gold.in');reset(input);
assign(output,'gold.out');rewrite(output);
 readln(m,k,l,n);
 for i:=1 to m do
   begin
     now:=0;
     while not eoln do
       begin
         read(ch);
         insert(ord(ch)-ord('A')+1);
       end;
     readln;
     inc(v[now]);
   end;
 fillchar(f,sizeof(f),-1);
 writeln(solve(0,n));
close(input);close(output);
end.
