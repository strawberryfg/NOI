const maxn=280020; maxq=500020; maxlen=1000020;
type treetype=record next:array[1..26]of longint; fall,flag:longint; end;
var test,u,i,n,x,tx,head,tail,root,tot,p,ans,cnt:longint;
    s:string;
    tree:array[0..maxn]of treetype;
    q:array[0..maxq]of longint;
    s1:array[0..maxlen]of char;
procedure clear(x:longint);
var i:longint;
begin
for i:=1 to 26 do tree[x].next[i]:=0;
tree[x].fall:=0; tree[x].flag:=0;
end;
procedure init;
var i:longint;
begin
//for i:=0 to maxn do begin tree[i].fall:=0; tree[i].flag:=0; end;
tot:=1; root:=1;
clear(root);
end;
procedure add(s:string);
var x,i,j:longint;
begin
x:=root;
for i:=1 to length(s) do
    begin
    if tree[x].next[ord(s[i])-ord('a')+1]=0 then
       begin
       inc(tot);
       clear(tot);
       tree[x].next[ord(s[i])-ord('a')+1]:=tot;
       end;
    x:=tree[x].next[ord(s[i])-ord('a')+1];
    if i=length(s) then inc(tree[x].flag);
    end;
end;
begin
{assign(input,'e:\wqf\acatm.in');
reset(input);}
readln(test);
for u:=1 to test do
    begin
    init;
    readln(n);
    for i:=1 to n do
        begin
        readln(s);
        add(s);
        end;
    head:=1; tail:=1;
    q[1]:=root;
    tree[root].fall:=0;
    while head<=tail do
      begin
      x:=q[head];
      for i:=1 to 26 do
          begin
          if tree[x].next[i]<>0 then
             begin
             if x=root then tree[tree[x].next[i]].fall:=root
                else begin
                     p:=tree[x].fall;
                     while p<>0 do
                        begin
                        if tree[p].next[i]<>0 then
                           begin
                           tree[tree[x].next[i]].fall:=tree[p].next[i];
                           break;
                           end;
                        p:=tree[p].fall;
                        end;
                     if p=0 then tree[tree[x].next[i]].fall:=root;
                     end;
             inc(tail);
             q[tail]:=tree[x].next[i];
             end;
          end;
      inc(head);
      end;
    cnt:=0;
    while not eoln do
      begin
      inc(cnt);
      read(s1[cnt]);
      end;
    readln;
    x:=root;
    ans:=0;
    for i:=1 to cnt do
        begin
        while (tree[x].next[ord(s1[i])-ord('a')+1]=0)and(x<>root)do
           x:=tree[x].fall;
        x:=tree[x].next[ord(s1[i])-ord('a')+1];
        if x=0 then x:=root;
        tx:=x;
        while (tx<>root)and(tree[tx].flag<>-1) do
           begin
           inc(ans,tree[tx].flag);
           tree[tx].flag:=-1;
           tx:=tree[tx].fall;
           end;
        end;
    writeln(ans);
    end;
//close(input);
end.