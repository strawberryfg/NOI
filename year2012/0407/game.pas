var l1,l2,i,j,k:longint;
    f:array[0..2100,0..2100] of int64;
    a,b:array[0..3000] of int64;
function min(a,b:int64):int64;
  begin if a<b then min:=a else min:=b;  end;
begin
  assign(input,'game.in');
  assign(output,'game.out');
  reset(input);
  rewrite(output);
  readln(l1,l2);
  for i:=1 to l1 do begin read(a[i]); dec(a[i]); end;
  for i:=1 to l2 do begin read(b[i]); dec(b[i]); end;

  for i:=0 to l1+1 do for j:=0 to l2+1 do
    f[i,j]:=1000000000;  f[l1+1,l2+1]:=0;
  for i:=l1 downto 0 do
    for j:=l2 downto 0 do
      begin
        if i<l1 then f[i,j]:=min(f[i,j],f[i+1,j]+a[i]*b[j]);
        if j<l2 then f[i,j]:=min(f[i,j],f[i,j+1]+a[i]*b[j]);
        f[i,j]:=min(f[i,j],f[i+1,j+1]+a[i]*b[j]);
      end;
  writeln(f[1,1]);
  close(input);
  close(output);
end.
