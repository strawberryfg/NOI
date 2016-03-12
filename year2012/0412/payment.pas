const big=10000000000000000;

var max:int64;
    scc:array[0..20] of string;
    gcc:array[0..20] of longint;
    u,s,st:string;
    n,v:longint;
    a:array[0..300] of longint;

function pow2(a,b:longint):int64;
  var i:longint;
      e:int64;
  begin
    e:=1;
    for i:=1 to b do e:=e*int64(a);
    exit(e);
  end;

procedure search(n:longint);
  var i,c,q:longint;
  begin
    for i:=2 to n do
      begin
        q:=i;
        c:=1;
        while q*i<=n do
          begin
            q:=q*i;
            inc(c);
          end;
        if pow2(i,gcc[c])>max then
          begin
            max:=pow2(i,gcc[c]);
            str(i,st);
            st:=st+scc[c];
          end;
      end;
  end;

function small(a,b:string):boolean;
  begin
    if (length(a)<length(b)) or
       ((length(a)=length(b)) and (a<=b)) then
         exit(true)
       else
         exit(false);
  end;

function c2(s:string):string;
  var ls,i,c,g:longint;
      ss:string;
  begin
    ls:=length(s);
    fillchar(a,sizeof(a),0);
    for i:=1 to ls do
      a[i]:=ord(s[ls+1-i])-48;
    g:=0;
    for i:=1 to ls+1 do
      begin
        c:=a[i]*2+g;
        g:=c div 10;
        a[i]:=c mod 10;
      end;
    inc(ls);
    while a[ls]=0 do dec(ls);
    ss:='';
    for i:=ls downto 1 do
      ss:=ss+chr(a[i]+48);
    exit(ss);
  end;

begin
  scc[1]:='';gcc[1]:=1;
  scc[2]:='^2';gcc[2]:=2;
  scc[3]:='^3';gcc[3]:=3;
  scc[4]:='^2^2';gcc[4]:=4;
  scc[5]:='^5';gcc[5]:=5;
  scc[6]:='^3^2';gcc[6]:=9;
  scc[7]:='^3^2';gcc[7]:=9;
  scc[8]:='^2^2^2';gcc[8]:=16;
  scc[9]:='^3^3';gcc[9]:=27;
  scc[10]:='^2^5';gcc[10]:=32;

  assign(input,'PAYMENT.in');
  assign(output,'PAYMENT.out');
  reset(input);
  rewrite(output);

  while not eof do
    begin
      readln(s);
      if length(s)<=4 then
        begin
          val(s,n);
          if n<=1 then
            begin
              max:=0;
              st:='';
              search(n);
              writeln(st);
              continue;
            end;
        end;
      u:='1';
      v:=0;
      while small(u,s) do
        begin
          inc(v);
          u:=c2(u);
        end;
      dec(v);
      write('2');
      while v>10 do
        begin
          write('^2');
          v:=v div 2;
        end;
      writeln(scc[v]);
    end;

  close(input);
  close(output);
end.
