const maxn=200200; maxm=200200;
type newtype=record ll,rr:longint; end;
     quetype=record ll,rr,c:longint; end;
var n,m,k,seg,sum,cnt,top,r,i,j,le,ri,mid,ans1,ans2,ans,last,num,pd:longint;
    a,c,d:array[0..maxm]of newtype;
    que:array[0..maxm]of quetype;
    stack,put,f:array[0..maxm]of longint;
    b,ret:array[0..maxn]of longint;
procedure sorta(l,r: longint);
var i,j,cmpl,cmpr:longint; swapa:newtype;
begin
i:=l; j:=r; cmpl:=a[(l+r) div 2].ll; cmpr:=a[(l+r)div 2].rr;
repeat
while (a[i].ll<cmpl)or((a[i].ll=cmpl)and(a[i].rr<cmpr)) do inc(i);
while (cmpl<a[j].ll)or((cmpl=a[j].ll)and(cmpr<a[j].rr)) do dec(j);
if not(i>j) then begin swapa:=a[i]; a[i]:=a[j]; a[j]:=swapa; inc(i); dec(j); end;
until i>j;
if l<j then sorta(l,j); if i<r then sorta(i,r);
end;
procedure sortc(l,r: longint);
var i,j,cmpl,cmpr:longint; swapc:newtype;
begin
i:=l; j:=r; cmpl:=c[(l+r) div 2].ll; cmpr:=c[(l+r)div 2].rr;
repeat
while (c[i].ll<cmpl)or((c[i].ll=cmpl)and(c[i].rr>cmpr)) do inc(i);
while (cmpl<c[j].ll)or((cmpl=c[j].ll)and(cmpr>c[j].rr)) do dec(j);
if not(i>j) then begin swapc:=c[i]; c[i]:=c[j]; c[j]:=swapc; inc(i); dec(j); end;
until i>j;
if l<j then sortc(l,j); if i<r then sortc(i,r);
end;
begin
assign(input,'guard.in');
reset(input);
assign(output,'guard.out');
rewrite(output);
readln(n,k,m);
seg:=0;
for i:=1 to m do
    begin
    readln(que[i].ll,que[i].rr,que[i].c);
    if (que[i].c=0) then
       begin
       inc(seg);
       a[seg].ll:=que[i].ll; a[seg].rr:=que[i].rr;
       end;
    end;
sorta(1,seg);
cnt:=0;
if (seg=0) then begin for i:=1 to n do begin inc(cnt); b[cnt]:=i; end; end
   else begin
        for i:=1 to a[1].ll-1 do begin inc(cnt); b[cnt]:=i; end;
        r:=a[1].rr;
        for i:=2 to seg do
            begin
            if (a[i].ll<=r) then begin if (a[i].rr>r) then r:=a[i].rr; end
                else begin for j:=r+1 to a[i].ll-1 do begin inc(cnt); b[cnt]:=j; end; r:=a[i].rr; end;
            end;
        for i:=r+1 to n do begin inc(cnt); b[cnt]:=i; end;
        end;
if cnt=k then for i:=1 to cnt do writeln(b[i])
   else begin
        sum:=0;
        for i:=1 to m do
            begin
            if (que[i].c=0) then continue;
            le:=1; ri:=cnt; ans1:=-1;
            while le<=ri do
              begin
              mid:=(le+ri)div 2;
              if (b[mid]<que[i].ll) then le:=mid+1
                  else begin ans1:=mid; ri:=mid-1; end;
              end;
            le:=1; ri:=cnt; ans2:=-1;
            while le<=ri do
              begin
              mid:=(le+ri)div 2;
              if (b[mid]>que[i].rr) then ri:=mid-1
                 else begin ans2:=mid; le:=mid+1; end;
              end;
            if (ans1=-1)or(ans2=-1) then continue;
            inc(sum); c[sum].ll:=ans1; c[sum].rr:=ans2;  // b[ans1] - - - - - b[ans2];
            end;
        sortc(1,sum);
        if (sum=0) then begin if (cnt=k) then begin for i:=1 to cnt do writeln(b[i]); end else writeln(-1); end
           else begin
                top:=1; stack[1]:=1;
                for i:=2 to sum do
                    begin
                    while (top>0)and(c[stack[top]].rr>=c[i].rr) do dec(top);
                    inc(top); stack[top]:=i;
                    end;
                for i:=1 to top do d[i]:=c[stack[i]];
                for i:=top downto 1 do
                    begin
                    le:=i+1; ri:=top; ans:=-1;
                    while le<=ri do
                      begin
                      mid:=(le+ri)div 2;
                      if (d[mid].ll<=d[i].rr) then le:=mid+1
                         else begin ans:=mid; ri:=mid-1; end;
                      end;
                    if (ans=-1) then f[i]:=1
                       else f[i]:=f[ans]+1;
                    end;
                last:=d[1].rr; put[1]:=1;
                for i:=2 to top do
                    begin
                    if (d[i].ll<=last) then put[i]:=put[i-1]
                       else begin
                            put[i]:=put[i-1]+1;
                            last:=d[i].rr;
                            end;
                    end;
                for i:=1 to top do
                    begin
                    if (put[i]-put[i-1]=1) then   // the right;
                       begin
                       if (d[i].rr-d[i].ll+1=1) then begin ret[b[d[i].ll]]:=1; continue; end;
                       le:=i+1; ri:=top; ans:=-1;
                       while le<=ri do
                         begin
                         mid:=(le+ri)div 2;
                         if (d[mid].ll<=d[i].rr-1) then le:=mid+1
                            else begin ans:=mid; ri:=mid-1; end;
                         end;
                    if (ans=-1) then num:=put[i-1]+1
                       else num:=put[i-1]+1+f[ans];
                    if num>k then ret[b[d[i].rr]]:=1;
                    end;
                 end;
                pd:=0;
                for i:=1 to n do if ret[i]<>0 then begin writeln(i); pd:=1; end;
                if pd=0 then writeln(-1);
                end;
        end;
close(input);
close(output);
end.