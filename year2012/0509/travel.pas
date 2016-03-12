const maxn=100020; maxnumber=2000000; maxnode=2000000; base=1000000007;
type rec=record next:array[0..26]of longint; dep,fall:longint; res:longint; end;
     newtype=record ll,rr:longint; end;
var n,m,cnt,root,i,x,j,p,k,l,le,ri,ans,mid,tt,tot,flag,now,u,head,tail,ans1,ans2,xa,xb:longint;
    max,num,total,maxlen:longint;
    tmp:qword;
    tmpnum1,tmpnum2:qword;
    pow:array[0..maxnumber]of qword;
    a:array[0..maxn]of ansistring;
    g:array[0..maxn]of newtype;
    tree:array[0..maxnumber]of rec;
    q:array[0..maxnumber]of longint;
    ts1,ts2:ansistring;
    h,hash:array[0..maxnode]of longint;
    ch:char;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'travel.in');
reset(input);
assign(output,'travel.out');
rewrite(output);
readln(n);
root:=1; tot:=1;
total:=0;
for i:=1 to n do
    begin
    x:=root;
    cnt:=0;
    a[i]:='';
    while not eoln do
      begin
      read(ch);
      a[i]:=a[i]+ch;
      inc(cnt);
      inc(total);
      if cnt=1 then g[i].ll:=total;
      tt:=ord(ch)-ord('a');
      if tree[x].next[ord(ch)-ord('a')+1]=0 then
         begin
         inc(tot); tree[x].next[ord(ch)-ord('a')+1]:=tot;
         tree[tot].dep:=tree[x].dep+1;
         tmp:=qword(tree[x].res)*qword(26) mod base;
         tmp:=(tmp+tt)mod base;
         tree[tot].res:=tmp;
         end;
      x:=tree[x].next[ord(ch)-ord('a')+1];
      h[total]:=x;
      hash[total]:=tree[x].res;
      end;
    g[i].rr:=total;
    if g[i].rr-g[i].ll+1>maxlen then maxlen:=g[i].rr-g[i].ll+1;
    readln;
    end;
readln(m);
head:=1; tail:=1; q[1]:=root;
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
         inc(tail); q[tail]:=tree[x].next[i];
         end;
      end;
    inc(head);
    end;
pow[0]:=1;
for i:=1 to maxlen do pow[i]:=pow[i-1]*26 mod base;
for now:=1 to m do
    begin
    readln(i,j,k,l);
    le:=1; ri:=min(j,l);
    ans:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if g[i].ll+j-mid-1<g[i].ll then
         tmpnum1:=hash[g[i].ll+j-1] mod base
      else
         begin
         tmpnum1:=(hash[g[i].ll+j-1]+base-(hash[g[i].ll+j-mid-1])*pow[mid] mod base) mod base;
         if tmpnum1<0 then tmpnum1:=tmpnum1+base;
         end;
      if g[k].ll+l-mid-1<g[k].ll then
         tmpnum2:=hash[g[k].ll+l-1] mod base
      else
         begin
         tmpnum2:=(hash[g[k].ll+l-1]+base-(hash[g[k].ll+l-mid-1])*pow[mid] mod base) mod base;
         if tmpnum2<0 then tmpnum2:=tmpnum2+base;
         end;
      if tmpnum1=tmpnum2 then begin ans:=mid; le:=mid+1; end
         else ri:=mid-1;
      end;
    if ans=-1 then writeln(0)
       else begin
            x:=h[g[i].ll+j-1];
            ans1:=-1; ans2:=-1; xa:=0; xb:=0;
            if tree[x].dep=ans then begin xa:=x; ans1:=ans; end
               else begin
                    while true do
                      begin
                      x:=tree[x].fall;
                      if x=root then break;
                      if tree[x].dep<=ans then
                         begin
                         ans1:=tree[x].dep;
                         xa:=x;
                         break;
                         end;
                      end;
                    end;
            x:=h[g[k].ll+l-1];
            if tree[x].dep=ans then begin xb:=x; ans2:=ans; end
               else begin
                    while true do
                      begin
                      x:=tree[x].fall;
                      if x=root then break;
                      if tree[x].dep<=ans then
                         begin
                         ans2:=tree[x].dep;
                         xb:=x;
                         break;
                         end;
                      end;
                    end;
            max:=0; num:=0;
            if ans1<>-1 then {if tree[xa].dep>max then }begin max:=tree[xa].dep; num:=tree[xa].res; end;
            if ans2<>-1 then {if tree[xb].dep>max then }begin max:=tree[xb].dep; num:=tree[xb].res; end;
            writeln(num);
            end;
    end;
close(input);
close(output);
end.
