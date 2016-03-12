const    maxn=1000;
    oo=maxlongint;
var    a,b,c,n,m,h,t,i,min,ans:longint;
    g:array[1..maxn,1..maxn]of longint;
    q,p,prev:array[1..maxn]of longint;
    flag:boolean;
begin
assign(input,'ek.in'); reset(input);
assign(output,'ek.out'); rewrite(output);
while not eof do
    begin
    readln(m,n);
    fillchar(g,sizeof(g),0);
    for i:=1 to m do
        begin
        readln(a,b,c);
        g[a,b]:=g[a,b]+c;
        end;
    ans:=0;
    while true do
        begin
        h:=1; t:=1;
        fillchar(p,sizeof(p),0);
        q[1]:=1; p[1]:=1;
        flag:=false;
        while h<=t do
            begin
            for i:=1 to n do
                if (p[i]=0)and(g[q[h],i]>0)
                    then begin
                    inc(t); q[t]:=i;
                    p[i]:=1; prev[t]:=h;
                    if q[t]=n
                        then begin
                        flag:=true;
                        break;
                        end;
                    end;
            if flag then break;
            inc(h);
            end;
        if not flag
            then break;
        i:=t; min:=oo;
        while q[i]<>1 do
            begin
            if g[q[prev[i]],q[i]]<min
                then min:=g[q[prev[i]],q[i]];
            i:=prev[i];
            end;
        i:=t;
        while q[i]<>1 do
            begin
            g[q[prev[i]],q[i]]:=g[q[prev[i]],q[i]]-min;
            g[q[i],q[prev[i]]]:=g[q[i],q[prev[i]]]+min;
            i:=prev[i];
            end;
        ans:=ans+min;
        end;
    writeln(ans);
    end;
close(input); close(output);
end.
