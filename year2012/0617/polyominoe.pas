Const Max = 32; {�趨N�����ֵ}
      delta : Array[1..4,1..2] of Shortint = ((0,1), (1,0), (0,-1), (-1,0)); {��ʾ�ĸ������ϵ�����
                                                          ����������}
Type Tmap = Array[0.. Max div 2,-Max.. Max] Of Shortint; {������ݽṹ��ʾ���㷨�й���
  �ı����ʽ����Ϊ�˳������㣬���������˱߿�, �����Ͳ����жϳ��磻���⣬Ϊ�˴����ϵļ�࣬�׷������궨Ϊ��1��0������������}
     Tinfo = Array[1..2* Max, 1..2] Of Shortint; {��¼���������}
Var map : Tmap;
    blocks : Tinfo; {ѡȡ��С����}
    f : Text;
    n, bottom : Shortint;
    paint : Boolean; {�Ƿ��ӡͼ��}
    ways : Longint; {��������}
Procedure Add(Var a : Tinfo; Var num : Shortint; x, y : Shortint); {���С����}
Begin Inc(num);     a[num, 1] := x;     a[num, 2] := y End;
Procedure Sort(Var blocks : Tinfo); {ѡ������, ��N��Сʱʮ����Ч}
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
Procedure Init; {��ʼ��}
Var i, j : Shortint;
    filename : String;
Begin
     Readln(n);
     filename:='polyominoe.out';
     Assign(output,filename);        Rewrite(output);
     If Abs(n) = n Then paint := True  {�ж��Ƿ���Ҫ�������}
Else paint := False;
     n := Abs(n);       bottom := n; {bottom��ʾmap��Ҫ���������}
     map[1,0] := 1;
     blocks[1,1] := 1;  blocks[1,2] := 0; {�����һ������}
     {���¶�map��ֵ�������в��������ʵĸ�������-1}
     For i := -Max To Max Do map[0,i] := -1;
//     For i := -Max To Max Do map[bottom +1,i] := -1;
     For i := 1 To bottom Do
       Begin
//         For j := -Max To i-n-1 Do map[i,j] := -1;
//         For j := n-i+1 To Max Do map[i,j] := -1
       End;
     For i := -Max To -1 Do map[1,i] := -1
End;
Procedure Out(temp : Tinfo; sizex, sizey : Shortint); {�ۼ������ͼ��}
Var i, j, k : Shortint;
Begin
     Inc(ways);         temp[n+1,1]:=Max +1; {���һ����¼���ڴ�ӡ����}
     If paint Then
       Begin
         Writeln('No. ',ways,' :');
         j := 1;        k:=1;
         While k <= n Do
           Begin
             For i := j To temp[k,2]-1 Do write('  '); {�ҵ��ʵ���λ��}
             Write('* ');
             If temp[k,1] < temp[k+1,1] Then Begin Writeln; j := 1 End {��Ҫʱ����}
                                        Else j := temp[k,2]+1;
             Inc(k)
           End
       End
End;
Procedure Check; {�����Ƿ��кϷ���}
Var least, temp : Tinfo; {temp�ǹ������飬һ�в�������temp����ɣ�blocks���ı䣬least
                    ��¼�˴�����С��ʾ�ķ���}
    i, left, sizex, sizey : Shortint;
min : Boolean;
{�������γ�������2�г��ֹ����ֱ����ˮƽ��ת����ֱ��ת��˳ʱ��ת90��}
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
 Procedure Compare; {�Ƚ��Ƿ�����С��ʾ��һ�����Ǿ��˳�}
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
     sizex := temp[n,1];   min := True;  {����sizex��sizey�������껹ԭΪ�����꣬����
                                     ͼ������һ����С�ľ�����}
     left := Max;        sizey := -Max;
     For i := 1 To n Do {Ѱ������ߺ����ұߵ����꣬������ȷ�����εĿ�}
       Begin
         If left > temp[i,2] Then left := temp[i,2];
         If sizey < temp[i,2] Then sizey := temp[i,2]
       End;
     left := -left +1;   Inc(sizey, left);
     If sizex > sizey Then Exit; {�����Ǳ�������˳�}
     For i := 1 To n Do Inc(Temp[i,2], left); {�任����}
     least := temp;
     If sizex < sizey Then {��������}
       Begin
         Turn1; Sort(Temp); Compare; If not(min) Then Exit;
         Turn2; Sort(Temp); Compare; If not(min) Then Exit;
         Turn1; Sort(Temp); Compare; If not(min) Then Exit
       End
     Else Begin {�����Σ��ɴ˿ɼ���2����3����ϵ}
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
     Out(least, sizex, sizey) {ͨ������ļ�飬�Ϳ��������}
End;
Procedure Solve(num, last: Shortint); {�ݹ����ɹ��̣�numָ��ǰ��ȡ����������last��ʾ��
                                ��last������������һ����ȡ�ģ������Լ�����չ��}
Var new : Tinfo; {new��ʾ��ǰһ������չ���Ľ��}
    i, j, x, y, all : Shortint;
  Procedure Sub_set(deep, total : Shortint); {�ݹ�������е��Ӽ�}
  Var k : Shortint;
  Begin
    If deep = all +1 Then
      If (num <= n) and (total > 0) Then Solve(num, last)
      Else
    Else
      Begin
        {��ǰС���鲻ȡʱ�����}
        Sub_set(deep +1, total);
        {ȡ��ǰС��������}
        Add(blocks, num, new[deep, 1], new[deep, 2]); {��ӷ���}
        Sub_set(deep +1, total +1);
        Dec(num) {ȥ������}
      End
  End;
Begin
     If num = n Then Begin Check; Exit End;{������Ŀ�ﵽ����}
     all := 0; {��ǰ����չ���½����}
     For i := last To num Do {����һ������ӵ�ÿһ����������ĸ�������չ}
       For j := 1 To 4 Do
         Begin
           x := blocks[i,1]+delta[j,1];
           y := blocks[i,2]+delta[j,2];
           If map[x, y] = 0 Then {����δ��չ���Ľڵ��׷�ӽ�����new}
             Begin
               Add(new, all, x, y);
               map[x, y] := -1 {����-1����ʾ�����ٷ���}
             End
         End;
     last := num +1;{������β��ʼ����·���}     Sub_set(1, 0);
     For i := 1 To all Do map[new[i,1],new[i,2]] := 0 {��������������}
End;
BEGIN{������}
     ways := 0;
     Init;
     Solve(1,1);
     Writeln('There are ',ways,' Polyominoes altogether.'); {��ӡ����}
     Close(output);
END.
