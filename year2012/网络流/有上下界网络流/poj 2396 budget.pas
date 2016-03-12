//21:08;
const maxr=300; maxc=50; inf=maxlongint;
type newtype=record u,v,ll,rr:longint; end;
     rec=record u,v,c,op,nxt:longint; end;
var test,now,s,t,n,m,x,y,z,i,j,sumr,sumc,opt,flag,tmp,len,dir,cnt,tot,ans,ss,tt,left,right:longint;
    row,col,edge,h,hash2,q,inner,outer,rowl,rowr,coll,colr:array[0..maxr]of longint;
    a:array[0..maxr*maxc*2]of newtype;
    bel,hash,b:array[0..maxr,0..maxc]of longint;
    g:array[0..maxr*maxc*2]of rec;
    code:integer;
    ts,s1:string;
    ch:char;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].c:=z; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].c:=0; g[tot].op:=tot-1;
end;
function flow(x,now:longint):longint;
var tmp,p,res,mmin:longint;
begin
if x=tt then exit(now);
tmp:=0;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(g[p].c,now));
     now:=now-res; tmp:=tmp+res;
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     if h[ss]=n+m+4 then exit(tmp);
     if now=0 then break;
     end;
  p:=g[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash2[h[x]]);
   if hash2[h[x]]=0 then h[ss]:=n+m+4
      else begin
           mmin:=n+m+3;
           p:=edge[x];
           while p<>0 do
             begin
             if (g[p].c>0)and(h[g[p].v]<mmin) then mmin:=h[g[p].v];
             p:=g[p].nxt;
             end;
           h[x]:=mmin+1;
           inc(hash2[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure sap;
var i,head,tail,p:longint;
begin
fillchar(hash2,sizeof(hash2),0);
for i:=0 to n+m+3 do h[i]:=n+m+4;
head:=1; tail:=1; q[1]:=tt; h[tt]:=0;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=n+m+4) then
       begin
       inc(tail); q[tail]:=g[p].v;
       h[g[p].v]:=h[q[head]]+1;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=0 to n+m+3 do inc(hash2[h[i]]);
while h[ss]<n+m+4 do ans:=ans+flow(ss,inf);
end;
procedure work;
var p,i,j:longint;
begin
p:=edge[ss];
while p<>0 do
  begin
  if (g[p].c>0) then begin writeln('IMPOSSIBLE'); exit; end;
  p:=g[p].nxt;
  end;
for i:=1 to n do
    begin
    p:=edge[i];
    while p<>0 do
      begin
      j:=g[p].v-n;
      if j>0 then b[i][j]:=a[hash[i][j]].rr-g[p].c;
      p:=g[p].nxt;
      end;
    end;
for i:=1 to n do
    begin
    for j:=1 to m-1 do write(b[i][j],' ');
    write(b[i][m],' ');
    writeln;
    end;
end;
procedure init;
var i:longint;
begin
cnt:=0; sumr:=0; sumc:=0; tot:=0; ans:=0;
fillchar(inner,sizeof(inner),0);
fillchar(outer,sizeof(outer),0);
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
fillchar(a,sizeof(a),0);
for i:=1 to n do begin rowl[i]:=0; rowr[i]:=inf; end;
for i:=1 to m do begin coll[i]:=0; colr[i]:=inf; end;
left:=0; right:=inf;
//fillchar(row,sizeof(row),0);
//fillchar(col,sizeof(col),0);
//fillchar(hash,sizeof(hash),0);
end;
begin
{assign(input,'budget.in');
reset(input);
assign(output,'budget.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    if now>1 then writeln;
    read(n,m);
    readln;
    s:=0; t:=n+m+1;
    init;
    for i:=1 to n do
        begin
        read(x);
        inc(cnt);
        a[cnt].u:=s; a[cnt].v:=i; a[cnt].ll:=x; a[cnt].rr:=x;
        row[i]:=x; sumr:=sumr+x;
        end;
    readln;
    for i:=1 to m do
        begin
        read(x);
        inc(cnt);
        a[cnt].u:=i+n; a[cnt].v:=t; a[cnt].ll:=x; a[cnt].rr:=x;
        col[i]:=x; sumc:=sumc+x;
        end;
    readln;
    readln(opt);
    flag:=1;
    for i:=1 to opt do
        begin
        read(x,y);
        read(ch);
        while (ch<>'>')and(ch<>'<')and(ch<>'=') do read(ch);
        read(z);
        readln;
        if (x=0)and(y=0) then
           begin
           if ch='>' then left:=max(left,z+1);
           if ch='=' then begin left:=max(left,z); right:=min(right,z); end;
           if ch='<' then right:=min(right,z-1);
           if left>right then flag:=0;
           end
        else if (x=0)and(y<>0) then
                begin
                if ch='>' then begin coll[y]:=max(coll[y],z+1); if coll[y]>colr[y] then flag:=0; end;
                if ch='=' then begin coll[y]:=max(coll[y],z); colr[y]:=min(colr[y],z); if coll[y]>colr[y] then flag:=0; end;
                if ch='<' then begin colr[y]:=min(colr[y],z-1); if coll[y]>colr[y] then flag:=0; end;
                end
             else if (x<>0)and(y=0) then
                     begin
                     if ch='>' then begin rowl[x]:=max(rowl[x],z+1); if rowl[x]>rowr[x] then flag:=0; end;
                     if ch='=' then begin rowl[x]:=max(rowl[x],z); rowr[x]:=min(rowr[x],z); if rowl[x]>rowr[x] then flag:=0; end;
                     if ch='<' then begin rowr[x]:=min(rowr[x],z-1); if rowl[x]>rowr[x] then flag:=0; end;
                     end
                  else begin
                       if bel[x][y]<>now then
                          begin
                          inc(cnt); bel[x][y]:=now; hash[x][y]:=cnt; // a[cnt].u=x a[cnt].v:=y;
                          a[cnt].u:=x; a[cnt].v:=y+n;
                          if ch='>' then begin a[cnt].ll:=max(z+1,0); a[cnt].rr:=inf; end;
                          if ch='=' then begin a[cnt].ll:=z; a[cnt].rr:=z; if z<0 then flag:=0; end;
                          if ch='<' then begin a[cnt].ll:=0; a[cnt].rr:=z-1; if z-1<0 then flag:=0; end;
                          end
                       else
                          begin
                          dir:=hash[x][y];
                          if ch='>' then begin a[dir].ll:=max(a[dir].ll,z+1); if a[dir].ll>a[dir].rr then flag:=0; end;
                          if ch='=' then begin a[dir].ll:=max(a[dir].ll,z); a[dir].rr:=min(a[dir].rr,z); if a[dir].ll>a[dir].rr then flag:=0; end;
                          if ch='<' then begin a[dir].rr:=min(a[dir].rr,z-1); if a[dir].ll>a[dir].rr then flag:=0; end;
                          end;
                       end;
        end;
    if (sumr<>sumc)or(flag=0) then begin writeln('IMPOSSIBLE'); continue; end;
    inc(cnt); a[cnt].u:=t; a[cnt].v:=s; a[cnt].ll:=0; a[cnt].rr:=inf;
    flag:=1;
    if now=21 then
       flag:=flag;
    for i:=1 to n do
        begin
        if not((rowl[i]=0)and(rowr[i]=inf)) then
           begin
           for j:=1 to m do
               begin
               if bel[i][j]<>now then
                  begin
                  inc(cnt); bel[i][j]:=now; hash[i][j]:=cnt;
                  a[cnt].u:=i; a[cnt].v:=j+n;
                  a[cnt].ll:=rowl[i]; a[cnt].rr:=rowr[i];
                  end
               else
                  begin
                  dir:=hash[i][j];
                  a[dir].ll:=max(a[dir].ll,rowl[i]); a[dir].rr:=min(a[dir].rr,rowr[i]);
                  if a[dir].ll>a[dir].rr then flag:=0;
                  end;
               end;
           end;
        end;
    if flag=0 then begin writeln('IMPOSSIBLE'); continue; end;
    flag:=1;
    for j:=1 to m do
        begin
        if not((coll[j]=0)and(colr[j]=inf)) then
           begin
           for i:=1 to n do
               begin
               if bel[i][j]<>now then
                  begin
                  inc(cnt); bel[i][j]:=now; hash[i][j]:=cnt;
                  a[cnt].u:=i; a[cnt].v:=j+n;
                  a[cnt].ll:=coll[j]; a[cnt].rr:=colr[j];
                  end
               else
                  begin
                  dir:=hash[i][j];
                  a[dir].ll:=max(a[dir].ll,coll[j]); a[dir].rr:=min(a[dir].rr,colr[j]);
                  if a[dir].ll>a[dir].rr then flag:=0;
                  end;
               end;
           end;
        end;
    if flag=0 then begin writeln('IMPOSSIBLE'); continue; end;
    flag:=1;
    if not((left=0)and(right=inf)) then
       begin
       for i:=1 to n do
           for j:=1 to m do
               begin
               if bel[i][j]<>now then
                  begin
                  inc(cnt); bel[i][j]:=now; hash[i][j]:=cnt;
                  a[cnt].u:=i; a[cnt].v:=j+n;
                  a[cnt].ll:=left; a[cnt].rr:=right;
                  end
               else
                  begin
                  dir:=hash[i][j];
                  a[dir].ll:=max(a[dir].ll,left); a[dir].rr:=min(a[dir].rr,right);
                  if a[dir].ll>a[dir].rr then flag:=0;
                  end;
               end;
       end;
    if flag=0 then begin writeln('IMPOSSIBLE'); continue; end;
    for i:=1 to n do
        for j:=1 to m do
            if bel[i][j]<>now then
               begin
               inc(cnt); a[cnt].u:=i; a[cnt].v:=j+n; a[cnt].ll:=0; a[cnt].rr:=inf;
               hash[i][j]:=cnt;
               end;
    for i:=1 to cnt do
        begin
        inc(inner[a[i].v],a[i].ll);
        inc(outer[a[i].u],a[i].ll);
        end;
    ss:=n+m+2; tt:=n+m+3;
    for i:=s to t do
        begin
        if inner[i]-outer[i]>0 then addedge(ss,i,inner[i]-outer[i]);
        if inner[i]-outer[i]<0 then addedge(i,tt,outer[i]-inner[i]);
        end;
    for i:=1 to cnt do addedge(a[i].u,a[i].v,a[i].rr-a[i].ll);
    addedge(tt,ss,inf);
    sap;
    work;
    end;
{close(input);
close(output);}
end.