const
 MaxN = 6010;
 MaxE = (40010 + 6010 * 2) * 2;
 inf = maxlongint div 2;

var
 vect, dist, q: array[0..MaxN] of longint;
 tag: array[0..MaxN] of boolean;
 edge: array[0..MaxE] of record next, dest, capa, back: longint; end;
 p, c, n, cnt, u, v, vT: longint;

procedure _add(a, b, c, d: longint);
 begin
  inc(cnt);
  with edge[cnt] do
   begin
    dest:= b;
    next:= vect[a];
    capa:= c;
    back:= cnt + d;
   end;
  vect[a]:= cnt;
 end;

procedure add(a, b, c: longint);
 begin
  _add(a, b, c, 1);
  _add(b, a, 0, -1);
 end;

function bfs: boolean;
 var
  i, head, tail: longint;
 begin
  for i:= 2 to vT do
   dist[i]:= inf;
  dist[1 + p]:= 1;
  q[1]:= p + 1;
  head:= 0;
  tail:= 1;
  while head < tail do
   begin
    inc(head);
    u:= q[head];
    i:= vect[u];
    while i <> 0 do
     with edge[i] do
      begin
       if (dist[dest] = inf) and (capa > 0) then
        begin
         dist[dest]:= dist[u] + 1;
         if dest = vT then
          exit(true);
         inc(tail);
         q[tail]:= dest;
        end;
       i:= next;
      end;
   end;
  exit(false);
 end;

function min(a, b: longint): longint;
 begin
  if a < b then exit(a) else exit(b);
 end;

function dfs(u, left: longint): longint;
 var
  i, delta, flow: longint;
 begin
  if u = vT then
   exit(left);
  i:= vect[u];
  flow:= 0;
  while (i <> 0) and (left > 0) do
   with edge[i] do
    begin
     if (capa > 0) and (dist[dest] = dist[u] + 1) then
      begin
       delta:= dfs(dest, min(left, capa));
       inc(flow, delta);
       dec(left, delta);
       dec(capa, delta);
       inc(edge[back].capa, delta);
      end;
     i:= next;
    end;
  if flow = 0 then
   dist[u]:= -1;
  exit(flow);
 end;

var
 i, ans: longint;

 begin
  assign(input, 'damage2.in'); reset(input);
  assign(output, 'damage2.out'); rewrite(output);
  read(p, c, n);
  vT:= p * 2 + 1;
  for i:= 1 to c do
   begin
   read(u, v);
    add(u + p, v, 1);
    add(v + p, u, 1);
   end;
  for i:= 1 to n do
   begin
    read(u);
    add(u, vT, inf);
   end;
  for i:= 2 to p do
   add(i, i + p, 1);
  while bfs do
   begin
    inc(ans, dfs(p + 1, inf));
    ans:= ans;
   end;
  writeln(ans);
  close(input);
  close(output);
 end.f
