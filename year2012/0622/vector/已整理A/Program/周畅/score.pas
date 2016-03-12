const
  let:array[1..4] of char=('y','r','b','g');
var
  n,i,j,l,k,t,x,m,max,temp:longint;
  a,c:array[1..400] of longint;
  h:array[0..400] of string;
  st:string;
  g:array[1..4] of longint;
begin
  assign(input,'score.in'); reset(input);
  assign(output,'score.out'); rewrite(output);
  readln(n);
  fillchar(c,sizeof(c),0);
  for i:=0 to 100 do h[i]:='';
  i:=0; j:=1;
  readln(st);
  while j<=length(st) do
    begin
      while st[j]=' ' do inc(j);
      temp:=0;
      while ord(st[j])<58 do begin temp:=temp*10+ord(st[j])-48; inc(j); end;
      inc(i);
      a[i]:=temp;
      h[a[i]]:=h[a[i]]+st[j];
      inc(j);
    end;
  k:=0;
  for i:=1 to 100 do
    if h[i]<>'' then
      if length(h[i])>=3 then
      begin
        k:=k+length(h[i])*i;
        c[i]:=1;
      end;
  i:=1;
  while h[i]='' do inc(i);
  while c[i]=1 do inc(i);
  while i<=100 do
    begin
      for j:=1 to length(h[i]) do begin
        if h[i][j]='y' then g[1]:=1;
        if h[i][j]='r' then g[2]:=1;
        if h[i][j]='b' then g[3]:=1;
        if h[i][j]='g' then g[4]:=1; end;
      max:=0;
      for j:=1 to 4 do
       if g[j]=1 then
        begin
          t:=1;
          x:=i-1;
          m:=0;
          while t<>0 do
            begin
              inc(x);
              t:=0;
              for l:=1 to length(h[x]) do
                if (h[x][l]=let[j])and(c[x]=0) then begin t:=1; inc(m); break; end;
            end;
          if m>max then max:=m;
        end;
      if max>=3 then
        for j:=i to i+max-1 do if c[j]=0 then begin k:=k+j; c[j]:=1; end;
      fillchar(g,sizeof(g),0);
      inc(i);
      while h[i]='' do inc(i);
      while c[i]=1 do inc(i);
    end;
  writeln(k);
  close(input); close(output);
end.
