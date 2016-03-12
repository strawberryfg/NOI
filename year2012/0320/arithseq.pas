const maxn=200000;
type rec=record l,r,lv,rv,v00,v01,v10,v11,del:longint; end;
var tree:array[0..4*maxn]of rec;
    ch,c:char;
    n,i,opt,ll,rr,a,b,ans1,ans2,ans3,tmp:longint;
    v:array[0..maxn]of longint;
    flag:boolean;
function check(x,y:longint):longint;
begin
if x=y then exit(-1) else exit(0);
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].lv:=v[f]; tree[x].rv:=v[t];
if t-f+1=1 then
   begin
   tree[x].v00:=0; tree[x].v01:=1; tree[x].v10:=1; tree[x].v11:=1;
   exit;
   end
else
   begin
   init(f,(f+t)div 2,x*2);
   init((f+t)div 2+1,t,x*2+1);
   tree[x].v00:=min(min(tree[x*2].v01+tree[x*2+1].v00,tree[x*2].v00+tree[x*2+1].v10),tree[x*2].v01+tree[x*2+1].v10+check(tree[x*2].rv,tree[x*2+1].lv));
   tree[x].v01:=min(min(tree[x*2].v00+tree[x*2+1].v11,tree[x*2].v01+tree[x*2+1].v01),tree[x*2].v01+tree[x*2+1].v11+check(tree[x*2].rv,tree[x*2+1].lv));
   tree[x].v10:=min(min(tree[x*2].v10+tree[x*2+1].v10,tree[x*2].v11+tree[x*2+1].v00),tree[x*2].v11+tree[x*2+1].v10+check(tree[x*2].rv,tree[x*2+1].lv));
   tree[x].v11:=min(min(tree[x*2].v10+tree[x*2+1].v11,tree[x*2].v11+tree[x*2+1].v01),tree[x*2].v11+tree[x*2+1].v11+check(tree[x*2].rv,tree[x*2+1].lv));
   end;
end;
procedure lazy(x:longint);
begin
if tree[x].del<>0 then
   begin
   tree[x*2].del:=tree[x*2].del+tree[x].del;
   tree[x*2+1].del:=tree[x*2+1].del+tree[x].del;
   tree[x*2].lv:=tree[x*2].lv+tree[x].del;
   tree[x*2].rv:=tree[x*2].rv+tree[x].del;
   tree[x*2+1].lv:=tree[x*2+1].lv+tree[x].del;
   tree[x*2+1].rv:=tree[x*2+1].rv+tree[x].del;
   tree[x].del:=0;
   end;
end;
procedure modify(f,t,d,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].del:=tree[x].del+d;
   tree[x].lv:=tree[x].lv+d;
   tree[x].rv:=tree[x].rv+d;
   exit;
   end;
if tree[x].l<>tree[x].r then
   begin
   lazy(x);
   mid:=(tree[x].l+tree[x].r)div 2;
   if f<=mid then modify(f,t,d,x*2);
   if t>mid then modify(f,t,d,x*2+1);
   tree[x].lv:=tree[x*2].lv;
   tree[x].rv:=tree[x*2+1].rv;
   tree[x].v00:=min(min(tree[x*2].v01+tree[x*2+1].v00,tree[x*2].v00+tree[x*2+1].v10),tree[x*2].v01+tree[x*2+1].v10+check(tree[x*2].rv,tree[x*2+1].lv));
   tree[x].v01:=min(min(tree[x*2].v00+tree[x*2+1].v11,tree[x*2].v01+tree[x*2+1].v01),tree[x*2].v01+tree[x*2+1].v11+check(tree[x*2].rv,tree[x*2+1].lv));
   tree[x].v10:=min(min(tree[x*2].v10+tree[x*2+1].v10,tree[x*2].v11+tree[x*2+1].v00),tree[x*2].v11+tree[x*2+1].v10+check(tree[x*2].rv,tree[x*2+1].lv));
   tree[x].v11:=min(min(tree[x*2].v10+tree[x*2+1].v11,tree[x*2].v11+tree[x*2+1].v01),tree[x*2].v11+tree[x*2+1].v11+check(tree[x*2].rv,tree[x*2+1].lv));
   end;
end;
procedure query(f,t,x:longint);
var tmp1,tmp2,mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   if flag then
      begin
      tmp1:=min(min(ans1+tree[x].v10,ans2+tree[x].v00),ans2+tree[x].v10+check(ans3,tree[x].lv));
      tmp2:=min(min(ans1+tree[x].v11,ans2+tree[x].v01),ans2+tree[x].v11+check(ans3,tree[x].lv));
      ans1:=tmp1;
      ans2:=tmp2;
      ans3:=tree[x].rv;
      end
   else
      begin
      flag:=true;
      ans1:=tree[x].v10;
      ans2:=tree[x].v11;
      ans3:=tree[x].rv;
      end;
   end
else
   begin
   if tree[x].l<>tree[x].r then
      begin
      lazy(x);
      mid:=(tree[x].l+tree[x].r)div 2;
      if f<=mid then query(f,t,x*2);
      if t>mid then query(f,t,x*2+1);
      tree[x].lv:=tree[x*2].lv;
      tree[x].rv:=tree[x*2+1].rv;
      tree[x].v00:=min(min(tree[x*2].v01+tree[x*2+1].v00,tree[x*2].v00+tree[x*2+1].v10),tree[x*2].v01+tree[x*2+1].v10+check(tree[x*2].rv,tree[x*2+1].lv));
      tree[x].v01:=min(min(tree[x*2].v00+tree[x*2+1].v11,tree[x*2].v01+tree[x*2+1].v01),tree[x*2].v01+tree[x*2+1].v11+check(tree[x*2].rv,tree[x*2+1].lv));
      tree[x].v10:=min(min(tree[x*2].v10+tree[x*2+1].v10,tree[x*2].v11+tree[x*2+1].v00),tree[x*2].v11+tree[x*2+1].v10+check(tree[x*2].rv,tree[x*2+1].lv));
      tree[x].v11:=min(min(tree[x*2].v10+tree[x*2+1].v11,tree[x*2].v11+tree[x*2+1].v01),tree[x*2].v11+tree[x*2+1].v11+check(tree[x*2].rv,tree[x*2+1].lv));
      end;
   end;
end;
begin
assign(input,'arithseq.in');
reset(input);
assign(output,'arithseq.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(v[i]);
for i:=1 to n-1 do v[i]:=v[i+1]-v[i];
init(1,n-1,1);
readln(opt);
for i:=1 to opt do
    begin
    read(ch); read(c);
    if ch='A' then
       begin
       read(ll,rr,a,b);
       readln;
       if a<>0 then modify(ll-1,ll-1,a,1);
       if rr<=n-1 then
          begin
          tmp:=-a-b*(rr-ll);
          if tmp<>0 then modify(rr,rr,-a-b*(rr-ll),1);
          end;
       if ll<=rr-1 then
          begin
          if b<>0 then modify(ll,rr-1,b,1);
          end;
       end
    else
       begin
       read(ll,rr);
       readln;
       if ll=rr then writeln(1)
          else begin
               flag:=false;
               ans1:=0; ans2:=0;
               query(ll,rr-1,1);
               writeln(ans2);
               end;
       end;
    end;
close(input);
close(output);
end.
