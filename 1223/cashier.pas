const maxn=800020; inf=1000000000;
var delta,root,tot,ans,n,min,i,k,total:longint;
    ch,c:char;
    left,right,fa,son,key:array[0..maxn]of longint;
function query(v:longint):longint;
var x:longint;
begin
x:=root;
while son[right[x]]+1<>v do
  begin
  if son[right[x]]>=v then begin x:=right[x]; end
     else begin
          if son[right[x]]+1=v then exit(key[x]+delta);
          v:=v-son[right[x]]-1;
          x:=left[x];
          end;
  end;
exit(key[x]+delta);
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
procedure delete;
var x,lx:longint;
begin
x:=root;
if x=0 then exit;
lx:=0;
while x<>0 do
  begin
  if lx=0 then lx:=x;
  if (key[x]+delta>=min) then lx:=x;
  if key[x]+delta<min then x:=right[x]
     else x:=left[x];
  end;
splay(lx,0);
total:=total-son[left[lx]];
ans:=ans+son[left[lx]];
left[lx]:=0;
update(lx);
end;
procedure insert(v:longint);
var x,lx:longint;
begin
if root=0 then
   begin
   inc(total);
   inc(tot);
   root:=tot;
   key[tot]:=v;
   son[tot]:=1;
   exit;
   end;
x:=root;
inc(total);
while x<>0 do
  begin
  inc(son[x]);
  lx:=x;
  if v<key[x] then x:=left[x]
     else x:=right[x];
  end;
if v<key[lx] then
   begin
   inc(tot);
   key[tot]:=v;
   left[lx]:=tot;
   fa[tot]:=lx;
   end
else
   begin
   inc(tot);
   key[tot]:=v;
   right[lx]:=tot;
   fa[tot]:=lx;
   end;
son[tot]:=1;
splay(tot,0);
end;
begin
{assign(input,'cashier.in');
reset(input);
assign(output,'cashier.out');
rewrite(output);}
readln(n,min);
for i:=1 to n do
    begin
    read(ch);
    read(c);
    if ch='I' then
       begin
       read(k);
       if k>=min then
          insert(k-delta);
       end
    else if ch='A' then
            begin
            read(k);
            delta:=delta+k;
            end
         else if ch='S' then
                 begin
                 read(k);
                 delta:=delta-k;
                 end
              else begin
                   read(k);
                   if k>total then writeln(-1)
                      else writeln(query(k));
                   end;
    readln;
    delete;
    end;
writeln(ans);
{close(input);
close(output);}
end.