const maxn=1000020; maxbina=65;
type rec=record ret,mat:array[0..20]of longint; end;
var r,c,i,j,n,m,avoid,opt,d,ll,rr,x,tot,now,ans:longint;
    target:array[0..10,0..10]of longint;
    sta:array[0..10]of longint;
    state,hash:array[0..maxbina]of longint;
    con:array[0..maxbina,0..10]of longint;
    tree:array[0..4*maxn]of rec;
    tag:array[0..4*maxn]of longint;
procedure work;
var x,i,j:longint;
begin
x:=0;
for i:=1 to r do
    if sta[i]=1 then
       for j:=1 to c do
           x:=x xor (1 shl ((i-1)*c+j-1));
for i:=r+1 to r+c do
    if sta[i]=1 then
       for j:=1 to r do
           x:=x xor (1 shl ((j-1)*c+i-r-1));
if hash[x]=0 then begin inc(tot); state[tot]:=x; hash[x]:=tot; end;
end;
procedure doit;
var i,j,k,x:longint;
begin
for i:=1 to tot do
    begin                                  //state
    for j:=1 to r do                       //buttons;
        begin
        x:=state[i];
        for k:=1 to c do
            x:=x xor (1 shl ((j-1)*c+k-1));
        con[i][j]:=hash[x];
        end;
    for j:=r+1 to r+c do
        begin
        x:=state[i];
        for k:=1 to r do
            x:=x xor (1 shl ((k-1)*c+j-r-1));
        con[i][j]:=hash[x];
        end;
    end;
end;
procedure dfs(x:longint);
var i:longint;
begin
if x>r+c then begin work; exit; end;
for i:=0 to 1 do begin sta[x]:=i; dfs(x+1); end;
end;
procedure init(l,r,x:longint);
var i:longint;
begin
if l=r then
   begin
   for i:=1 to tot do
       begin
       tree[x].ret[i]:=con[i][1];
       if con[i][1]=hash[avoid] then tree[x].mat[i]:=1
          else tree[x].mat[i]:=0;
       end;
   exit;
   end;
init(l,(l+r)div 2,x*2);
init((l+r)div 2+1,r,x*2+1);
for i:=1 to tot do
    begin
    tree[x].ret[i]:=tree[x*2+1].ret[tree[x*2].ret[i]];
    tree[x].mat[i]:=tree[x*2].mat[i]+tree[x*2+1].mat[tree[x*2].ret[i]];
    end;
end;
procedure pushdown(x,l,r:longint);
var i,mid:longint;
begin
mid:=(l+r)div 2;
if tag[x]<>0 then
   begin
   tag[x*2]:=tag[x]; tag[x*2+1]:=tag[x];
   for i:=1 to tot do
       begin
       if (mid-l+1)mod 2=1 then tree[x*2].ret[i]:=con[i][tag[x]] else tree[x*2].ret[i]:=i;
       if con[i][tag[x]]=hash[avoid] then
          begin
          tree[x*2].mat[i]:=(mid-l+1+1)div 2;
          tree[x*2+1].mat[i]:=(r-mid+1)div 2;
          end
       else
          begin
          if i=hash[avoid] then begin tree[x*2].mat[i]:=(mid-l+1)div 2; tree[x*2+1].mat[i]:=(r-mid)div 2; end
             else begin tree[x*2].mat[i]:=0; tree[x*2+1].mat[i]:=0; end;
          end;
       if (r-mid)mod 2=1 then tree[x*2+1].ret[i]:=con[i][tag[x]] else tree[x*2+1].ret[i]:=i;
       end;
   tag[x]:=0;
   end;
end;
procedure modify(f,t,l,r,v,x:longint);
var i,mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   tag[x]:=v;
   for i:=1 to tot do
       begin
       if (r-l+1)mod 2=1 then tree[x].ret[i]:=con[i][v] else tree[x].ret[i]:=i;
       if con[i][v]=hash[avoid] then tree[x].mat[i]:=(r-l+2)div 2
          else if i=hash[avoid] then tree[x].mat[i]:=(r-l+1)div 2
                  else tree[x].mat[i]:=0;
       end;
   exit;
   end;
pushdown(x,l,r);
mid:=(l+r)div 2;
if f<=mid then modify(f,t,l,mid,v,x*2);
if t>mid then modify(f,t,mid+1,r,v,x*2+1);
for i:=1 to tot do
    begin
    tree[x].ret[i]:=tree[x*2+1].ret[tree[x*2].ret[i]];
    tree[x].mat[i]:=tree[x*2].mat[i]+tree[x*2+1].mat[tree[x*2].ret[i]];
    end;
end;
procedure query(f,t,l,r,now,x:longint);
var i,mid:longint;
begin
pushdown(x,l,r);
if (f<=l)and(r<=t) then
    begin
    ans:=ans+tree[x].mat[now];
    exit;
    end;
mid:=(l+r)div 2;
if f<=mid then query(f,t,l,mid,now,x*2);
if t>mid then query(f,t,mid+1,r,tree[x*2].ret[now],x*2+1);
for i:=1 to tot do
    begin
    tree[x].ret[i]:=tree[x*2+1].ret[tree[x*2].ret[i]];
    tree[x].mat[i]:=tree[x*2].mat[i]+tree[x*2+1].mat[tree[x*2].ret[i]];
    end;
end;
begin
assign(input,'sage.in');
reset(input);
assign(output,'sage.out');
rewrite(output);
readln(r,c);
avoid:=0;
for i:=1 to r do
    begin
    for j:=1 to c do
        begin
        read(target[i][j]);
        avoid:=avoid+1 shl ((i-1)*c+j-1)*target[i][j];
        end;
    readln;
    end;
readln(n,m);
dfs(1);
//for i:=1 to tot do writeln(i,'    :    ',state[i]);
doit;
init(1,n,1);
for i:=1 to m do
    begin
    read(opt);
    if opt=0 then
       begin
       read(d,x);
       modify(d,d,1,n,x,1);
       end
    else if opt=1 then
            begin
            read(ll,rr);
            now:=hash[0];
            ans:=0;
            query(ll,rr,1,n,now,1);
            writeln(ans);
            end
         else
            begin
            read(ll,rr,x);
            modify(ll,rr,1,n,x,1);
            end;
    readln;
    end;
close(input);
close(output);
end.