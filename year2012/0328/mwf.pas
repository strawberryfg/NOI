program mt;
const
  inf = 'mwf.in';
  ouf = 'mwf.out';
var
  w, v, h: array[1 .. 1000000] of extended;
  n, m, i, j: longint;
  x, y, high: extended;

BEGIN
  assign(input, inf); reset(input);
  assign(output, ouf); rewrite(output);

  readln(n, m);
  for i := 1 to n do readln(w[i], h[i]);
  for i := 1 to m do begin
    readln(j, y);
    v[j] := v[j] + y;
    end;

  x := 0; y := 0; high := 0;
  for i := 1 to n do begin
    if h[i] > high then begin
      high := h[i];
      if y + v[i] / 2 > 0 then begin
        x := x + y + v[i] / 2;
        y := -v[i] / 2;
        end;
      end;
    y := y + v[i] + w[i] * (h[i] - high);
    end;
  writeln(x : 0 : 3);

  x := 0; y := 0; high := 0;
  for i := n downto 1 do begin
    if h[i] > high then begin
      high := h[i];
      if y + v[i] / 2 > 0 then begin
        x := x + y + v[i] / 2;
        y := -v[i] / 2;
        end;
      end;
    y := y + v[i] + w[i] * (h[i] - high);
    end;
  writeln(x : 0 : 3);

  close(input); close(output);
END.




