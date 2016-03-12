const big=1000000;

var f,g,ok:array[0..151,0..151] of longint;
    cost:array['a'..'z'] of longint;
    st:array[0..151] of string;
    w:array[0..151] of longint;
    s:string;
    m,n,i,k,j,num:longint;
    ch:char;

procedure search(l,r:longint);
  var i,lsc,x,y,z:longint;
      sc:string;
  begin
    if g[l,r]<>-1 then exit;
    g[l,r]:=0;
    if l>r then
      begin
        f[l,r]:=1;
        exit;
      end;
    for i:=1 to k do
      if (r-l+1=length(st[i])) and
         (copy(s,l,(r-l+1))=st[i]) then
           begin
             f[l,r]:=1;
             g[l,r]:=w[i];
             exit;
           end;
    for i:=l to r-1 do
      begin
        search(l,i);
        search(i+1,r);
        if (f[l,i]=1) and (f[i+1,r]=1) then
          f[l,r]:=1;
        if g[l,i]+g[i+1,r]>g[l,r] then
          g[l,r]:=g[l,i]+g[i+1,r];
      end;
    for i:=1 to k do
      begin
        sc:=st[i];
        lsc:=length(sc);
        if lsc>=(r-l+1) then continue;
        if (sc[1]=s[l]) and (sc[lsc]=s[r]) then
          begin
            ok[l,1]:=1;
            for x:=l+1 to r do ok[x,1]:=0;
            for x:=l+1 to r do
              for y:=2 to lsc do
                begin
                  ok[x,y]:=0;
                  if sc[y]=s[x] then
                    for z:=l to x-1 do
                      if ok[z,y-1]=1 then
                        begin
                          search(z+1,x-1);
                          if f[z+1,x-1]=1 then
                            begin
                              ok[x,y]:=1;
                              break;
                            end;
                        end;
                end;
            if ok[r,lsc]=1 then
              begin
                f[l,r]:=1;
                g[l,r]:=0;
                for x:=l to r do
                  g[l,r]:=g[l,r]+cost[s[x]];
                break;
              end;
          end;
      end;
  end;

begin

  assign(input,'casino.in');
  assign(output,'casino.out');
  reset(input);
  rewrite(output);

  readln(m);
  fillchar(cost,sizeof(cost),0);
  for i:=1 to m do
    begin
      readln(ch,num);
      cost[ch]:=num;
    end;
  readln(s);
  n:=length(s);
  readln(k);
  for i:=1 to k do
    begin
      readln(st[i]);
      w[i]:=0;
      for j:=1 to length(st[i]) do
        w[i]:=w[i]+cost[st[i][j]];
    end;
  for i:=0 to n do
    for j:=0 to n do
      begin
        f[i,j]:=-1;
        g[i,j]:=-1;
      end;
  search(1,n);
  writeln(g[1,n]);

  close(input);
  close(output);
end.
