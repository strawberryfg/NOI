program rings;
{$I-,S-,Q-,R-}

const
  inf = 'rings.in';
  ouf = 'rings.out';
  none = 100000000;
  maxn = 100000;
  m = 26 * 26;
  error = 1e-7;

type integer = longint;

var g: array[1 .. m, 1 .. m] of integer;
    x, y: array[1 .. m * m] of integer;
    buf: array[0 .. 1 shl 20] of char;
    head, tail, long: array[1 .. maxn] of integer;
    n, low, top, len: integer;

function calc(s: string): integer;
begin
  calc := (ord(s[1]) - ord('a')) * 26 + ord(s[2]) - ord('a') + 1;
end;

var st: array[1 .. 1000] of char;

procedure prepare;
var i, j, u, v: integer;
begin
  low := none; top := 0;
  for i := 1 to n do begin
    j := 0;
    while not seekeoln do begin
      j := j + 1;
      read(st[j]);
    end; readln;
    u := calc(st[1] + st[2]);
    v := calc(st[j - 1] + st[j]);
    j := j * 100;
    if j < low then low := j;
    if j > top then top := j;
    head[i] := u; tail[i] := v; long[i] := j;
  end;
  inc(top);
end;

var dis: array[1 .. m] of integer;

function check(mid: integer): boolean;
var i, j: integer;
begin
  for i := 1 to m do dis[i] := none;
  dis[1] := 0;
  for i := 1 to m - 1 do begin
    for j := 1 to n do
      if dis[head[j]] + long[j] - mid < dis[tail[j]] then dis[tail[j]] := dis[head[j]] + long[j] - mid;
    if dis[1] < 0 then exit(true);
  end;
  for j := 1 to n do
    if dis[head[j]] + long[j] - mid < dis[tail[j]] then exit(true);
  check := false;
end;

procedure main;
var mid: integer;
    boo: boolean;
begin
  while low <= top do begin
    mid := (low + top) shr 1;
    boo := check(mid);
    if low = top then begin
      if boo then writeln((low - 1) / 100:0:2) else writeln('No solution.');
      exit;
    end;
    if boo then top := mid else low := mid + 1;
  end;
end;

begin
  assign(input, inf); assign(output, ouf);
  settextbuf(input, buf);
  reset(input); rewrite(output);
  readln(n);
  while n > 0 do begin
    prepare;
    main;
    readln(n);
  end;
  close(input); close(output);
end.
