type rec=record x:qword; y:longint; end;
var l,r:qword;
    need:longint;
    pow:array[0..25]of qword;
    map:array[0..19,0..171,0..1111]of boolean;
    f:array[0..19,0..171,0..1111]of rec;
    ans:rec;
operator +(a,b:rec) c:rec;
begin
c.x:=a.x+b.x; c.y:=b.y;
end;
procedure init;
var i:longint;
begin
pow[0]:=1;
for i:=1 to 19 do pow[i]:=pow[i-1]*qword(10);
end;
function dp(h,acc,remain:longint):rec;  // the height of the tree is h;
var i:longint; ret:rec;
begin
if map[h][acc][remain] then dp:=f[h][acc][remain]
   else begin
        map[h][acc][remain]:=true;
        if h=0 then
           begin
           if remain=0 then begin ret.x:=1; if acc>=need then ret.y:=0 else ret.y:=need-acc; end
              else begin ret.x:=0; if remain>acc then ret.y:=remain-acc else ret.y:=0; end;
           f[h][acc][remain]:=ret;
           dp:=ret;
           end
        else
           begin
           ret.x:=0; ret.y:=remain;
           for i:=0 to 9 do ret:=ret+dp(h-1,acc+i,ret.y);
           f[h][acc][remain]:=ret;
           dp:=ret;
           end;
        end;
end;
function calc(l,r:qword):rec;
var savel,saver:qword; suml,h,i,j,t:longint; ret:rec;
begin
savel:=l; saver:=r;
h:=-1; suml:=0;
for i:=18 downto 0 do
    begin
    if (h=-1)and(l div pow[i]<>r div pow[i]) then h:=i;
    suml:=suml+l div pow[i];
    l:=l mod pow[i]; r:=r mod pow[i];
    end;
if savel=saver then
   begin
   ret.x:=1; if suml>=need then ret.y:=0 else ret.y:=need-suml;
   calc:=ret;
   end
else
   begin
   ret.x:=0; ret.y:=0;
   l:=savel; r:=saver;
   ret.x:=1;
   if suml>=need then ret.y:=0 else ret.y:=need-suml;  //calculate l
   for i:=0 to h-1 do
       begin
       suml:=suml-(l mod pow[i+1]) div pow[i];
       for j:=(l mod pow[i+1]) div pow[i]+1 to 9 do ret:=ret+dp(i,suml+j,ret.y);
       end;
   suml:=suml-(l mod pow[h+1]) div pow[h];
   for i:=(l mod pow[h+1]) div pow[h]+1 to (r mod pow[h+1]) div pow[h]-1 do ret:=ret+dp(h,suml+i,ret.y);
   for i:=h-1 downto 0 do
       begin
       suml:=suml+(r mod pow[i+2]) div pow[i+1];
       t:=(r mod pow[i+1]) div pow[i];
       t:=t-1;
       for j:=0 to t do
           ret:=ret+dp(i,suml+j,ret.y);
       end;
   ret:=ret+dp(0,suml+r mod 10,ret.y);
   calc:=ret;
   end;
end;
begin
{assign(input,'tickets.in');
reset(input);
assign(output,'tickets.out');
rewrite(output);}
init;
readln(l,r,need);
ans:=calc(l,r);
if ans.y>0 then dec(ans.x);
writeln(ans.x);
{close(input);
close(output);}
end.