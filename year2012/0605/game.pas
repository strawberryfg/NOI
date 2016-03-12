const fx:array[0..4,1..2]of longint=((0,0),(1,0),(-1,0),(0,1),(0,-1));
type node=record
       x,y:longint;
     end;
var role,ball:array[0..8]of node;
    del:array[0..8]of boolean;
    wall:array[0..5,0..5,0..5,0..5]of boolean;
    ans,n,m,w,i,j,x,y,test,stop:longint;
    find:boolean;
operator =(a,b:node)c:boolean;
begin
    c:=(a.x=b.x)and(a.y=b.y);
end;
function push(k:longint):longint;
var i,res:longint;
    check:boolean;
    p:node;
begin
    res:=0;
    for i:=1 to m do begin
        if del[i] then continue;
        p.x:=ball[i].x+fx[k,1];p.y:=ball[i].y+fx[k,2];
        if(p.x<0)or(p.x=n)or(p.y<0)or(p.y=n)then continue;
        if wall[ball[i].x,ball[i].y,p.x,p.y] then continue;
        check:=true;
        for j:=1 to m do begin
            if(i=j)or(del[j])then continue;
            if p=ball[j] then begin
               check:=false;
               break;
            end;
        end;
        if not check then continue;
        for j:=1 to m do begin
            if(i=j)or(del[j])then continue;
            if p=role[j] then exit(-1);
        end;
        res:=1;
        ball[i]:=p;
        if ball[i]=role[i] then begin
           del[i]:=true;
           inc(stop);
        end;
    end;
    exit(res);
end;
procedure dfs(r:longint);
var t,k,la:longint;
    tmp1,tmp2:array[0..8]of node;
    tmp3:array[0..8]of boolean;
begin
    if r>ans then begin
       if stop=m then find:=true;
       exit;
    end;
    la:=stop;tmp1:=ball;tmp2:=role;tmp3:=del;
    for k:=1 to 4 do begin
        stop:=la;ball:=tmp1;role:=tmp2;del:=tmp3;
        t:=push(k);
        while(t<>0)and(t<>-1)do t:=push(k);
        if t=-1 then continue;
        dfs(r+1);
    end;
    stop:=la;ball:=tmp1;role:=tmp2;del:=tmp3;
end;
begin
    assign(input,'game.in');
    assign(output,'game.out');
    reset(input);
    rewrite(output);
    for test:=1 to 2 do begin
        readln(n,m,w);
        fillchar(wall,sizeof(wall),0);
        for i:=1 to m do readln(ball[i].x,ball[i].y);
        for i:=1 to m do readln(role[i].x,role[i].y);
        for w:=1 to w do begin
            readln(i,j,x,y);
            wall[i,j,x,y]:=true;
            wall[x,y,i,j]:=true;
        end;
        stop:=0;
        fillchar(del,sizeof(del),0);
        if push(0)=-1 then begin
           writeln(-1);
           continue;
        end;
        find:=false;
        for ans:=0 to 8 do begin
            dfs(1);
            if find then break;
        end;
        if find then writeln(ans)else writeln(-1);
    end;
    close(input);
    close(output);
end.
