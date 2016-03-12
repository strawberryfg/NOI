//uses dos;
const maxn=1000020; maxm=220020; maxn1=420020; maxbina=65;
type rec=record ret,mat:array[0..20]of longint; end;
     querytype=record ll,rr,d,x,opt:longint; end;
var r,c,i,j,n,m,avoid,tot,now,ans,point,cnt:longint;
    target:array[0..10,0..10]of longint;
    sta:array[0..10]of longint;
    state,hash:array[0..maxbina]of longint;
    con:array[0..maxbina,0..10]of longint;
    tree:array[0..4*maxn1]of rec;
    tag:array[0..4*maxn1]of longint;
    ori,bel,axis:array[0..2*maxn]of longint;
    que:array[0..maxm]of querytype;
{    aa,bb,cc,dd:word;
    tt1,tt2:real;}
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
var i,ll,rr:longint;
begin
if l=r then
   begin
   for i:=1 to tot do
       begin
       ll:=ori[l]; rr:=ori[l+1]-1;
       if (rr-ll+1)mod 2=1 then tree[x].ret[i]:=con[i][1] else tree[x].ret[i]:=i;
       if con[i][1]=hash[avoid] then tree[x].mat[i]:=(rr-ll+1+1) shr 1
          else if i=hash[avoid] then tree[x].mat[i]:=(rr-ll+1) shr 1
                  else tree[x].mat[i]:=0;
       end;
   exit;
   end;
init(l,(l+r) shr 1,x shl 1);
init((l+r) shr 1+1,r,x shl 1+1);
for i:=1 to tot do
    begin
    tree[x].ret[i]:=tree[x shl 1+1].ret[tree[x shl 1].ret[i]];
    tree[x].mat[i]:=tree[x shl 1].mat[i]+tree[x shl 1+1].mat[tree[x shl 1].ret[i]];
    end;
end;
procedure pushdown(x,l,r:longint);
var i,ll,rr:longint;
begin
if tag[x]<>0 then
   begin
   tag[x shl 1]:=tag[x]; tag[x shl 1+1]:=tag[x];
   for i:=1 to tot do
       begin
//       inc(cnt);
       ll:=ori[l]; rr:=ori[r+1]-1;
       if (rr-ll+1)mod 2=1 then tree[x].ret[i]:=con[i][tag[x]] else tree[x].ret[i]:=i;
       if con[i][tag[x]]=hash[avoid] then tree[x].mat[i]:=(rr-ll+1+1) shr 1
          else if i=hash[avoid] then tree[x].mat[i]:=(rr-ll+1) shr 1
                  else tree[x].mat[i]:=0;
       end;
   tag[x]:=0;
   end;
end;
procedure modify(f,t,l,r,v,x:longint);
var i,mid,ll,rr:longint;
begin
if (f<=l)and(r<=t) then
   begin
//   inc(cnt);
   tag[x]:=v;
   exit;
   end;
pushdown(x,l,r);
mid:=(l+r) shr 1;
if f<=mid then modify(f,t,l,mid,v,x shl 1);
if t>mid then modify(f,t,mid+1,r,v,x shl 1+1);
pushdown(x shl 1,l,mid);
pushdown(x shl 1+1,mid+1,r);
for i:=1 to tot do
    begin
//    inc(cnt);
    tree[x].ret[i]:=tree[x shl 1+1].ret[tree[x shl 1].ret[i]];
    tree[x].mat[i]:=tree[x shl 1].mat[i]+tree[x shl 1+1].mat[tree[x shl 1].ret[i]];
    end;
end;
procedure query(f,t,l,r,now,x:longint);
var i,mid:longint;
begin
pushdown(x,l,r);
if (f<=l)and(r<=t) then
    begin
//    inc(cnt);
    ans:=ans+tree[x].mat[now];
    exit;
    end;
mid:=(l+r) shr 1;
if f<=mid then query(f,t,l,mid,now,x shl 1);
pushdown(x shl 1,l,mid);
if t>mid then query(f,t,mid+1,r,tree[x shl 1].ret[now],x shl 1+1);
{pushdown(x shl 1,l,mid);
pushdown(x shl 1+1,mid+1,r);
for i:=1 to tot do
    begin
    tree[x].ret[i]:=tree[x shl 1+1].ret[tree[x shl 1].ret[i]];
    tree[x].mat[i]:=tree[x shl 1].mat[i]+tree[x shl 1+1].mat[tree[x shl 1].ret[i]];
    end;}
end;
begin
assign(input,'sage.in');
reset(input);
assign(output,'sage.out');
rewrite(output);
readln(r,c);
avoid:=0;
{gettime(aa,bb,cc,dd);
tt1:=aa*3600+bb*60+cc+dd/100;}
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
doit;
for i:=1 to m do
    begin
    read(que[i].opt);
    if que[i].opt=0 then begin read(que[i].d,que[i].x); axis[que[i].d]:=1; axis[que[i].d+1]:=1; end
       else if que[i].opt=1 then begin read(que[i].ll,que[i].rr); axis[que[i].ll]:=1; axis[que[i].rr+1]:=1; end
               else begin read(que[i].ll,que[i].rr,que[i].x); axis[que[i].ll]:=1; axis[que[i].rr+1]:=1; end;
    readln;
    end;
point:=0;
axis[1]:=1;
for i:=1 to n+1 do
    if axis[i]=1 then
       begin
       inc(point);
       ori[point]:=i;
       bel[i]:=point;
       end;
init(1,point-1,1);
for i:=1 to m do
    begin
    if que[i].opt=0 then modify(bel[que[i].d],bel[que[i].d],1,point-1,que[i].x,1)
       else if que[i].opt=1 then begin now:=hash[0]; ans:=0; query(bel[que[i].ll],bel[que[i].rr+1]-1,1,point-1,now,1); writeln(ans); end
               else modify(bel[que[i].ll],bel[que[i].rr+1]-1,1,point-1,que[i].x,1);
    end;
{writeln(cnt);
gettime(aa,bb,cc,dd);
tt2:=aa*3600+bb*60+cc+dd/100;
writeln(tt2-tt1:0:4);}
close(input);
close(output);
end.
