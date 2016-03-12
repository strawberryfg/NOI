uses math;
const inf=2000000000;
      maxn=5055;
var f,h:array[1..maxn] of longint;
    k,n,i,j,st:longint;
    tmp,now:extended;
begin
assign(input,'skilift.in');reset(input);
assign(output,'skilift.out');rewrite(output);
 readln(n,k);
 for i:=1 to n do readln(h[i]);
 f[1]:=1;
 for i:=2 to n do
   begin
     st:=max(1,i-k);
     now:=inf;
     f[i]:=inf;
     for j:=i-1 downto st do
       begin
        tmp:=(h[i]-h[j])/(i-j);
        if tmp>now then continue;
        now:=tmp;
        if f[j]+1<f[i] then f[i]:=f[j]+1;
       end;
   end;
 writeln(f[n]);
close(input);close(output);
end.
