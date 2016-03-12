const maxk=50002;
      maxn=20002;
var k,n,c,i,ans,tmp:longint;
    s,e,w:array[1..maxk]of longint;
    a,ll,rr,tag:array[1..4*maxn]of longint;

function min(x,y:longint):longint;
begin
 if x<y then exit(x)
        else exit(y);
end;

procedure sort(l,r: longint);
      var
         i,j,x,y,tx: longint;
      begin
         i:=l;
         j:=r;
         x:=e[(l+r) div 2];
         tx:=s[(l+r) div 2];
         repeat
           while (e[i]<x) or ((e[i]=x) and (s[i]>tx)) do
            inc(i);
           while (x<e[j]) or ((e[j]=x) and (tx>s[j])) do
            dec(j);
           if not(i>j) then
             begin
                y:=e[i];
                e[i]:=e[j];
                e[j]:=y;
                y:=s[i];
                s[i]:=s[j];
                s[j]:=y;
                y:=w[i];
                w[i]:=w[j];
                w[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;

procedure build(x,l,r:longint);
 var mid:longint;
begin
 ll[x]:=l;
 rr[x]:=r;
 if l=r then
    begin
      a[x]:=c;
      tag[x]:=0;
      exit;
    end;
 mid:=(ll[x]+rr[x]) shr 1;
 build(2*x,l,mid);
 build(2*x+1,mid+1,r);
 a[x]:=c;
 tag[x]:=0;
end;

procedure update(x:longint);
begin
 if ll[x]=rr[x] then exit;
 inc(tag[2*x],tag[x]);
 inc(a[2*x],tag[x]);
 inc(tag[2*x+1],tag[x]);
 inc(a[2*x+1],tag[x]);
 tag[x]:=0;
end;

procedure modify(x,l,r,d:longint);
 var mid:longint;
begin
 update(x);
 if (l<=ll[x]) and (rr[x]<=r) then
    begin
     inc(tag[x],d);
     inc(a[x],d);
     exit;
    end;
 mid:=(ll[x] + rr[x]) shr 1;
 if r<=mid then modify(2*x,l,r,d) else
 if mid+1<=l then modify(2*x+1,l,r,d) else
 begin
  modify(2*x,l,mid,d);
  modify(2*x+1,mid+1,r,d);
 end;
 a[x]:=min(a[2*x],a[2*x+1]);
end;

function query(x,l,r:longint):longint;
 var mid:longint;
begin
 update(x);
 if (l<=ll[x]) and (rr[x]<=r) then exit(a[x]);
 mid:=(ll[x]+rr[x]) shr 1;
 if r<=mid then exit(query(2*x,l,r));
 if mid+1<=l then exit(query(2*x+1,l,r));
 exit(min(query(2*x,l,mid),query(2*x+1,mid+1,r)));
end;

begin
assign(input,'shuttle.in');reset(input);
assign(output,'shuttle.out');rewrite(output);
 readln(k,n,c);
 for i:=1 to k do readln(s[i],e[i],w[i]);
 sort(1,k);
 ans:=0;
 build(1,1,n);
 for i:=1 to k do
   begin
    tmp:=query(1,s[i],e[i]-1);
    if tmp>w[i] then tmp:=w[i];
    inc(ans,tmp);
    modify(1,s[i],e[i]-1,-tmp);
   end;
 writeln(ans);
close(input);close(output);
end.

