const maxn=40020; inf=555555555555555555;
type rec=record sumv,lsmax,rsmax,sall,lall,rall,llmax,rrmax,lrm,lxm,rxm,ans:int64; end;
var test,now,i,j,n,opt,x,y,ch,x1,y1,x2,y2:longint;
    a:array[0..5,0..maxn]of int64;
    tree:array[0..6,0..4*maxn]of rec;
    value,res:int64;
    ret,spe:rec;
function max(x,y:int64):int64; inline;
begin
if x>y then exit(x) else exit(y);
end;
function update(a,b:rec):rec; inline;
var x:rec;
begin
x.sumv:=a.sumv+b.sumv;
x.lsmax:=max(a.lsmax,a.sumv+b.lsmax);
x.rsmax:=max(b.rsmax,b.sumv+a.rsmax);
x.sall:=a.sall+b.sall;
x.lall:=max(max(a.lall+b.sumv,a.sall+b.lall),a.sall+b.sumv);
x.rall:=max(max(b.rall+a.sumv,b.sall+a.rall),b.sall+a.sumv);
x.llmax:=max(max(a.llmax,max(a.sall+b.llmax,a.sall+b.lsmax)),a.lall+b.lsmax);
x.rrmax:=max(max(b.rrmax,max(b.sall+a.rrmax,b.sall+a.rsmax)),b.rall+a.rsmax);
x.lrm:=max(max(max(max(a.lrm+b.sumv,b.lrm+a.sumv),a.rall+b.lall),a.rall+b.sumv),b.lall+a.sumv);
x.lxm:=max(max(max(max(max(max(x.lrm,a.lxm),a.lrm+b.lsmax),a.rall+b.lsmax),a.rall+b.llmax),a.sumv+b.llmax),a.sumv+b.lxm);
x.rxm:=max(max(max(max(max(max(x.lrm,b.rxm),b.lrm+a.rsmax),b.lall+a.rsmax),b.lall+a.rrmax),b.sumv+a.rrmax),b.sumv+a.rxm);
x.ans:=max(max(max(max(max(max(max(max(max(max(a.ans,b.ans),x.lrm),x.lxm),x.rxm),a.rall+b.lall),a.rrmax+b.llmax),a.rrmax+b.lsmax),b.llmax+a.rsmax),a.rxm+b.lsmax),b.lxm+a.rsmax);
update:=x;
end;
procedure modify(f,t,l,r,x,opt:longint); inline;
var mid:longint;
begin
if l=r then
   begin
   if opt=1 then
      begin
      tree[opt][x].sumv:=a[1][l]+a[3][l]; tree[opt][x].lsmax:=a[1][l]+a[3][l]; tree[opt][x].rsmax:=tree[opt][x].lsmax;
      tree[opt][x].sall:=a[1][l]+a[2][l]+a[3][l]; tree[opt][x].lall:=-inf; tree[opt][x].rall:=-inf;
      tree[opt][x].llmax:=-inf; tree[opt][x].rrmax:=-inf; tree[opt][x].lrm:=-inf; tree[opt][x].lxm:=-inf; tree[opt][x].rxm:=-inf; tree[opt][x].ans:=-inf;
      end
   else if opt=2 then
           begin
           tree[opt][x].sumv:=a[2][l]+a[4][l]; tree[opt][x].lsmax:=a[2][l]+a[4][l]; tree[opt][x].rsmax:=tree[opt][x].lsmax;
           tree[opt][x].sall:=a[2][l]+a[3][l]+a[4][l]; tree[opt][x].lall:=-inf; tree[opt][x].rall:=-inf;
           tree[opt][x].llmax:=-inf; tree[opt][x].rrmax:=-inf; tree[opt][x].lrm:=-inf; tree[opt][x].lxm:=-inf; tree[opt][x].rxm:=-inf; tree[opt][x].ans:=-inf;
           end
        else if opt=3 then
                begin
                tree[opt][x].sumv:=a[1][l]+a[2][l]+a[4][l]; tree[opt][x].lsmax:=a[1][l]+a[2][l]+a[4][l]; tree[opt][x].rsmax:=tree[opt][x].lsmax;
                tree[opt][x].sall:=a[1][l]+a[2][l]+a[3][l]+a[4][l]; tree[opt][x].lall:=-inf; tree[opt][x].rall:=-inf;
                tree[opt][x].llmax:=-inf; tree[opt][x].rrmax:=-inf; tree[opt][x].lrm:=-inf; tree[opt][x].lxm:=-inf; tree[opt][x].rxm:=-inf; tree[opt][x].ans:=-inf;
                end
             else if opt=4 then
                     begin
                     tree[opt][x].sumv:=a[1][l]+a[3][l]+a[4][l]; tree[opt][x].lsmax:=a[1][l]+a[3][l]+a[4][l]; tree[opt][x].rsmax:=tree[opt][x].lsmax;
                     tree[opt][x].sall:=a[1][l]+a[2][l]+a[3][l]+a[4][l]; tree[opt][x].lall:=-inf; tree[opt][x].rall:=-inf;
                     tree[opt][x].llmax:=-inf; tree[opt][x].rrmax:=-inf; tree[opt][x].lrm:=-inf; tree[opt][x].lxm:=-inf; tree[opt][x].rxm:=-inf; tree[opt][x].ans:=-inf;
                     end
                  else begin
                       tree[opt][x].sumv:=a[1][l]+a[4][l]; tree[opt][x].lsmax:=a[1][l]+a[4][l]; tree[opt][x].rsmax:=tree[opt][x].lsmax;
                       tree[opt][x].sall:=a[1][l]+a[2][l]+a[3][l]+a[4][l]; tree[opt][x].lall:=-inf; tree[opt][x].rall:=-inf;
                       tree[opt][x].llmax:=-inf; tree[opt][x].rrmax:=-inf; tree[opt][x].lrm:=-inf; tree[opt][x].lxm:=-inf; tree[opt][x].rxm:=-inf; tree[opt][x].ans:=-inf;
                       end;
   exit;
   end;
mid:=(l+r) div 2;
if f<=mid then modify(f,t,l,mid,x*2,opt);
if t>mid then modify(f,t,mid+1,r,x*2+1,opt);
tree[opt][x]:=update(tree[opt][x*2],tree[opt][x*2+1]);
end;
function get(f,t,l,r,x,opt:longint):rec; inline;
var a,b:rec;
    mid:longint;
begin
if (f<=l)and(r<=t) then exit(tree[opt][x]);
mid:=(l+r) div 2;
if t<=mid then exit(get(f,t,l,mid,x*2,opt));
if f>mid then exit(get(f,t,mid+1,r,x*2+1,opt));
a:=get(f,t,l,mid,x*2,opt);
b:=get(f,t,mid+1,r,x*2+1,opt);
get:=update(a,b);
end;
begin
assign(input,'mmm.in');
reset(input);
assign(output,'mmm.out');
rewrite(output);
readln(test);
spe.sumv:=0; spe.sall:=0;
spe.lall:=-inf; spe.rall:=-inf; spe.lsmax:=-inf; spe.rsmax:=-inf;
spe.llmax:=-inf; spe.rrmax:=-inf; spe.lrm:=-inf; spe.lxm:=-inf; spe.rxm:=-inf; spe.ans:=-inf;
for now:=1 to test do
    begin
    readln(n);
    for i:=1 to 4 do begin for j:=1 to n do read(a[i][j]); readln; end;
    for i:=1 to 5 do for j:=1 to n do modify(j,j,1,n,1,i);
    readln(opt);
    for i:=1 to opt do
        begin
        read(ch);
        if ch=1 then
           begin
           read(x1,y1,x2,y2);
           if (x1=1)and(x2=3) then
              begin
              ret:=get(y1,y2,1,n,1,1);
              if ret.ans<0 then writeln(0) else writeln(ret.ans);
              end
           else if (x1=2)and(x2=4) then
                   begin
                   ret:=get(y1,y2,1,n,1,2);
                   if ret.ans<0 then writeln(0) else writeln(ret.ans);
                   end
                else if (x1=1)and(x2=4) then
                        begin
                        res:=-inf;
                        ret:=get(y1,y2,1,n,1,1);
                        res:=max(res,ret.ans);
                        ret:=get(y1,y2,1,n,1,2);
                        res:=max(res,ret.ans);
                        ret:=get(y1,y2,1,n,1,3);
                        res:=max(res,ret.ans);
                        ret:=get(y1,y2,1,n,1,4);
                        res:=max(res,ret.ans);
                        ret:=get(y1,y2,1,n,1,5);
                        res:=max(res,ret.ans);
                        res:=max(0,res);
                        writeln(res);
                        end
                     else
                        writeln(0);
           end
        else
           begin
           read(x,y,value);
           a[x][y]:=value;
           for j:=1 to 5 do modify(y,y,1,n,1,j);
           end;
        readln;
        end;
    end;
close(input);
close(output);
end.