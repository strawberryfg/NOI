type arr=array[0..1000] of longint;
var c,p,ta,tb,pos:arr;
    t:array[1..100,1..200] of longint;
    a:array[1..1000] of arr;
    n,m,i,j,k,tk,tt,cnt,ans,tmp,over,time,t1,t2:longint;

procedure sort(l,r: longint; var c:arr);
 var i,j,x,y: longint;
begin
         i:=l;
         j:=r;
         x:=t[c[(l+r) shr 1],over];
         repeat
           while t[c[i],over]<x do
            inc(i);
           while x<t[c[j],over] do
            dec(j);
           if not(i>j) then
             begin
                y:=c[i];
                c[i]:=c[j];
                c[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then sort(l,j,c);
         if i<r then sort(i,r,c);
end;

function calc:longint;
 var i,j,sum:longint;
begin
 sum:=0;
 for i:=1 to m do
   for j:=1 to a[i,0] do sum:=sum+t[a[i,j],i]*(a[i,0]-j+1);
 exit(sum);
end;

begin
assign(input,'delicacy.in');reset(input);
assign(output,'delicacy.out');rewrite(output);
 randomize;
 readln(n,m);
 for i:=1 to n do read(p[i]); readln;
 for i:=1 to n do
   begin
    for j:=1 to m do read(t[i,j]);
    readln;
   end;
 if m=1 then
    begin
      cnt:=0;
      for i:=1 to n do
        for j:=1 to p[i] do
          begin
            inc(cnt);
            c[cnt]:=i;
          end;
      over:=1;
      sort(1,cnt,c);
      ans:=0;
      for i:=1 to cnt do ans:=ans+c[i]*(cnt-i+1);
      writeln(ans);
    end else
 begin
      cnt:=0;
      for i:=1 to n do
        for j:=1 to p[i] do
          begin
            inc(cnt);
            c[cnt]:=i;
          end;
   for i:=1 to cnt do
     begin
       for j:=1 to m do
         if (k=0) or (t[c[i],j]<t[c[i],k]) then k:=j;
       inc(a[k,0]); a[k,a[k,0]]:=c[i];
       pos[i]:=k;
     end;
   for i:=1 to m do
    if a[i,0]>0 then
     begin
       over:=i;
       sort(1,a[i,0],a[i]);
     end;
   ans:=calc;
   for i:=1 to 10000 do
     begin
       tk:=random(cnt)+1;
       k:=pos[tk];
       ta:=a[k];
       for j:=1 to a[k,0] do
         if a[k,j]=c[k] then
              begin
                a[k,j]:=a[k,a[k,0]];
                dec(a[k,0]);
                break;
              end;
       sort(1,a[k,0],a[k]);
       tt:=random(m)+1; while k=tt do tt:=random(m)+1;
       pos[tk]:=tt;
       tb:=a[tt];
       inc(a[tt,0]); a[tt,a[tt,0]]:=c[k];
       sort(1,a[tt,0],a[tt]);
       tmp:=calc;
       if (tmp<ans) then ans:=tmp
          else begin
                 a[k]:=ta; a[tt]:=tb;
                 pos[tk]:=k;
               end;
     end;
 t1:=30; t2:=1000;
 if cnt<=10 then begin t1:=1000; t2:=200; end;
 for time:=1 to t1 do
  begin
   for i:=1 to m do a[i,0]:=0;
   for i:=1 to cnt do
     begin
       k:=random(m)+1;
       pos[i]:=k;
       inc(a[k,0]); a[k,a[k,0]]:=c[i];
     end;
   for i:=1 to m do
    if a[i,0]>0 then
     begin
       over:=i;
       sort(1,a[i,0],a[i]);
     end;
   tmp:=calc; if tmp<ans then ans:=tmp;
   for i:=1 to t2 do
     begin
       tk:=random(cnt)+1;
       k:=pos[tk];
       ta:=a[k];
       for j:=1 to a[k,0] do
         if a[k,j]=c[k] then
              begin
                a[k,j]:=a[k,a[k,0]];
                dec(a[k,0]);
                break;
              end;
       sort(1,a[k,0],a[k]);
       tt:=random(m)+1; while k=tt do tt:=random(m)+1;
       pos[tk]:=tt;
       tb:=a[tt];
       inc(a[tt,0]); a[tt,a[tt,0]]:=c[k];
       sort(1,a[tt,0],a[tt]);
       tmp:=calc;
       if (tmp<ans) then ans:=tmp
          else begin
                 a[k]:=ta; a[tt]:=tb;
                 pos[tk]:=k;
               end;
     end;
   end;
   writeln(ans);
 end;
close(input);close(output);
end.
