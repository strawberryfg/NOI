const dx:array[1..4]of longint=(-1,0,0,1);
      dy:array[1..4]of longint=(0,-1,1,0);
      maxn=100; inf=maxlongint;
type heaptype=record u,v:longint; end;
var test,i,n,m,j,k,tot,nowx,nowy,p,tx,ty,xx,yy,fmax,res:longint;
    a:array[0..maxn,0..maxn]of longint;
    f,bel1,bel2,hash:array[0..maxn,0..maxn]of longint;
    heap:array[0..maxn*maxn*10]of heaptype;
    ans:extended;
    ch:char;
procedure down(x:longint);
var t1,t2,tmp,num:longint; swap:heaptype;
begin
while x*2<=tot do
  begin
  t1:=f[heap[x*2].u][heap[x*2].v]; if x*2+1<=tot then t2:=f[heap[x*2+1].u][heap[x*2+1].v] else t2:=inf;
  if t1<t2 then num:=0 else num:=1;
  if f[heap[x].u][heap[x].v]>f[heap[x*2+num].u][heap[x*2+num].v] then
     begin
     tmp:=hash[heap[x].u][heap[x].v]; hash[heap[x].u][heap[x].v]:=hash[heap[x*2+num].u][heap[x*2+num].v]; hash[heap[x*2+num].u][heap[x*2+num].v]:=tmp;
     swap:=heap[x]; heap[x]:=heap[x*2+num]; heap[x*2+num]:=swap;
     x:=x*2+num;
     end
  else
     break;
  end;
end;
procedure up(x:longint);
var tmp:longint; swap:heaptype;
begin
while x>1 do
  begin
  if f[heap[x].u][heap[x].v]<f[heap[x div 2].u][heap[x div 2].v] then
     begin
     tmp:=hash[heap[x div 2].u][heap[x div 2].v]; hash[heap[x div 2].u][heap[x div 2].v]:=hash[heap[x].u][heap[x].v]; hash[heap[x].u][heap[x].v]:=tmp;
     swap:=heap[x div 2]; heap[x div 2]:=heap[x]; heap[x]:=swap;
     x:=x div 2;
     end
  else
     break;
  end;
end;
procedure insert(x,y:longint);
begin
inc(tot); heap[tot].u:=x; heap[tot].v:=y; hash[x][y]:=tot;
up(tot);
end;
procedure pop;
begin
if tot=0 then exit;
hash[heap[1].u][heap[1].v]:=0;
nowx:=heap[1].u; nowy:=heap[1].v;
heap[1]:=heap[tot]; heap[tot].u:=0; heap[tot].v:=0;
hash[heap[1].u][heap[1].v]:=1;
dec(tot);
down(1);
end;
begin
{assign(input,'sdalu.in');
reset(input);
assign(output,'sdalu.out');
rewrite(output);}
readln(test);
for i:=1 to test do
    begin
    readln(n,m);
    for j:=1 to n do
        begin
        for k:=1 to m do
            begin
            read(ch); a[j][k]:=ord(ch)-48;
            end;
        readln;
        end;
    fmax:=0;
    for j:=1 to n do
        for k:=1 to m do
            begin
            tot:=0;
            insert(j,k);
            for xx:=1 to n do
                for yy:=1 to m do
                    begin
                    f[xx][yy]:=inf;
                    hash[xx][yy]:=0;
                    end;
            f[j][k]:=a[j][k];
            while true do
              begin
              nowx:=-1; nowy:=-1;
              pop;
              if (nowx=-1)and(nowy=-1) then break;
              for p:=1 to 4 do
                  begin
                  tx:=nowx+dx[p]; ty:=nowy+dy[p];
                  if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(f[nowx][nowy]+a[tx][ty]<=4)and(f[nowx][nowy]+a[tx][ty]<f[tx][ty]) then
                     begin
                     if hash[tx][ty]=0 then
                        begin
                        f[tx][ty]:=f[nowx][nowy]+a[tx][ty];
                        insert(tx,ty);
                        end
                     else
                        begin
                        f[tx][ty]:=f[nowx][nowy]+a[tx][ty];
                        up(hash[tx][ty]);
                        end;
                     end
                  end;
              end;
            for xx:=1 to n do
                for yy:=1 to m do
                    begin
                    if (f[xx][yy]<>inf) then
                       begin
                       res:=(xx-j)*(xx-j)+(yy-k)*(yy-k);
                       if res>fmax then fmax:=res;
                       end;
                    end;
            res:=res;
            end;
    ans:=sqrt(fmax);
    writeln(round(ans*100000)/100000:0:5);
    end;
{close(input);
close(output);}
end.