program jozo;

const
  maxn=1000;
  maxtime=50000;
  maxt=601;

type
  link=^node;
  node=record
    x,y:longint;
    next:link;
  end;

var
  a:array [1..maxn,1..maxn] of longint;
  e:array [1..maxtime] of link;
  c:array [1..maxt,1..maxn] of longint;
  n,p,v,t1,t2,t,m,x,y,i,j,i1,j1,ans:longint;
  r:link;

  procedure insert(t,x,y:longint);
  var
    d:link;
  begin
    new(d); d^.x:=x; d^.y:=y;
    d^.next:=e[t]; e[t]:=d;
  end;

begin
  assign(input,'jozo.in');
  assign(output,'jozo.out');
  reset(input);
  read(n,p,v,t1,t2);
  fillchar(a,sizeof(a),0);
  for i:=1 to p do
  begin
    read(x,y,a[x,y]);
    a[y,x]:=a[x,y];
  end;
  fillchar(e,sizeof(e),0);
  for i:=1 to v do
  begin
    read(t,m,x);
    for j:=2 to m do
    begin
      read(y);
      if t<=t2 then insert(t,x,y);
      inc(t,a[x,y]); x:=y;
    end;
  end;
  close(input);

  ans:=maxlongint;
  for i:=1 to maxt do
    for j:=1 to n do
      c[i,j]:=maxlongint;
  c[1,1]:=0;
  i:=1;
  for t:=1 to t2 do
  begin
    if (t>=t1) and (c[i,1]<ans) then ans:=c[i,1];
    for j:=1 to n do
      if c[i,j]<maxlongint then
      begin
        i1:=i+1; if i1>maxt then dec(i1,maxt);
        if c[i,j]+1<c[i1,j] then c[i1,j]:=c[i,j]+1;
      end;
    r:=e[t];
    while r<>nil do
    begin
      j:=r^.x; j1:=r^.y;
      if c[i,j]<maxlongint then
      begin
        i1:=i+a[j,j1]; if i1>maxt then dec(i1,maxt);
        if c[i,j]<c[i1,j1] then c[i1,j1]:=c[i,j];
      end;
      r:=r^.next;
    end;
    for j:=1 to n do c[i,j]:=maxlongint;
    inc(i); if i>maxt then i:=1;
  end;

  rewrite(output);
  writeln(ans);
  close(output);
end.

