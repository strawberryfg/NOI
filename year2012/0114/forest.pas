var sum,i,n,tsum,value,ans,cut,ttt,total,ttotal:longint;
    x,y,v,l,a,b,c,tc,hash:array[0..200]of longint;
    len,tmp:extended;
function cross(p,q,r:longint):longint;
var x1,x2,y1,y2:longint;
begin
x1:=x[q]-x[p]; y1:=y[q]-y[p];
x2:=x[r]-x[p]; y2:=y[r]-y[p];
exit(x1*y2-x2*y1);
end;
function calc(p,q:longint):extended;
begin
exit(sqrt((x[p]-x[q])*(x[p]-x[q])+(y[p]-y[q])*(y[p]-y[q])));
end;
procedure check;
var minx,num,now,i,next:longint;
    flag,pd:boolean;
    res:extended;
begin
if sum=0 then exit;
if sum<>1 then
   begin
   fillchar(hash,sizeof(hash),0);
   minx:=maxlongint; num:=-1;
   for i:=1 to sum do
       begin
       if x[a[i]]<minx then begin minx:=x[a[i]]; num:=a[i]; end
          else if (x[a[i]]=minx)and(y[a[i]]<y[num]) then
                  num:=i;
       end;
   hash[num]:=1;
   pd:=true; now:=num;
   res:=0;
   while (now<>num)or((now=num)and(pd)) do
     begin
     pd:=false;
     for i:=1 to sum do
         if hash[a[i]]=0 then
            begin
            next:=a[i];
            break;
            end;
   if now=next then break;
   while true do
     begin
     flag:=true;
     for i:=1 to sum do
         begin
         if a[i]<>next then
            begin
            if cross(now,next,a[i])<0 then
               begin
               flag:=false;
               next:=a[i];
               break;
               end;
            end
         end;
     if flag then
        begin
        hash[next]:=1;
        break;
        end;
     end;
   res:=res+calc(now,next);
   now:=next;
   end;
   res:=res+calc(now,num);
   end
else
   res:=0;
if (abs(len-res)<1e-10)or(len-res>1e-10) then
   begin
   if value<ans then
      begin
      ans:=value;
      tmp:=len-res;
      tc:=c;
      ttotal:=total;
      end
   else
      if (value=ans)and(sum<cut) then
          begin
          cut:=sum;
          tmp:=len-res;
          tc:=c;
          ttotal:=total;
          end;
   end;
end;
procedure dfs(dep:longint);
var i:longint;
begin
if dep>n then
   begin
   check;
   exit;
   end;
for i:=0 to 1 do
    begin
    b[dep]:=i;
    if i=0 then
       begin
       len:=len+l[dep];
       value:=value+v[dep];
       inc(total);
       c[total]:=dep;
       dfs(dep+1);
       dec(total);
       len:=len-l[dep];
       value:=value-v[dep];
       end
    else
       begin
       inc(sum);
       a[sum]:=dep;
       dfs(dep+1);
       dec(sum);
       end;
    end;
end;
begin
assign(input,'forest.in');
reset(input);
assign(output,'forest.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(x[i],y[i],v[i],l[i]);
sum:=0;
len:=0;
value:=0;
ans:=maxlongint;
cut:=maxlongint;
dfs(1);
writeln(tmp:0:2);
for i:=1 to ttotal-1 do write(tc[i],' ');
write(tc[ttotal]);
writeln;
close(input);
close(output);
end.