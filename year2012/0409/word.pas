const maxn=220; inf=maxlongint;
var n,m,i,j,k,l,u,p,ans,tmp:longint;
    s:array[0..maxn]of string;
    a:array[0..maxn]of string;
    final,next:array[0..maxn]of longint;
    target:string;
    hash:array[0..maxn,0..maxn]of longint;
    flag:boolean;
procedure kmp(x,y:longint);
var s1,s2:string;
    tn,tm,i,j:longint;
begin    //P :s1; T:s2;
s1:=a[x]; s2:=s[y];
tn:=length(s1); tm:=length(s2);
fillchar(next,sizeof(next),0);
next[1]:=0;
j:=0;
for i:=2 to tn do
    begin
    while (j>0)and(s1[j+1]<>s1[i]) do j:=next[j];
    if s1[j+1]=s1[i] then inc(j);
    next[i]:=j;
    end;
j:=0;
for i:=1 to tm do
    begin
    while (j>0)and(s1[j+1]<>s2[i]) do j:=next[j];
    if s1[j+1]=s2[i] then inc(j);
    if j=tn then
       begin
       hash[x][i-tn+1]:=y;
       j:=next[j];
       end;
    end;
end;
begin
assign(input,'word.in');
reset(input);
assign(output,'word.out');
rewrite(output);
readln(n,m);
for i:=1 to n do readln(s[i]);
readln(target);
ans:=inf;
for i:=1 to length(target) do
    begin
    for j:=1 to i do a[j]:='';
    for j:=1 to length(target) div i do
        begin
        for k:=1 to i do
            begin
            a[k]:=a[k]+target[(j-1)*i+k];
            end;
        end;
    if length(target) mod i<>0 then
       for k:=1 to length(target) mod i do
           a[k]:=a[k]+target[length(target) div i*i+k];
    fillchar(hash,sizeof(hash),0);
    for j:=1 to i do
        begin
        for k:=1 to n do
            begin
            kmp(j,k);
            end;
        end;
    for j:=1 to m do
        begin
        p:=0;
        flag:=true;
        for k:=1 to i do
            begin
            if hash[k][j+p]=0 then
               begin
               if p=1 then begin flag:=false; break; end;
               p:=1;
               tmp:=k;
               if hash[k][j+p]=0 then begin flag:=false; break; end;
               end;
            final[k]:=hash[k][j+p];
            end;
        if flag then
           begin
           ans:=i;
           writeln(i);
           if p=0 then
              begin
              for k:=1 to i do
                  begin
                  write(final[k]);
                  if k<i then write(' ');
                  end;
              end
           else
              begin
              for k:=tmp to i do
                  write(final[k],' ');
              for k:=1 to tmp-1 do
                  begin
                  write(final[k]);
                  if k<tmp-1 then write(' ');
                  end;
              end;
           writeln;
           break;
           end;
        end;
    if flag then break;
    end;
if ans=inf then writeln(-1);
close(input);
close(output);
end.