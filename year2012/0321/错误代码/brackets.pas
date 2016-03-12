const maxlen=256; max=100;
type rec=record x,y:longint; end;
     node=record plus,multiply:boolean; end;
var ts,ps,qs:string;
    stack,belong,fu:array[0..maxlen]of longint;
    c,d:array[0..maxlen,0..maxlen,0..maxlen]of rec;
    f:array[0..maxlen,0..maxlen]of node;
    i,j,n:longint;
procedure work(l,r:longint);
var i,j,tot,tot2,tr,tl:longint;
    plus,multiply:boolean;
    a,b:array[0..maxlen]of rec;
begin
i:=l;
plus:=false; multiply:=false;
tot:=0;  tot2:=0;
tr:=r;
tl:=l;
if (belong[l]<>0)and(belong[l]=r) then
   begin
   inc(i);
   tl:=l+1;
   tr:=r-1;
   end;
while i<=tr do
  begin
  if belong[i]<>0 then begin i:=belong[i]+1; continue; end;
  if (ts[i]='+')or(ts[i]='-') then
     begin
     plus:=true;
     inc(tot); a[tot].x:=i; if ts[i]='+' then a[tot].y:=1 else a[tot].y:=2;
     end;
  if (ts[i]='*')or(ts[i]='/') then
     begin
     multiply:=true;
     inc(tot2); b[tot2].x:=i; if ts[i]='*' then b[tot2].y:=1 else b[tot2].y:=2;
     end;
  inc(i);
  end;
if plus then begin inc(tot); a[tot].x:=tr+1; a[tot].y:=1; end;
if multiply then begin inc(tot2); b[tot2].x:=tr+1; b[tot2].y:=1; end;
a[0].x:=tot; b[0].x:=tot2;
c[l][r][0].x:=tot; d[l][r][0].x:=tot2;
for i:=1 to tot do begin c[l][r][i].x:=a[i].x; c[l][r][i].y:=a[i].y; end;
for i:=1 to tot2 do begin d[l][r][i].x:=b[i].x; d[l][r][i].y:=b[i].y; end;
f[l][r].plus:=plus; f[l][r].multiply:=multiply;
if plus then
   begin
   for i:=1 to tot do
       begin
       if i=1 then
          begin
          work(tl,a[i].x-1);
          end
       else work(a[i-1].x+1,a[i].x-1);
       if (i>1)and((belong[a[i-1].x+1]<>0)and(belong[a[i-1].x+1]=a[i].x-1)) then
          begin
          if (a[i-1].y=1)or((a[i-1].y=2)and(not f[a[i-1].x+1][a[i].x-1].plus)) then
              begin
              fu[a[i-1].x+1]:=0;
              fu[a[i].x-1]:=0;
              end;
          end;
       if (i=1)and((belong[tl]<>0)and(belong[tl]=a[i].x-1)) then
          begin
          fu[tl]:=0;
          fu[a[i].x-1]:=0;
          end;
       if (i>1)and(a[i-1].y=2) then
          begin
          if f[a[i-1].x+1][a[i].x-1].plus then
             begin
{             for j:=a[i-1].x+1 to a[i].x-1 do
                 if (fu[j]=1)or(fu[j]=2) then
                    fu[j]:=3-fu[j];}
             for j:=1 to c[a[i-1].x+1][a[i].x-1][0].x-1 do
                 begin
                 fu[c[a[i-1].x+1][a[i].x-1][j].x]:=3-fu[c[a[i-1].x+1][a[i].x-1][j].x];
                 end;
              fu[a[i-1].x+1]:=0;
              fu[a[i].x-1]:=0;
             end;
          end;
       end;
   end
else
   begin
   for i:=1 to tot2 do
       begin
       if i=1 then
          begin
          work(tl,b[i].x-1);
          end
       else work(b[i-1].x+1,b[i].x-1);
       if (i>1)and((belong[b[i-1].x+1]<>0)and(belong[b[i-1].x+1]=b[i].x-1)) then
          begin
          if (b[i-1].y=1)and(not f[b[i-1].x+1][b[i].x-1].plus) then
             begin
             fu[b[i-1].x+1]:=0;
             fu[b[i].x-1]:=0;
             end;
          if (b[i-1].y=2)and((not f[b[i-1].x+1][b[i].x-1].plus)and(not f[b[i-1].x+1][b[i].x-1].multiply)) then
             begin
             fu[b[i-1].x+1]:=0;
             fu[b[i].x-1]:=0;
             end;
          if (b[i-1].y=2)and((not f[b[i-1].x+1][b[i].x-1].plus)and(f[b[i-1].x+1][b[i].x-1].multiply)) then
             begin
             for j:=1 to d[b[i-1].x+1][b[i].x-1][0].x-1 do
                 begin
                 fu[d[b[i-1].x+1][b[i].x-1][j].x]:=7-fu[d[b[i-1].x+1][b[i].x-1][j].x];
                 end;
{             for j:=b[i-1].x+1 to b[i].x-1 do
                 if (fu[j]=3)or(fu[j]=4) then fu[j]:=7-fu[j];}
             fu[b[i-1].x+1]:=0;
             fu[b[i].x-1]:=0;
             end;
          end;
       if (i=1)and(belong[tl]=b[i].x-1) then
          begin
          if not f[tl][b[i].x-1].plus then
             begin
             fu[tl]:=0;
             fu[b[i].x-1]:=0;
             end;
          end;
       end;
   end;
end;
procedure init;
begin
fillchar(belong,sizeof(belong),0);

fillchar(fu,sizeof(fu),0);
fillchar(f,sizeof(f),false);
end;
procedure solve;
var i,top:longint;
begin
init;
top:=0;
for i:=1 to length(ts) do
    begin
    if ts[i]='(' then
       begin
       inc(top);
       stack[top]:=i;
       fu[i]:=-1; //(
       end
    else if ts[i]=')' then
            begin
            belong[stack[top]]:=i; //( )match
            belong[i]:=stack[top];
            fu[i]:=-2; //)
            dec(top);
            end
         else if ts[i]='+' then
                 begin
                 fu[i]:=1
                 end
              else if ts[i]='-' then
                      begin
                      fu[i]:=2;
                      end
                   else if ts[i]='*' then
                           begin
                           fu[i]:=3;
                           end
                        else if ts[i]='/' then
                                begin
                                fu[i]:=4;
                                end;
    end;
work(1,length(ts));
if (belong[1]<>0)and(belong[1]=length(ts)) then
   begin
   fu[1]:=0;
   fu[length(ts)]:=0;
   end;
end;
procedure print;
var i:longint;
begin
ps:='';
for i:=1 to length(ts) do
    begin
    if (ord(ts[i])>=ord('a'))and(ord(ts[i])<=ord('z')) then
       begin
       //write(ts[i]);
       ps:=ps+ts[i];
       end
    else if belong[i]<>0 then
            begin
            if fu[i]<>0 then
               begin
               //write(ts[i]);
               ps:=ps+ts[i];
               end;
            end
         else if (ts[i]='+')or(ts[i]='-') then
                 begin
                 if fu[i]=1 then
                    begin
                    //write('+');
                    ps:=ps+'+';
                    end
                 else
                    begin
                    //write('-');
                    ps:=ps+'-';
                    end;
                 end
              else if (ts[i]='*')or(ts[i]='/') then
                      begin
                     //write(ts[i]);
                      if fu[i]=3 then
                         ps:=ps+'*'
                      else
                         ps:=ps+'/';
                      end;
    end;
//writeln;
ts:=ps;
end;
begin
assign(input,'brackets.in');
reset(input);
assign(output,'brackets.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(ts);
    for j:=1 to max do
        begin
        qs:=ts;
        solve;
        print;
        if ts=qs then
           break;
        end;
    writeln(ts);
    end;

close(input);
close(output);
end.

