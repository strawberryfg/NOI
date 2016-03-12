const maxn=4000020;
var cur,n,root,tot,i,j,k,q,total:longint;
    son,fa,left,right:array[0..maxn]of longint;
    ch:char;
    key:array[0..maxn]of char;
function find(x,k:longint):longint;
begin
//if k>total then k:=total;
while son[left[x]]+1<>k do
  begin
  if son[left[x]]>=k then x:=left[x]
     else begin
          k:=k-1-son[left[x]];
          x:=right[x];
          end;
  end;
exit(x);
end;
procedure update(x:longint);
begin
if x=0 then exit;
son[x]:=son[left[x]]+son[right[x]]+1;
end;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
left[x]:=y;
update(y);
update(x);
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
right[x]:=y;
update(y);
update(x);
end;
procedure splay(x,y:longint);
begin
while fa[x]<>y do
  begin
  if fa[fa[x]]=y then
     begin
     if x=left[fa[x]] then rightrotate(x)
        else leftrotate(x);
     end
  else
     begin
     if fa[x]=left[fa[fa[x]]] then
        begin
        if x=left[fa[x]] then
           begin
           rightrotate(fa[x]);
           rightrotate(x);
           end
        else
           begin
           leftrotate(x);
           rightrotate(x);
           end;
        end
     else
        begin
        if x=right[fa[x]] then
           begin
           leftrotate(fa[x]);
           leftrotate(x);
           end
        else
           begin
           rightrotate(x);
           leftrotate(x);
           end;
        end;
     end;
  end;
if y=0 then root:=x;
end;
procedure insert(k:longint;ch:char);
var x,y:longint;
begin
x:=find(root,k+1);
y:=find(root,k+2);
splay(x,0);
splay(y,x);
inc(tot);
left[y]:=tot; key[tot]:=ch;
son[tot]:=1; fa[tot]:=y;
update(y);
update(x);
splay(tot,0);
end;
procedure delete(k:longint);
var x,y:longint;
begin
x:=find(root,cur+1);
y:=find(root,cur+k+2);
splay(x,0);
splay(y,x);
left[y]:=0;
update(y);
update(x);
end;
procedure print(x:longint);
begin
if x=0 then exit;
print(left[x]);
write(key[x]);
print(right[x]);
end;
procedure gets(k:longint);
var x,y:longint;
begin
x:=find(root,cur+1);
y:=find(root,cur+k+2);
splay(x,0);
splay(y,x);
print(left[y]);
end;
begin
assign(input,'editor.in');
reset(input);
assign(output,'editor.out');
rewrite(output);
readln(q);
root:=1; tot:=2;
right[1]:=2;
fa[2]:=1; son[1]:=2; son[2]:=1;
total:=2;
for i:=1 to q do
    begin
    read(ch);
    while (ord(ch)=10)or(ord(ch)=13)or(ord(ch)=32)do read(ch);
    if ch='M' then
       begin
       for j:=1 to 4 do read(ch);
       read(k);
       cur:=k;
       end
    else
       if ch='I' then
          begin
          for j:=1 to 6 do read(ch);
          read(n);
          j:=1;
          while j<=n do
            begin
            read(ch);
            while (ord(ch)=10)or(ord(ch)=13)do read(ch);
            insert(cur+j-1,ch);
            inc(total);
            inc(j);
            end;
//          cur:=cur+n;
          end
       else if ch='D' then
               begin
               for j:=1 to 6 do read(ch);
               read(n);
               delete(n);
               total:=total-n;
               end
            else if ch='G' then
                    begin
                    for j:=1 to 3 do read(ch);
                    read(n);
                    gets(n);
                    writeln;
                    end
                 else if ch='P' then
                         begin
                         for j:=1 to 3 do read(ch);
                         dec(cur);
                         end
                      else begin
                           for j:=1 to 3 do read(ch);
                           inc(cur);
                           end;
    end;
close(input);
close(output);
end.
