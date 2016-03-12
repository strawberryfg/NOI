//19:27; 20:45; 22:03;
const maxn=511111; maxtree=1111111;
type treetype=record cov,lc,rc,seg:longint; end;
var n,col,i,head,opt,rev,ans,res,right,num,x,y,xx,yy,tx,ty,t,c:longint;
    tree:array[0..maxtree]of treetype;
    a:array[0..maxn]of longint;
    s,ts:string; code:integer;
procedure update(x:longint);
begin
tree[x].lc:=tree[x*2].lc; tree[x].rc:=tree[x*2+1].rc;
tree[x].seg:=tree[x*2].seg+tree[x*2+1].seg;
if tree[x*2].rc=tree[x*2+1].lc then dec(tree[x].seg);
end;
procedure init(f,t,x:longint);
begin
if f=t then
   begin
   tree[x].cov:=a[f]; tree[x].lc:=a[f]; tree[x].rc:=a[f]; tree[x].seg:=1;
   exit;
   end;
init(f,(f+t) div 2,x*2);
init((f+t) div 2+1,t,x*2+1);
tree[x].cov:=-1;
update(x);
end;
//no pushdown when [].l=[].r
procedure pushdown(x:longint);
begin
if tree[x].cov<>-1 then
   begin
   tree[x*2].cov:=tree[x].cov; tree[x*2].lc:=tree[x].cov; tree[x*2].rc:=tree[x].cov; tree[x*2].seg:=1;
   tree[x*2+1].cov:=tree[x].cov; tree[x*2+1].lc:=tree[x].cov; tree[x*2+1].rc:=tree[x].cov; tree[x*2+1].seg:=1;
   tree[x].cov:=-1;
   end;
end;
function get(l,r,x,f,t:longint):longint;
var mid:longint;
begin
if l<>r then pushdown(x);
if (f<=l)and(r<=t) then exit(tree[x].cov);
mid:=(l+r) div 2;
if f<=mid then exit(get(l,mid,x*2,f,t));
if t>mid then exit(get(mid+1,r,x*2+1,f,t));
end;
procedure modify(l,r,x,f,t,v:longint);
var mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   tree[x].cov:=v; tree[x].lc:=v; tree[x].rc:=v; tree[x].seg:=1;
   exit;
   end;
if l<>r then pushdown(x);
mid:=(l+r) div 2;
if f<=mid then modify(l,mid,x*2,f,t,v);
if t>mid then modify(mid+1,r,x*2+1,f,t,v);
update(x);
end;
function getposition(num:longint):longint;
begin
if rev=0 then
   begin
   if (head<=num)and(num<=head+n-1) then exit(num-head+1)
      else exit(num+n-head+1);
   end
else
   begin //head+n-(n-1)= head+1
   if (head+1<=num)and(num<=head+n) then exit(head+n-num+1)
      else exit(head-num+1);                                    //head+n-(num+n)+1=head-num+1
   end;
end;
procedure work(x,y,c:longint);
var xx,yy:longint;
begin
if x=y then begin xx:=getposition(x); modify(1,n,1,xx,xx,c); exit; end;
if rev=0 then
   begin
   xx:=getposition(x); yy:=getposition(y);
   if (1<=xx)and(yy<=n)and(xx<=yy) then modify(1,n,1,xx,yy,c)
      else begin
           modify(1,n,1,xx,n,c);
           modify(1,n,1,1,yy,c);
           end;
   end
else
   begin
   xx:=getposition(x); yy:=getposition(y);
   if (1<=yy)and(xx<=n)and(yy<=xx) then modify(1,n,1,yy,xx,c)
      else begin
           modify(1,n,1,1,xx,c);
           modify(1,n,1,yy,n,c);
           end;
   end
end;
procedure query(l,r,x,f,t:longint);
var mid:longint;
begin
if l<>r then pushdown(x);
if (f<=l)and(r<=t) then
   begin
   if right=0 then begin right:=tree[x].rc; res:=res+tree[x].seg; exit; end
      else begin res:=res+tree[x].seg; if right=tree[x].lc then dec(res); right:=tree[x].rc; exit; end;
   end;
mid:=(l+r) div 2;
if f<=mid then query(l,mid,x*2,f,t);
if t>mid then query(mid+1,r,x*2+1,f,t);
end;
procedure work2(x,y:longint);
var xx,yy:longint;
begin
if x=y then
   begin
   writeln(1);
   exit;
   end;
if rev=0 then
   begin
   xx:=getposition(x); yy:=getposition(y);
   if (1<=xx)and(yy<=n)and(xx<=yy) then begin res:=0; right:=0; query(1,n,1,xx,yy); ans:=res; end
      else begin
           res:=0; right:=0; query(1,n,1,xx,n);
           ans:=res;
           res:=0; right:=0; query(1,n,1,1,yy);
           ans:=ans+res;
           if get(1,n,1,1,1)=get(1,n,1,n,n) then dec(ans);
           end;
   end
else
   begin
   xx:=getposition(x); yy:=getposition(y);
   if (1<=yy)and(xx<=n)and(yy<=xx) then begin res:=0; right:=0; query(1,n,1,yy,xx); ans:=res; end
      else begin
           res:=0; right:=0; query(1,n,1,1,xx);
           ans:=res;
           res:=0; right:=0; query(1,n,1,yy,n);
           ans:=ans+res;
           if get(1,n,1,1,1)=get(1,n,1,n,n) then dec(ans);
           end;
   end;
writeln(ans);
end;
begin
assign(input,'necklace.in');
reset(input);
assign(output,'necklace.out');
rewrite(output);
readln(n,col);
for i:=1 to n do read(a[i]);
head:=1;
init(1,n,1);
readln(opt);
rev:=0;
for i:=1 to opt do
    begin
    readln(s);
    if i=84 then
       x:=x;
    if s[1]='R' then begin delete(s,1,2); val(s,num,code); head:=(head+num) mod n; if head=0 then head:=n; end
       else if s[1]='F' then begin rev:=rev xor 1; if head<>1 then head:=n+2-head; end
               else if s[1]='S' then
                       begin
                       delete(s,1,2); t:=pos(' ',s); ts:=copy(s,1,t-1); val(ts,x,code); delete(s,1,t); val(s,y,code);
                       if x=y then continue;
                       xx:=getposition(x); yy:=getposition(y);
                       tx:=get(1,n,1,xx,xx);
                       ty:=get(1,n,1,yy,yy);
                       modify(1,n,1,xx,xx,ty); modify(1,n,1,yy,yy,tx);
                       end
                    else if s[1]='P' then
                            begin
                            delete(s,1,2); t:=pos(' ',s); ts:=copy(s,1,t-1); val(ts,x,code); delete(s,1,t); t:=pos(' ',s);
                            ts:=copy(s,1,t-1); val(ts,y,code); delete(s,1,t); val(s,c,code);
                            work(x,y,c);
                            end
                         else if (s[1]='C') then
                                 begin
                                 if length(s)=1 then
                                    begin
                                    ans:=tree[1].seg;
                                    if (ans<>1)and(get(1,n,1,1,1)=get(1,n,1,n,n)) then dec(ans);
                                    writeln(ans);
                                    end
                                 else
                                    begin
                                    delete(s,1,3); t:=pos(' ',s); ts:=copy(s,1,t-1); val(ts,x,code); delete(s,1,t); val(s,y,code);
                                    work2(x,y);
                                    end;
                                 end
    end;
close(input);
close(output);
end.