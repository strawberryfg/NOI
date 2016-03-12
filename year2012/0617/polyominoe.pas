Const Max = 32; {设定N的最大值}
      delta : Array[1..4,1..2] of Shortint = ((0,1), (1,0), (0,-1), (-1,0)); {表示四个方向上的行列
                                                          增量的数组}
Type Tmap = Array[0.. Max div 2,-Max.. Max] Of Shortint; {这个数据结构表示了算法中构造
  的表的形式，但为了程序处理方便，在外面添了边框, 这样就不必判断出界；此外，为了处理上的简洁，首方块坐标定为（1，0），依此类推}
     Tinfo = Array[1..2* Max, 1..2] Of Shortint; {记录方块的坐标}
Var map : Tmap;
    blocks : Tinfo; {选取的小方块}
    f : Text;
    n, bottom : Shortint;
    paint : Boolean; {是否打印图案}
    ways : Longint; {方案总数}
Procedure Add(Var a : Tinfo; Var num : Shortint; x, y : Shortint); {添加小方块}
Begin Inc(num);     a[num, 1] := x;     a[num, 2] := y End;
Procedure Sort(Var blocks : Tinfo); {选择排序法, 在N很小时十分有效}
Var i, j, k, t, x, y : Shortint;
Begin
     For i := 1 To n-1 Do
       Begin
         k := i;      x := blocks[i,1];      y := blocks[i,2];
         For j := i+1 To n Do
           Begin
               If x > blocks[j,1] Then
                 Begin x := blocks[j,1]; y := blocks[j,2]; k := j End
               Else
                 If (x = blocks[j,1]) and (y > blocks[j,2])
                   Then Begin y := blocks[j,2]; k := j End
             End;
         If k <> i Then
           Begin
             t := blocks[i,1]; blocks[i,1] := blocks[k,1]; blocks[k,1] := t;
             t := blocks[i,2]; blocks[i,2] := blocks[k,2]; blocks[k,2] := t
           End
       End
End;
Procedure Init; {初始化}
Var i, j : Shortint;
    filename : String;
Begin
     Readln(n);
     filename:='polyominoe.out';
     Assign(output,filename);        Rewrite(output);
     If Abs(n) = n Then paint := True  {判断是否需要输出方案}
Else paint := False;
     n := Abs(n);       bottom := n; {bottom表示map需要的最大行数}
     map[1,0] := 1;
     blocks[1,1] := 1;  blocks[1,2] := 0; {放入第一个方块}
     {以下对map赋值，给所有不允许被访问的格子填上-1}
     For i := -Max To Max Do map[0,i] := -1;
//     For i := -Max To Max Do map[bottom +1,i] := -1;
     For i := 1 To bottom Do
       Begin
//         For j := -Max To i-n-1 Do map[i,j] := -1;
//         For j := n-i+1 To Max Do map[i,j] := -1
       End;
     For i := -Max To -1 Do map[1,i] := -1
End;
Procedure Out(temp : Tinfo; sizex, sizey : Shortint); {累加与输出图形}
Var i, j, k : Shortint;
Begin
     Inc(ways);         temp[n+1,1]:=Max +1; {添加一条记录便于打印后换行}
     If paint Then
       Begin
         Writeln('No. ',ways,' :');
         j := 1;        k:=1;
         While k <= n Do
           Begin
             For i := j To temp[k,2]-1 Do write('  '); {找到适当的位置}
             Write('* ');
             If temp[k,1] < temp[k+1,1] Then Begin Writeln; j := 1 End {必要时换行}
                                        Else j := temp[k,2]+1;
             Inc(k)
           End
       End
End;
Procedure Check; {检验是否有合法解}
Var least, temp : Tinfo; {temp是工作数组，一切操作均在temp中完成，blocks不改变，least
                    记录了代表最小表示的方案}
    i, left, sizex, sizey : Shortint;
min : Boolean;
{下面三段程序在例2中出现过，分别代表水平翻转，垂直翻转和顺时针转90度}
  Procedure Turn1;
  Var i : Shortint;
  Begin For i := 1 To n Do temp[i,2] := sizey+1-temp[i,2] End;
  Procedure Turn2;
  Var i : Shortint;
  Begin
    For i := 1 To n Do temp[i,1] := sizex+1-temp[i,1] End;
  Procedure Turn3;
  Var i, j : Shortint;
  Begin
    For i := 1 To n Do
      Begin
        j := temp[i,1];
        temp[i,1] := temp[i,2];         temp[i,2] := sizex+1-j
      End
  End;
 Procedure Compare; {比较是否是最小表示，一旦不是就退出}
 Var k : Shortint;
 Begin
   k := 0;
   While k < n Do
     Begin
       Inc(k);
       If temp[k,1] < least[k,1] Then Begin min := False; Exit End
       Else
         If temp[k,1] = least[k,1] Then
           If temp[k,2] < least[k,2] Then Begin min := False; Exit End
           Else If temp[k,2] > least[k,2] Then k := n
                Else
         Else k := n
     End
 End;
Begin
     temp := blocks;    sort(temp);
     sizex := temp[n,1];   min := True;  {利用sizex，sizey将负坐标还原为正坐标，即将
                                     图案填入一个最小的矩形中}
     left := Max;        sizey := -Max;
     For i := 1 To n Do {寻找最左边和最右边的坐标，以利于确定矩形的宽}
       Begin
         If left > temp[i,2] Then left := temp[i,2];
         If sizey < temp[i,2] Then sizey := temp[i,2]
       End;
     left := -left +1;   Inc(sizey, left);
     If sizex > sizey Then Exit; {若不是扁矩形则退出}
     For i := 1 To n Do Inc(Temp[i,2], left); {变换坐标}
     least := temp;
     If sizex < sizey Then {非正方形}
       Begin
         Turn1; Sort(Temp); Compare; If not(min) Then Exit;
         Turn2; Sort(Temp); Compare; If not(min) Then Exit;
         Turn1; Sort(Temp); Compare; If not(min) Then Exit
       End
     Else Begin {正方形，由此可见例2与例3的联系}
       Turn1; Sort(Temp); Compare; If not(min) Then Exit;
       Turn2; Sort(Temp); Compare; If not(min) Then Exit;
       Turn3; Sort(Temp); Compare; If not(min) Then Exit;
       Turn2; Sort(Temp); Compare; If not(min) Then Exit;
       Turn1; Sort(Temp); Compare; If not(min) Then Exit;
       Turn2; Sort(Temp); Compare; If not(min) Then Exit;
       Turn2; Sort(Temp); Compare; If not(min) Then Exit;
       Turn3; Sort(Temp); Compare; If not(min) Then Exit;
       Turn3; Sort(Temp); Compare; If not(min) Then Exit;
       Turn3; Sort(Temp); Compare; If not(min) Then Exit;
       Turn2; Sort(Temp); Compare; If not(min) Then Exit;
     End;
     Out(least, sizex, sizey) {通过上面的检查，就可以输出了}
End;
Procedure Solve(num, last: Shortint); {递归生成过程，num指当前已取到方块数，last表示从
                                第last个方块起是上一层新取的，即可以继续扩展的}
Var new : Tinfo; {new表示当前一层新扩展出的结点}
    i, j, x, y, all : Shortint;
  Procedure Sub_set(deep, total : Shortint); {递归穷举所有的子集}
  Var k : Shortint;
  Begin
    If deep = all +1 Then
      If (num <= n) and (total > 0) Then Solve(num, last)
      Else
    Else
      Begin
        {当前小方块不取时的情况}
        Sub_set(deep +1, total);
        {取当前小方块的情况}
        Add(blocks, num, new[deep, 1], new[deep, 2]); {添加方块}
        Sub_set(deep +1, total +1);
        Dec(num) {去掉方块}
      End
  End;
Begin
     If num = n Then Begin Check; Exit End;{方块数目达到则检查}
     all := 0; {当前可扩展的新结点数}
     For i := last To num Do {对上一轮新添加的每一个方块进行四个方向扩展}
       For j := 1 To 4 Do
         Begin
           x := blocks[i,1]+delta[j,1];
           y := blocks[i,2]+delta[j,2];
           If map[x, y] = 0 Then {遇到未扩展过的节点就追加进数组new}
             Begin
               Add(new, all, x, y);
               map[x, y] := -1 {标上-1，以示不可再访问}
             End
         End;
     last := num +1;{从序列尾开始添加新方块}     Sub_set(1, 0);
     For i := 1 To all Do map[new[i,1],new[i,2]] := 0 {清除本层所作标记}
End;
BEGIN{主程序}
     ways := 0;
     Init;
     Solve(1,1);
     Writeln('There are ',ways,' Polyominoes altogether.'); {打印总数}
     Close(output);
END.
