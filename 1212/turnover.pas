const maxn=100000;
var tot,root,ans,i,n,t:longint;
    left,right,fa,key,son,num:array[0..maxn]of longint;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
left[x]:=y;
fa[x]:=fa[y];
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[y]:=x;
son[x]:=son[y];
son[y]:=son[left[y]]+son[right[y]]+1;
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
right[x]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
son[x]:=son[y];
son[y]:=son[left[y]]+son[right[y]]+1;
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
        if x=left[fa[x]] then
           begin
           rightrotate(x);
           leftrotate(x);
           end
        else
           begin
           leftrotate(fa[x]);
           leftrotate(x);
           end;
        end;
     end;
  end;
if y=0 then root:=x;
end;
procedure insert(v:longint);
var x:longint;
begin
x:=root;
while true do
  begin
  inc(son[x]);
  if v<key[x] then
     begin
     if left[x]=0 then break
        else x:=left[x];
     end
  else
     begin
     if right[x]=0 then break
        else x:=right[x];
     end;
  end;
inc(tot);
inc(son[tot]);
num[i]:=tot;
key[tot]:=v;
fa[tot]:=x;
if v<key[x] then left[x]:=tot
   else right[x]:=tot;
splay(x,0);
end;
function query(v:longint):longint;
var x,y,z,res:longint;
begin
x:=num[i];
splay(x,0);
y:=left[x];
while right[y]<>0 do y:=right[y];
res:=maxlongint;
if y<>0 then if abs(v-key[y])<res then res:=abs(v-key[y]);
z:=right[x];
while left[z]<>0 do z:=left[z];
if z<>0 then if abs(v-key[z])<res then res:=abs(v-key[z]);
exit(res);
end;
begin
assign(input,'turnover.in');
reset(input);
assign(output,'turnover.out');
rewrite(output);
readln(n);
ans:=0;
for i:=1 to n do
    begin
    readln(t);
    insert(t);
    if i=1 then ans:=ans+t
       else begin
            ans:=ans+query(t);
            end;
    end;
writeln(ans);
close(input);
close(output);
end.