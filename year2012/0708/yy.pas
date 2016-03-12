const maxn=261111; inf=maxlongint div 2;
type rec=record u,v,nxt,w:longint; end;
var test,now,i,n,m,x,y,v,ans,tot,root:longint;
    edge,fmax,gmax:array[0..maxn]of longint;
    g:array[0..2*maxn]of rec;
    ret:array[1..2]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure init;
begin
tot:=0; fillchar(edge,sizeof(edge),0);
end;
procedure cmax(var x:longint; y:longint);
begin
if y>x then x:=y;
end;
procedure dfs(x,fa,value,opt:longint);
var p,pd,max1,max2,max3,num1,num2,num3,nownum1,nownum2,nowmax1,nowmax2:longint;
begin
p:=edge[x]; max1:=-inf; max2:=-inf; max3:=-inf; pd:=0;
nowmax1:=-inf; nowmax2:=-inf; gmax[x]:=-inf; num1:=-1; num2:=-1; num3:=-1; nownum1:=-1; nownum2:=-1;
while p<>0 do
  begin
  if (g[p].v<>fa) then
     begin
     pd:=1;
     dfs(g[p].v,x,value+g[p].w,opt);
     if gmax[g[p].v]<>-inf then cmax(gmax[x],gmax[g[p].v]+g[p].w);
     if fmax[g[p].v]+g[p].w>max1 then begin num3:=num2; max3:=max2; num2:=num1; max2:=max1; num1:=g[p].v; max1:=fmax[g[p].v]+g[p].w; end
        else if fmax[g[p].v]+g[p].w>max2 then begin num3:=num2; max3:=max2; num2:=g[p].v; max2:=fmax[g[p].v]+g[p].w; end
                else if fmax[g[p].v]+g[p].w>max3 then begin num3:=g[p].v; max3:=fmax[g[p].v]+g[p].w; end;
     if gmax[g[p].v]<>-inf then
        begin
        if gmax[g[p].v]+g[p].w>nowmax1 then begin nownum2:=nownum1; nowmax2:=nowmax1; nownum1:=g[p].v; nowmax1:=gmax[g[p].v]+g[p].w; end
           else if gmax[g[p].v]+g[p].w>nowmax2 then begin nownum2:=g[p].v; nowmax2:=gmax[g[p].v]+g[p].w; end;
        end;
     end;
  p:=g[p].nxt;
  end;
if pd=0 then begin fmax[x]:=0; exit; end else fmax[x]:=max1;
if (max2<>-inf)and(x<>root) then cmax(ret[opt],max1+max2+value);
if max3<>-inf then cmax(ret[opt],max1+max2+max3);
if (nowmax1<>-inf)and(max1<>-inf) then
   begin
   if num1<>nownum1 then cmax(ret[opt],nowmax1+max1)
      else begin
           if max2<>-inf then cmax(ret[opt],nowmax1+max2);
           if nowmax2<>-inf then cmax(ret[opt],nowmax2+max1);
           end;
   end;
if max2<>-inf then cmax(gmax[x],max1+max2);
end;
begin
assign(input,'yy.in');
reset(input);
assign(output,'yy.out');
rewrite(output);
read(test);
for now:=1 to test do
    begin
    init;
    read(n,m);
    for i:=1 to m do
        begin
        read(x,y,v);
        addedge(x,y,v);
        addedge(y,x,v);
        end;
    ans:=-inf;
    for i:=1 to m do
        begin
        ret[1]:=-inf;
        root:=g[2*i-1].u;
        dfs(g[2*i-1].u,g[2*i-1].v,0,1);
        ret[2]:=-inf;
        root:=g[2*i-1].v;
        dfs(g[2*i-1].v,g[2*i-1].u,0,2);
        if (ret[1]<>-inf)and(ret[2]<>-inf) then cmax(ans,ret[1]+ret[2]);
        end;
    if ans=-inf then writeln('POOR BB') else writeln(ans);
    end;
close(input);
close(output);
end.