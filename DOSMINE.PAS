Program MineSweeper;
{****************************************************************************}
Uses    Crt,Graph,Dos;
{****************************************************************************}
Const   Board : FillPatternType=($FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF);
        Xb=225;   Yb=150;   Rb=8;    Cb=8;    Mb=10;
        Xi=158;   Yi=90;    Ri=16;   Ci=16;   Mi=40;
        Xe=15;    Ye=90;    Re=16;   Ce=30;   Me=100;
        Dim=20;
{****************************************************************************}
Type    Mine= record
           Num:Integer;
           Opened:Boolean;
           Mistaken:Boolean;
           Suspended1:Boolean;
           Suspended2:Boolean;
        end;
{****************************************************************************}
Var     InitialX,InitialY,FinalX,FinalY,FreeSpaces,TotalMines,FreeCounter,
        Level,TotalRows,TotalColumns : Integer;
        Over,Interupted:Boolean;
        A:Array[1..Re,1..Ce] of Mine;
        Ch:Char;
{****************************************************************************}
   Procedure OpenGraphics;
   Var GraphDriver,GraphMode,ErrorCode:Integer;
   begin
      GraphDriver:=Detect;
      InitGraph(GraphDriver,GraphMode,'X:\BP');
      ErrorCode := GraphResult;
      If (ErrorCode<>GrOk) then
      begin
         ClrScr;
         Writeln('Graphics Error! ',GraphErrorMsg(ErrorCode));
         Writeln('Please use SchoolPak to run this game...');
         Writeln('Download it here: http://dim-hj.gorodok.net/ ');
         Write('Press any key...');
         Ch:=Readkey;
         Halt(1);
      end;
   end;
{****************************************************************************}
   Procedure Introduction;
   Var i:Integer;
   begin
      ClearDevice;
      SetColor(13);
      Rectangle(40,120,600,310);
      SetFillPattern(Board,1);
      FloodFill(300,150,13);
      SetTextStyle(DefaultFont,HorizDir,3);
      OutTextXY(85,130,'Д');
      SetTextStyle(DefaultFont,HorizDir,2);
      OutTextXY(110,133,'обро пожаловать в игру Сапёр!');
      SetColor(15);
      For i:=0 to 24 do
      begin
         Line(325,154,325+10*i,154);
         Line(325,155,325+10*i,155);
         Line(325,154,325-10*i,154);
         Line(325,155,325-10*i,155);
         delay(50);
      end;
      SetTextStyle(DefaultFont,HorizDir,1);
      OutTextXY(200,165,'*** Игра разработана ***');
      OutTextXY(170,185,'- На языке программирования Pascal,');
      OutTextXY(170,205,'- В университете Zimbabwe,');
      OutTextXY(170,225,'- Yonas Tesfazghi weldeselassie,');
      OutTextXY(170,245,'- В среду 23-го февраля 2000.');
      SetColor(Yellow);
      OutTextXY(200,280,'Нажмите любую клавишу для продолжения...');
      Ch := ReadKey;
   end;
{****************************************************************************}
   Procedure Timer(n:Integer);
   Var h,m,s,hund:word;
   begin
      GetTime(h,m,s,hund);
      If (n=1) then {The game is being started.}
      begin
         SetColor(2);
         Rectangle(20,450,130,470);
         Rectangle(510,450,610,470);
         SetTextstyle(DefaultFont,HorizDir,1);
         SetColor(12);
         OutTextXY(25,440,'Время начала');
         OutTextXY(517,440,'Время конца');
         OutTextXY(35,457,Chr(h div 10+48));
         OutTextXY(45,457,Chr(h mod 10+48));
         OutTextXY(55,457,':');
         OutTextXY(65,457,Chr(m div 10+48));
         OutTextXY(75,457,Chr(m mod 10+48));
         OutTextXY(85,457,':');
         OutTextXY(95,457,Chr(s div 10+48));
         OutTextXY(105,457,Chr(s mod 10+48));
         SetTextstyle(DefaultFont,HorizDir,2);
         OutTextXY(555,453,'?');
      end
      Else  {The player has won the game or the game is over.}
      begin
         SetFillPattern(Board,0);
         FloodFill(550,460,2);
         SetColor(12);
         SetTextstyle(DefaultFont,HorizDir,1);
         OutTextXY(522,457,Chr(h div 10+48));
         OutTextXY(532,457,Chr(h mod 10+48));
         OutTextXY(542,457,':');
         OutTextXY(552,457,Chr(m div 10+48));
         OutTextXY(562,457,Chr(m mod 10+48));
         OutTextXY(572,457,':');
         OutTextXY(582,457,Chr(s div 10+48));
         OutTextXY(592,457,Chr(s mod 10+48));
      end;
   end;
{*************************************************************** *************}
   Procedure HelpMenu;
   begin
      ClearDevice;
      SetTextStyle(DefaultFont,HorizDir,2);
      SetColor(13);
      Rectangle(259,0,379,20);
      SetColor(2);
      OutTextXY(280,3,'Сапёр');
      SetColor(15);
      SetTextStyle(DefaultFont,HorizDir,1);
      Rectangle(10,20,630,479);
      SetFillPattern(Board,1);
      FloodFill(300,150,15);
      SetColor(10);
      OutTextXY(243,30,'Правила игры в Сапёр');
      Line(237,40,408,40);
      SetColor(7);
      OutTextXY(25,50,'    Сапёр -- это игра с игровым полем и несколькими минами на этом поле.');
      OutTextXY(25,65,'Поле поделено на мелкие квадраты, и количество этих квадратов и мин зависит');
      OutTextXY(25,80,'от желаемого УРОВНЯ игры. Размер поля и количество мин на каждый уровнь');
      OutTextXY(25,95,'следующие:');
      OutTextXY(25,110,'');
      SetColor(10);
      OutTextXY(30,125,'   Уровень игры   #Строк    #Столбцов    #Квадратов   #Мин  ');
      Line(53,135,150,135);   Line(173,135,223,135);   Line(255,135,325,135);
      Line(360,135,437,135);  Line(462,135,495,135);
      SetColor(15);
      OutTextXY(55,140,'Новичок           8          8            8x8=64     10');
      OutTextXY(55,155,'Любитель         16         16         16x16=256     40');
      OutTextXY(55,170,'Эксперт          16         30         16x30=480    100');
      SetColor(7);
      OutTextXY(25,190,'  Мины ПРОИЗВОЛЬНО расставлены в квадратах, и ваша цель -- ТОЧНО определить');
      OutTextXY(25,205,'месторасположение мин. Вы указываете их, нажимая клавишу       на квадрате');
      OutTextXY(25,220,'с миной внутри.');
      SetColor(14); OutTextXY(483,205,'<ESC>');
      SetColor(7);  OutTextXY(170,220,'');
      OutTextXY(25,235,'   Если в квадрате НЕТ мины, то на нём написано число, которое указывает');
      OutTextXY(25,250,'количество соседних квадратов с минами. Чтобы узнать, ПУСТОЙ ли квадрат,');
      OutTextXY(25,265,'нужно нажать клавишу         на нём. Однако, нажатие клавиши ENTER в');
      SetColor(14); OutTextXY(194,265,'<ENTER>');
      SetColor(7);  OutTextXY(485,265,'');
      OutTextXY(25,280,'квадрате с миной приведёт к фатальному исходу. Поэтому нужно стараться');
      OutTextXY(25,295,'не нажимать клавишу ENTER на квадрате с миной.');
      OutTextXY(25,310,'   Когда вы начинаете игру, вы видите индикатор, квадрат, нарисованный');
      OutTextXY(25,325,'особенным цветом. Вы можете передвигать индикатор в любую сторону клавишами');
      SetColor(14); OutTextXY(25,340,'<СТРЕЛКИ>');   SetColor(7);
      OutTextXY(87,340,' . В самом начале вы можете нажать клавишу ENTER где угодно, и');
      OutTextXY(25,355,'этот квадрат будет обязательно пустым.');
      OutTextXY(25,370,'   Если вы решили, что в квадрате есть мина, и поставили пометку, но');
      OutTextXY(25,385,'передумали и хотите убрать пометку, нужно нажать клавишу ESC ещё раз на');
      OutTextXY(25,400,'этои квадрате. На этот раз вы увидите знак вопроса, обозначающий, что вы');
      OutTextXY(25,415,'отменяете пометку. Следующее нажатие ESC уберёт этот знак вопроса, и');
      OutTextXY(25,430,'этот квадрат возвратится в изначальное нетронутое состояние.');
      SetColor(13);   OutTextXY(150,450,'Нажмите    , чтобы остановить игру');
      SetColor(14);   OutTextXY(64,470,'НАЖМИТЕ ЛЮБУЮ КЛАВИШУ ДЛЯ ПРОДОЛЖЕНИЯ...');
      SetColor(15);   OutTextXY(390,470,'С наилучшими пожеланиями! Y.T.');
      SetTextStyle(DefaultFont,HorizDir,2);
      OutTextXY(215,447,'S');
      Ch := Readkey;
   end;
{****************************************************************************}
   Procedure WriteHeading(Y:Integer);
   begin
      SetColor(13);
      Rectangle(136,Y,496,Y+40);
      SetColor(Green);
      SetTextStyle(DefaultFont,HorizDir,3);
      OutTextXY(254, Y+10,'САПЁР');
      SetColor(13);
      If (Y=40) then
      begin
         Rectangle(235,Y+40,385,Y+60);
         SetColor(yellow);
         SetTextStyle(DefaultFont,HorizDir,2);
         OutTextXY(257,Y+45,'Уровень');
      end
      Else
      begin
         Rectangle(220,Y+40,400,Y+60);
         SetColor(Yellow);
         SetTextStyle(DefaultFont,HorizDir,1);
         If (Level=1) then
               OutTextXY(255,Y+50,'Новичок')
         Else if (Level=2) then
               OutTextXY(240,Y+50,'Любитель')
         Else  OutTextXY(265,Y+50,'Эксперт');
      end;
   end;
{****************************************************************************}
   Procedure SetData(GL:Integer);
   begin
      If (GL=1) then
      begin
         Level:=1;
         TotalMines:=Mb;
         TotalRows:=Rb;
         TotalColumns:=Cb;
         FreeSpaces:=Rb*Cb-Mb;
         InitialX:=Xb;
         InitialY:=Yb;
      end
      Else if (GL=2) then
      begin
         Level:=2;
         TotalMines:=Mi;
         TotalRows:=Ri;
         TotalColumns:=Ci;
         FreeSpaces:=Ri*Ci-Mi;
         InitialX:=Xi;
         InitialY:=Yi;
      end
      Else
      begin
         Level:=3;
         TotalMines:=Me;
         TotalRows:=Re;
         TotalColumns:=Ce;
         FreeSpaces:=Re*Ce-Me;
         InitialX:=Xe;
         InitialY:=Ye;
      end;
      FinalX:=InitialX+TotalColumns*Dim;
      FinalY:=InitialY+TotalRows*Dim;
   end;
{****************************************************************************}
   Procedure WelComing;
   begin
      Introduction;
      HelpMenu;
      ClearDevice;
      WriteHeading(40);
      SetColor(13);
      Rectangle(40,120,600,270);
      SetFillPattern(Board,1);
      FloodFill(300,150,13);
      SetColor(15);
      SetTextStyle(DefaultFont,HorizDir,1);
      OutTextXY(170,150,'Выберите уровень игры:');
      OutTextXY(230,170,'1. Новичок,');
      OutTextXY(230,190,'2. Любитель или');
      OutTextXY(230,210,'3. Эксперт.');
      SetColor(Yellow);
      OutTextXY(220,245,'Нажмите 1, 2 или 3.');
      Repeat
         Ch:=Readkey;
      Until (Ch in ['1','2','3']);
      SetData(Ord(Ch)-48);
   end;
{****************************************************************************}
   Procedure DrawNonOpened(X,Y:Integer);
   begin
      SetColor(DarkGray);
      Rectangle(X,Y,X+Dim,Y+Dim);
      SetFillPattern(Board,LightGray);
      FloodFill(X+Dim div 2,Y+ Dim div 2,DarkGray);
      Line(X+2,Y+Dim-2,X+Dim-2,Y+Dim-2);
      Line(X+Dim-2,Y+2,X+Dim-2,Y+Dim-2);
      SetColor(White);
      Line(X+2,Y+2,X+Dim-2,Y+2);
      Line(X+2,Y+2,X+2,Y+Dim-2);
   end;
{****************************************************************************}
   Procedure DrawField;
   Var i:Integer;
   begin
      ClearDevice;
      WriteHeading(5);
      SetColor(darkGray);
      Rectangle(InitialX-10,InitialY-10,FinalX+10,FinalY+10);
      SetFillPattern(Board,LightGray);
      FloodFill(InitialX,InitialY,DarkGray);
      For i:=1 to 11 do
      begin
         If (i in [1,2,3,4]) then
         begin
            SetColor(DarkGray);
               Line(initialX-i,InitialY-i,InitialX-i,Finaly+i);
               Line(InitialX-i,InitialY-i,FinalX+i,InitialY-i);
            SetColor(White);
               Line(InitialX-i,FinalY+i,FinalX+i,FinalY+i);
               Line(FinalX+i,InitialY-i,FinalX+i,FinalY+i);
         end
         Else if (i in [9,10,11]) then
         begin
            SetColor(DarkGray);
               Line(InitialX-i,FinalY+i,FinalX+i,FinalY+i);
               Line(FinalX+i,InitialY-i,FinalX+i,FinalY+i);
            SetColor(White);
               Line(InitialX-i,InitialY-i,FinalX+i,InitialY-i);
               Line(InitialX-i,InitialY-i,InitialX-i,FinalY+i);
         end;
      end;
      SetColor(darkGray);
         Rectangle(InitialX-1,InitialY-1,FinalX+1,FinalY+1);

   end;
{****************************************************************************}
   Procedure DrawBoard;
   Var X,Y,i,j:Integer;
   begin
      DrawField;
      For i:=0 to (TotalRows-1) do
      begin
         Y:=InitialY+Dim*i;
         For j:=0 to (TotalColumns-1) do
         begin
            X:=InitialX+Dim*j;
            DrawNonOpened(X,Y);
         end;
      end;
   end;
{****************************************************************************}
   Procedure DrawNewIndicator(X,Y:Integer);
   begin
      SetColor(13);
      Rectangle(X+3,Y+3,X+Dim-3,Y+Dim-3);
      Rectangle(X+4,Y+4,X+Dim-4,Y+Dim-4);
   end;
{****************************************************************************}
   Procedure RemoveOldIndicator(X,Y:Integer);
   begin
      SetColor(7);
      Rectangle(X+3,Y+3,X+Dim-3,Y+Dim-3);
      Rectangle(X+4,Y+4,X+Dim-4,Y+Dim-4);
   end;
{****************************************************************************}
   Procedure MoveIndicator(Var X,Y,Row,Col:Integer; Ch:Char);
   Var OldX,OldY:Integer;
   begin
      OldX:=X;
      OldY:=Y;
      Case Ch of
         #72: If (Y>InitialY) then
              begin
                 Y:=Y-Dim;
                 Dec(Row);
              end;
         #75: If (X>InitialX) then
              begin
                 X:=X-Dim;
                 Dec(Col);
              end;
         #77: If ((X+Dim)<FinalX) then
              begin
                 X:=X+Dim;
                 Inc(Col);
              end;
         #80: If ((Y+Dim)<FinalY) then
              begin
                 Y:=Y+Dim;
                 Inc(Row);
              end;
      end;
      If ((OldX<>X) or (OldY<>Y)) then
      begin
         RemoveOldIndicator(OldX,OldY);
         DrawNewIndicator(X,Y);
      end;
   end;
{****************************************************************************}
   Procedure WriteNumber(X,Y,Row,Col:Integer);
   Var Color:Integer;
   begin
      Case A[Row,Col].Num of
         1: Color:=9;   4: Color:=1;    7: Color:=12;
         2: Color:=2;   5: Color:=5;    8: Color:=13;
         3: Color:=4;   6: Color:=3;    9: Color:=0;
      end;
      SetColor(Color);
      SetTextStyle(DefaultFont,HorizDir,1);
      If (A[Row,Col].Num=9) then
            OutTextXY(X+7,Y+7,Chr(15))
      Else  OutTextXY(X+7,Y+7,Chr(A[Row,Col].Num+48));
   end;
{****************************************************************************}
   Procedure DrawOpened(X,Y,Row,Col:Integer);
   var Color:Integer;
   begin
      If (A[Row,Col].Suspended2) then
          DrawNonOpened(X,Y);
      color:=1;
      SetColor(Color);
      Rectangle(X+1,Y+1,X+Dim-1,Y+Dim-1);
      SetFillPattern(Board,LightGray);
      FloodFill(X+Dim div 2,Y+Dim div 2,Color);
      If (A[Row,Col].num<>0) then
         WriteNumber(X,Y,Row,Col);
   end;
{****************************************************************************}
   Procedure DrawSuspended1(X,Y:Integer);
   Var Color:Integer;
   begin
      DrawNonOpened(X,Y);
      Color:=Red;
      SetColor(Color);
      setTextStyle(defaultFont,HorizDir,1);
      OutTextXY(X+7,Y+7,Chr(6));
   end;
{****************************************************************************}
   Procedure DrawSuspended2(X,Y:Integer);
   Var Color:Integer;
   begin
      DrawNonOpened(X,Y);
      Color:=1;
      SetColor(Color);
      SetTextStyle(DefaultFont,HorizDir,1);
      OutTextXY(X+7,Y+7,Chr(63));
   end;
{****************************************************************************}
   Procedure OpenSurrounding(X,Y,Row,Col:Integer);
   Var XX,YY,RR,CC,i,j:Integer;
   begin
      For i:=-1 to 1 do
      begin
         RR:=Row+i;
         If (RR in [1..TotalRows]) then
         begin
            For j:=-1 to 1 do
            begin
               CC:=Col+j;
               If (CC in [1..TotalColumns]) then
               begin
                  If (Not((A[RR,CC].Opened) or (A[RR,CC].Suspended1) or
                          (A[RR,CC].Suspended2))) then
                  begin
                     A[RR,CC].Opened:=True;
                     XX:=X+Dim*j;
                     YY:=Y+Dim*i;
                     DrawOpened(XX,YY,RR,CC);
                     Inc(FreeCounter);
                     If (A[RR,CC].Num=0) then
                         OpenSurrounding(XX,YY,RR,CC);
                  end;
               end;
            end;
         end;
      end;
   end;
{****************************************************************************}
   Procedure Allocate(Row,Col:Integer);
   Var R,C,RR,CC,Sum,i,j:Integer;
   begin
      For i:=1 to TotalMines do
      begin
         Randomize;
         Repeat
            R:=Random(TotalRows)+1;
            C:=Random(TotalColumns)+1;
         Until (((R<>Row) or (C<>Col)) and (A[R,C].Num<>9));
         A[R,C].Num:=9;
      end;
      For R:=1 to TotalRows do
      begin
         For C:=1 to totalColumns do
         begin
            If (A[R,C].Num<>9) then
            begin
               Sum:=0;
               For i:=-1 to 1 do
               begin
                  RR:=R+i;
                  If (RR in [1..TotalRows]) then
                  begin
                     For j:=-1 to 1 do
                     begin
                        CC:=C+j;
                        If (CC in [1..TotalColumns]) then
                        begin
                           If (A[RR,CC].Num=9) then
                               Inc(Sum);
                        end;
                     end;
                  end;
               end;
               A[R,C].Num:=Sum;
            end;
         end;
      end;
   end;
{****************************************************************************}
   Procedure DrawCross(X,Y,Row,Col:Integer);
   Var Color:Integer;
   begin
      SetColor(Red);
      Line(X+4,Y+4,X+Dim-4,Y+Dim-4);
      Line(X+5,Y+4,X+Dim-3,Y+Dim-4);
      Line(X+4,Y+Dim-4,X+Dim-4,Y+4);
      Line(X+5,Y+Dim-4,X+Dim-3,Y+4);
   end;
{****************************************************************************}
   Procedure Success;
   begin
      Timer(2);
      SetColor(13);
      SetTextStyle(DefaultFont,HorizDir,2);
      OutTextXY(180,FinalY+25,'ПОЗДРАВЛЕНИЯ!');
      SetTextStyle(DefaultFont,HorizDir,1);
      OutTextXY(220,FinalY+45,'Вы выиграли игру.');
   end;
{****************************************************************************}
   Procedure GameOver(X,Y:Integer);
   Var XX,YY,Row,Col:Integer;
   begin
      Timer(2);
      For Row:=1 to TotalRows do
      begin
         YY:=InitialY+(Row-1)*Dim;
         For Col:=1 to TotalColumns do
         begin
            If (Not(A[Row,Col].Opened)) then
            begin
               XX:=InitialX+(Col-1)*Dim;
               If (A[Row,Col].Mistaken) then
                   DrawCross(XX,YY,Row,Col)
               Else if ((A[Row,Col].Num=9) and
                        (Not(A[Row,Col].Suspended1))) then
                   DrawOpened(XX,YY,Row,Col);
            end;
         end;
      end;
      SetColor(1);{Now show where the MISTAKE occured.}
      Rectangle(X+1,Y+1,X+Dim-1,Y+Dim-1);
      SetFillPattern(Board,Red);
      FloodFill(X+Dim div 2,Y+Dim div 2,1);
      OutTextXY(X+7,Y+7,Chr(47));
      OutTextXY(X+7,Y+7,Chr(92));
      SetColor(13);
      SetTextStyle(DefaultFont,HorizDir,2);
      OutTextXY(130,FinalY+30,' Вы проиграли!');
      SetTextStyle(DefaultFont,HorizDir,1);
      OutTextXY(350,FinalY+35,' Игра окончена.');
   end;
{****************************************************************************}
   Procedure Warning;
   begin
      SetColor(15);
      SetTextStyle(DefaultFont,HorizDir,1);
      OutTextXY(142,FinalY+25,'Вы действительно хотите прервать игру? (Y/N)');
      Repeat
         Ch:=Readkey;
      Until (Ch in ['n','N','y','Y']);
      If (Ch in ['y','Y']) then
          Interupted:=True;
      SetColor(0);
      OutTextXY(142,FinalY+25,'Вы действительно хотите прервать игру? (Y/N)');
   end;
{****************************************************************************}
   Procedure Play(Var X,Y,Row,Col:Integer);
   begin
      Repeat
         Ch:=Readkey;
      Until ((Ord(Ch) in [13,27,83,115]) or (Ch in [#72,#75,#77,#80]));
      If (Ch in [#72,#75,#77,#80]) then
           MoveIndicator(X,Y,Row,Col,Ch)
      Else if (Ord(Ch)=13) then
      begin
         If (Not((A[Row,Col].Opened) or (A[Row,Col].Suspended1))) then
         begin
            A[Row,Col].Opened:=True;
            DrawOpened(X,Y,Row,Col);
            DrawNewIndicator(X,Y);
            If (A[Row,Col].Num=9) then
            begin
               Over:=True;
               GameOver(X,Y);
            end
            Else
            begin
               Inc(FreeCounter);
               If (A[Row,Col].Num=0) then
                   OpenSurrounding(X,Y,Row,Col);
               If (FreeCounter=FreeSpaces) then
               begin
                  Over:=True;
                  Success;
               end;
            end;
         end;
      end
      Else if (Ord(Ch)=27) then
      begin
         If (Not(A[Row,Col].Opened)) then
         begin
            If (A[Row,Col].suspended1) then
            begin
               A[Row,Col].Suspended1:=False;
               A[Row,Col].Suspended2:=True;
               A[Row,Col].Mistaken:=False;
               DrawSuspended2(X,Y);
            end
            Else if (A[Row,Col].Suspended2) then
            begin
               A[Row,Col].Suspended2:=False;
               DrawNonOpened(X,Y);
            end
            Else
            begin
               A[Row,Col].Suspended1:=True;
               DrawSuspended1(X,Y);
               If (A[Row,Col].Num<>9) then
                     A[Row,Col].Mistaken:=True
            end;
            DrawNewindicator(X,Y);
         end;
      end
      Else Warning;
   end;
{****************************************************************************}
   Procedure StartGame;
   Var X,Y,Row,Col:Integer;
   begin
      Repeat
         Over:=False;
         Interupted:=False;
         DrawBoard;
         For Row:=1 to TotalRows do
         begin
            For Col:=1 to TotalColumns do
            begin
               A[Row,Col].Num:=0;
               A[Row,Col].Opened:=False;
               A[Row,Col].Mistaken:=False;
               A[Row,Col].Suspended1:=False;
               A[Row,Col].Suspended2:=False;
            end;
         end;
         Randomize;
         Row:=Random(TotalRows)+1;
         Col:=Random(TotalColumns)+1;
         X:=InitialX+(Col-1)*Dim;
         Y:=InitialY+(Row-1)*Dim;
         DrawNewIndicator(X,Y);
         Repeat
            Repeat
               Ch:=Readkey;
            Until ((Ch in [#72,#75,#77,#80]) or (Ord(Ch) in [13,83,115]));
            If (Ch in [#72,#75,#77,#80]) then
               MoveIndicator(X,Y,Row,Col,Ch)
            Else if (Ord(Ch)=13) then
            begin
               Allocate(Row,Col);
               A[Row,Col].Opened:=True;
               DrawOpened(X,Y,Row,Col);
               FreeCounter:=1;
               DrawNewIndicator(X,Y);
               If (A[Row,Col].Num=0) then
                  OpenSurrounding(X,Y,Row,Col);
               If (FreeCounter=FreeSpaces) then
               begin
                  Over:=True;
                  Success;
               end;
            end
            Else Warning;
         Until ((Ord(Ch)=13) or (Interupted));
         If (Ord(Ch)=13) then
         begin
            Timer(1);
            Repeat
               Play(X,Y,Row,Col);
            Until ((Over) or (Interupted));
         end;
         SetColor(15);
         SetTextStyle(DefaultFont,HorizDir,1);
         If Interupted then
         begin
            OutTextXY(210,FinalY+25,'Вы покинули игру!');
            OutTextXY(190,FinalY+45,'Хотите сыграть ещё раз? (Y/N)');
         end
         Else
            OutTextXY(190,FinalY+60,'Хотите сыграть ещё раз? (Y/N)');
         Repeat
            Ch:=Readkey;
         Until (Ord(Ch) in [78,89,110,121]);
         If (Ord(Ch) in [89,121]) then
         begin
            If Interupted then OutTextXY(450,FinalY+45,'y');
            SetColor(0);  OutTextXY(190,FinalY+60,'Хотите сыграть ещё раз? (Y/N)');
            SetColor(15); OutTextXY(220,FinalY+60,'Какой уровень? (1,2 or 3)');
            Repeat
               Ch:=Readkey;
            Until (Ord(Ch) in [49,50,51]);
            SetData(Ord(Ch)-48);
         end;
      Until (Ord(Ch) in [78,110]);
      ClearDevice;
      CloseGraph;
   end;
{****************************************************************************}
BEGIN{Main Program}
   OpenGraphics;
   WelComing;
   StartGame;
END.{Main Program}
