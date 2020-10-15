program SetPage;
uses graph,crt;
var i,j,R,Dx,Dy,Err:integer;
    x,y:word;
begin
     i:=3; j:=0;
     InitGraph(i,j,'');
     Err:=GraphResult;
     if Err<>grOK then
        WriteLn (GraphErrorMsg(Err))
     else
         begin
              GetAspectRatio(x,y);
              R:=5;
              for i:=0 to 15 do
                  begin
                       SetActivePage(i);
                       Circle(320,100,100);
                       Dx:=320+Round(30*Cos(i*2*Pi/16)*y/x);
                       Dy:=100-Round(30*Sin(i*2*Pi/16));
                       FillEllipse(Dx,Dy,R*Round(y/x),R);
                  end;
                  while not KeyPressed=True do
                        for i:=0 to 15 do
                            begin
                                 SetVisualPage(i);
                                 Delay(10);
                            end;
     CloseGraph;
     end
end.