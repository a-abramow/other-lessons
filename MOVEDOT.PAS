uses crt, graph;
var device, mode,x,y,d: integer;
    button  : char;
begin
  device:=0;
  InitGraph(device, mode,'');
  x:=320;
  y:=240;
  d:=1;
  PutPixel(x,y,Green);
  repeat
    if keyPressed then begin
      { PutPixel(x,y,Black);}
       button:=Readkey;
       if button='d' then x:=x+d;
       if button='a' then x:=x-d;
       if button='s' then y:=y+d;
       if button='w' then y:=y-d;
       PutPixel(x,y,Green);
    end{if};
  until button='q';
end.