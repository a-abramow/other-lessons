{****************************************************************************}
{����� ������ ����ᠭ��� �� Pascal 7.0 ��� ��������, � ��� � ��� �뫮
ZOMBIEn@mail.ru ��� ����ᮢ ;)}
{****************************************************************************}
Program GAMES;
Uses CRT;


Var
 x,y:array [1..5] of byte; {����}
 q1,q2,S:byte; {���}
 i,j,sh:byte; {���稪�}
 Top,Left,schet:integer; {��������� � ���}
 Key:char; {������}
 Dostup:boolean; {�����஢�� ������}

{����}
Procedure Zmeya(cvet:byte);
 begin
 TextColor(cvet);
 For i:=1 to 5 do
  begin
  GoToXY(x[i],y[i]);
  if i=1 then Write(chr(2))
   else Write(chr(254));
  end;
 end;

{��������� ����}
Procedure Izmenenie_Zmei;
 begin
 For i:=5 downto 2 do
  begin
  x[i]:=x[i-1];
  y[i]:=y[i-1];
  end;
 x[1]:=x[1]+Left;
 y[1]:=y[1]+Top;
 end;

{���� ����}
Begin
TextBackgRound(2);
ClrScr;
TextColor(15);
GoToXY(33,10);
Write('-=GAMES PYTHON=-');
GoToXY(29,12);
Write('-=���� ������ �������=-');
GoToXY(34,14);
Write('������� ENTER');
Readln;
ClrScr;

{��஢�� ����}
For i:=2 to 79 do
 For j:=2 to 22 do
  if (i=2) or (i=79) or (j=2) or (j=22) then
   begin
   GoToXY(i,j);
   Write(chr(176));
   GoToXY(6,24);
   Write('ESC - �����');
   GoToXY(35,24);
   Write('���� ',schet);
   end;

{��砫�� ��न����}
schet:=0;
For i:=1 to 5 do
 begin
 x[i]:=41-i;
 y[i]:=15;
 end;

{���ᮢ�� ����}
Dostup:=True;
Repeat
 Zmeya(12);
 Delay(20000);
 TextColor(2);
 Zmeya(2);

{������ ��� �������� ������}
if Dostup=True then
  Case Key of
   #72:begin Top:=-1; Left:=0; end;
   #80:begin Top:=1; Left:=0; end;
   #77:begin Top:=0; Left:=1; end;
   #75:begin Top:=0; Left:=-1; end;
  end;

Izmenenie_Zmei;

{���}
 if sh = 50 then
  begin
  GotoXY(q1,q2);
  TextColor(4);
  Write(' ');
  Randomize;
  q1:=random(74)+3;
  q2:=random(17)+3;
  S:=random(9);
  GoToXY(q1,q2);
  TextColor(4);
  Write(S);
  sh:=0;
  end
   else sh:=sh+1;

  if (x[1] = q1) and (y[1]=q2) then
   begin
   schet := schet+s;
   TextColor(5);
   GoToXY(35,24);
   Write('���� ',schet);
   end;

{����� ����}
if (Left<>0) and ((x[1]<3)) or (x[1]>78) then
 begin
 Left:=0;
 Key:=' ';
 GoToXY(35,12);
 TextColor(5);
 Write('���� ��������');
 Dostup:=False;
 end;
if (Top<>0) and ((y[1]<3)) or (y[1]>21) then
 begin
 Top:=0;
 Key:=' ';
 GoToXY(35,12);
 TextColor(5);
 Write('���� ��������');
 Dostup:=False;
 end;
if KeyPressed=True then Key:=Readkey;

until Key=#27;

End.