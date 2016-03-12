{$inline on}
type
pointer=^atype;
atype=record
        left,right,parent:pointer;
        max,lmax,rmax,sum,size,data:longint;
      end;

var
totalnum:longint;
root,super_root,temp:pointer;
d:array[0..200010] of longint;
n,i,x,y:longint;
ch:char;

function max2(x,y:longint):longint inline;
begin if x>y then exit(x) else exit(y);end;

function max3(x,y,z:longint):longint inline;
var res:longint;
begin res:=x;
      if y>res then res:=y;
      if z>res then exit(z) else exit(res);
end;

function Create(dt:longint):pointer;
var temp:pointer;
begin new(temp);
      with temp^ do
      begin left:=nil;
            right:=nil;
            parent:=nil;
            max:=dt;
            lmax:=dt;
            rmax:=dt;
            sum:=dt;
            data:=dt;
            size:=1;
      end;
      exit(temp);
end;

procedure Update(x:pointer);
begin with x^ do
      begin if (left=nil)and(right=nil) then
            begin max:=data;
                  lmax:=data;
                  rmax:=data;
                  sum:=data;
                  size:=1;
                  exit;
            end;
            if left=nil then
            begin sum:=right^.sum+data;
                  lmax:=max2(data+right^.lmax,data);
                  rmax:=max2(right^.rmax,right^.sum+data);
                  max:=max3(data,right^.max,data+right^.lmax);
                  size:=right^.size+1;
                  exit;
            end;
            if right=nil then
            begin sum:=left^.sum+data;
                  lmax:=max2(left^.lmax,left^.sum+data);
                  rmax:=max2(left^.rmax+data,data);
                  max:=max3(left^.max,data,left^.rmax+data);
                  size:=left^.size+1;
                  exit;
            end;
            sum:=left^.sum+right^.sum+data;
            lmax:=max3(left^.lmax,left^.sum+data,left^.sum+data+right^.lmax);
            rmax:=max3(right^.rmax,right^.sum+data,right^.sum+data+left^.rmax);
            max:=max3(max3(left^.max,right^.max,data),
                      max2(left^.rmax+data,right^.lmax+data),
                      left^.rmax+data+right^.lmax);
            size:=left^.size+right^.size+1;
      end;
end;

function Build(bg,ed:longint):pointer;
var mid:longint;
    res:pointer;
begin if bg=ed then exit(Create(d[bg]));
      mid:=(bg+ed) shr 1;
      res:=Create(d[mid]);
      if bg<mid then
      begin res^.left:=Build(bg,mid-1);
            res^.left^.parent:=res;
      end;
      if ed>mid then
      begin res^.right:=Build(mid+1,ed);
            res^.right^.parent:=res;
      end;
      Update(res);
      exit(res);
end;

procedure LeftRotate(x:pointer);
var y:pointer;
begin y:=x^.parent;
      y^.right:=x^.left;
      if x^.left<>nil then x^.left^.parent:=y;
      x^.parent:=y^.parent;
      if y^.parent<>super_root then
        if y=y^.parent^.left then
          y^.parent^.left:=x
        else y^.parent^.right:=x;
      x^.left:=y;
      y^.parent:=x;
      Update(y);
      Update(x);
end;

procedure RightRotate(x:pointer);
var y:pointer;
begin y:=x^.parent;
      y^.left:=x^.right;
      if x^.right<>nil then x^.right^.parent:=y;
      x^.parent:=y^.parent;
      if y^.parent<>super_root then
        if y=y^.parent^.left then
          y^.parent^.left:=x
        else y^.parent^.right:=x;
      x^.right:=y;
      y^.parent:=x;
      Update(y);
      Update(x);
end;

procedure Splay(x,y:pointer);
begin if x=y then exit;
      while x^.parent<>y do
        if x^.parent^.parent=y then
          if x=x^.parent^.left then
            RightRotate(x)
          else LeftRotate(x)
        else if x^.parent^.parent^.left=x^.parent then
               if x^.parent^.left=x then
               begin RightRotate(x^.parent);
                     RightRotate(x);
                end
               else begin
                     LeftRotate(x);
                     RightRotate(x);
               end
             else if x^.parent^.left=x then
                  begin RightRotate(x);
                        LeftRotate(x);
                   end
                  else begin
                        LeftRotate(x^.parent);
                        LeftRotate(x);
                  end;

      if y=super_root then root:=x;
end;

function Getk(v:longint):pointer;
var x:pointer;
begin x:=root;
      while true do
      begin if x^.left=nil then
            begin if v=1 then break;
                  v:=v-1;
                  x:=x^.right;
                  continue;
            end;
            if v=x^.left^.size+1 then break;
            if v<=x^.left^.size then
              x:=x^.left
            else begin
                  v:=v-x^.left^.size-1;
                  x:=x^.right;
            end;
      end;

      Splay(x,super_root);
      exit(x);
end;

procedure Delete(v:pointer);
var y,z:pointer;
begin Splay(v,super_root);
      y:=v^.left;
      if y<>nil then
        while y^.right<>nil do y:=y^.right;

      z:=v^.right;
      if z<>nil then
        while z^.left<>nil do z:=z^.left;

      if y=nil then
      begin Splay(z,super_root);
            z^.left:=nil;
            dec(totalnum);
            exit;
      end;
      if z=nil then
      begin Splay(y,super_root);
            y^.right:=nil;
            dec(totalnum);
            exit;
      end;
      Splay(y,super_root);
      Splay(z,y);
      z^.left:=nil;
      Update(z);
      Update(y);
      dec(totalnum);
end;

procedure insert(p,v:longint);
var temp:pointer;
begin if p=1 then
      begin Splay(Getk(p),super_root);
            root^.left:=Create(v);
            root^.left^.parent:=root;
            Update(root);
            inc(totalnum);
            exit;
      end;
      if p>totalnum then
      begin Splay(Getk(p-1),super_root);
            root^.right:=Create(v);
            root^.right^.parent:=root;
            Update(root);
            inc(totalnum);
            exit;
      end;
      temp:=Getk(p);
      Splay(Getk(p-1),super_root);
      Splay(temp,root);
      root^.right^.left:=Create(v);
      root^.right^.left^.parent:=root^.right;
      Update(root^.right);
      Update(root);
      inc(totalnum);
end;

procedure del(p:longint);
begin Delete(Getk(p));end;

procedure replace(p,v:longint);
begin del(p);
      insert(p,v);
end;

procedure Query(bg,ed:longint);
var temp:pointer;
begin if ed<>totalnum then temp:=Getk(ed+1);
      if bg<>1 then Splay(Getk(bg-1),super_root);
      if ed<>totalnum then
        if bg<>1 then
        begin Splay(temp,root);
              writeln(root^.right^.left^.max);
              exit;
         end
        else begin
              Splay(temp,super_root);
              writeln(root^.left^.max);
              exit;
        end
      else if bg<>1 then
           begin writeln(root^.right^.max);
                 exit;
            end
           else writeln(root^.max);
end;

begin
readln(n);
totalnum:=n;
for i:=1 to n do read(d[i]);
new(super_root);
with super_root^ do
begin max:=0;
      sum:=0;
      lmax:=0;
      rmax:=0;
end;
root:=Build(1,n);
root^.parent:=super_root;
readln(n);
for i:=1 to n do
begin read(ch);
      if ch='I' then
      begin readln(x,y);
            insert(x,y);
      end;
      if ch='D' then
      begin readln(x);
            del(x);
      end;
      if ch='R' then
      begin readln(x,y);
            replace(x,y);
      end;
      if ch='Q' then
      begin readln(x,y);
            Query(x,y);
      end;
end;
end.




