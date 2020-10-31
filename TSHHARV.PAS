program Gatherer;
uses crt;
var
  CurX, CurY, ClnLine, StartAttr, i,j: byte;
  Total,Gathered: integer;
  AField: array[1..22,1..80] of char;
  PressedKey: char;

  procedure ShowCount; {вывод количества собр мусора в окне }

  begin
     Window(1,1,80,3);
     TextColor(Yellow);
     GotoXY(40,1);
     Write('Собрано мусора:  ', Gathered,' из ', Total);
     end;

  procedure DrawPos;  { прорисовка сборщика}
  var
    CurChar: Char;
  begin
    {рисуем сборщика мусора}
    Window(1,3,80,25);
    TextBackGround(Black);
    TextColor(LightRed);
    GotoXY(CurX,CurY);
    Write('#');
    if AField[CurY,CurX] = '*' then { если в этой позиции находится мусор}
    begin
       Inc(Gathered);  { увеличиваем количество собр мусора на 1}
       AField[CurY,CurX] := ' '; { затираем текущую позицию от мусора}
    end;
    ShowCount;        { обновляем информацию о собранном мусоре}
  end;
    {процедура прорисовки строки подсказки}
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
  StartAttr := TextAttr;          { Запоминаем текущие цветовые настройки }
  Window(1,1,80,3);               { Рисуем заголовок }
  TextBackGround(Black);
  TextColor(White);
  ClrScr;
  Write('Игра "Сборщик мусора" ');
  ShowCount;
  GotoXY(1,2);
  for i:=1 to 80 do Write('-');
  Window(1,3,80,25);               { Рисуем игровое поле }
  TextBackGround(Black);
  TextColor(LightGreen);
  ClrScr;                          { заполняем поле черным цветом}
  GotoXY(1,1);
  Randomize;                       { Активизируем генерацию случайных чисел}
  for i:=3 to 24 do                { Наполняем поле мусором}
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
  DrawStatus(Black,Blue, 'Для окончания игры - Esc.' +
                             'Перемещение сборщика - клавиши со стрелками.');
  GotoXY(1,1);
  CurX:=1;
  CurY:=1;
  repeat
    DrawPos;            {Прорисовка позиции сборщика}
    PressedKey:= ReadKey;
    Window(1,3,80,25);
    {if Ord(PressedKey) then break
    else}
    begin               {Затираем предыдущую позицию сборщика}
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
  DrawStatus(White+Blink,Red,' Игра окончена!');
  ReadKey;
  TextAttr := StartAttr;
  Window(1,1,80,25);
  ClrScr;
end.













