program Gatherer;
uses crt;
var
  CurX, CurY, ClnLine, StartAttr, i,j: byte;
  Total,Gathered: integer;
  AField: array[1..22,1..80] of char;
  PressedKey: char;

  procedure ShowCount; {�뢮� ������⢠ ᮡ� ���� � ���� }

  begin
     Window(1,1,80,3);
     TextColor(Yellow);
     GotoXY(40,1);
     Write('���࠭� ����:  ', Gathered,' �� ', Total);
     end;

  procedure DrawPos;  { ���ᮢ�� ᡮ�騪�}
  var
    CurChar: Char;
  begin
    {��㥬 ᡮ�騪� ����}
    Window(1,3,80,25);
    TextBackGround(Black);
    TextColor(LightRed);
    GotoXY(CurX,CurY);
    Write('#');
    if AField[CurY,CurX] = '*' then { �᫨ � �⮩ ����樨 ��室���� ����}
    begin
       Inc(Gathered);  { 㢥��稢��� ������⢮ ᮡ� ���� �� 1}
       AField[CurY,CurX] := ' '; { ���ࠥ� ⥪���� ������ �� ����}
    end;
    ShowCount;        { ������塞 ���ଠ�� � ᮡ࠭��� ����}
  end;
    {��楤�� ���ᮢ�� ��ப� ���᪠���}
  procedure DrawStatus (FColor, BColor: byte; Si : string);
  begin
     Window(1,25,80,25);
     TextBackGround(FColor);
     TextColor(BColor);
     ClrScr;
     GotoXY(1,25);
     Write;
  end;

begin
  ClrScr;
  StartAttr := TextAttr;          { ���������� ⥪�騥 梥⮢� ����ன�� }
  Window(1,1,80,3);               { ���㥬 ��������� }
  TextBackGround(Black);
  TextColor(White);
  ClrScr;
  Write('��� "����騪 ����" ');
  ShowCount;
  GotoXY(1,2);
  for i:=1 to 80 do Write('-');
  Window(1,3,80,25);               { ���㥬 ��஢�� ���� }
  TextBackGround(Black);
  TextColor(LightGreen);
  ClrScr;                          { ������塞 ���� ��� 梥⮬}
  GotoXY(1,1);
  Randomize;                       { ��⨢����㥬 ������� ��砩��� �ᥫ}
  for i:=3 to 24 do                { ������塞 ���� ���஬}
  begin
    InsLine;
    ClnLine := Random(9)+1;

    CurX :=1;
    CurY :=1;
    for j:=1 to ClnLine do
    begin
      CurX :=CurX+Random(8) +1;
      if CurX > 80 then CurX:=79;
      GotoXY(CurX,1);
      Write('*');
      AField[25-i,CurX] := '*';
      while (CurX mod 8) > 0 do Inc(CurX);
    end;
    Inc(Total,ClnLine);
  end;
  DrawStatus(Black,Blue, '��� ����砭�� ���� - Esc.' +
                             '��६�饭�� ᡮ�騪� - ������ � ��५����.');
  GotoXY(1,1);
  CurX:=1;
  CurY:=1;
  repeat
    DrawPos;            {���ᮢ�� ����樨 ᡮ�騪�}
    PressedKey:= ReadKey;
    Window(1,3,80,25);
    {if Ord(PressedKey) then break
    else}
    begin               {���ࠥ� �।����� ������ ᡮ�騪�}
       GotoXY(CurX,CurY);
       TextBackGround(Black);
       Write(' ');
       case Ord(PressedKey) of
         72: if CurY > 1 then Dec(CurY);
         75: if CurX > 1 then Dec(CurX);
         77: if CurX < 80 then Inc(CurX);
         80: if CurY < 22 then Inc(CurY);
       end;
    end;
  until Gathered = Total;
  DrawStatus(White+Blink,Red,' ��� ����祭�!');
  ReadKey;
  TextAttr := StartAttr;
  Window(1,1,80,25);
  ClrScr;
end.













