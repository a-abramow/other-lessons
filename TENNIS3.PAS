program tennisEGAbyDrSlayer(c);
uses crt,graph;
label beg,beg1;
const r=5;
var
    gd,gm,mx,my,count,vx,vx2,ct1,ct2,sc1,sc2,n,mushz:integer;
    musms:longint;
    xc,yc,vcx,vcy,v:integer;
    score1,score2,win,num,vs:string;
    x,y:array [1..4] of integer;
    music:text;

procedure bum(hz,ms:integer);
begin
  sound(hz);
  delay(ms);
  nosound;
end;

procedure draw(c:integer);
begin
  setfillstyle(1,c);
  bar(x[1],y[1],x[2],y[2]);
  setcolor(0);
  outtextXY(x[1]+(round((x[2]-x[1])/2))-1,y[1]+(round((y[2]-y[1])/5)),'1');
  setfillstyle(1,c);
  bar(x[3],y[3],x[4],y[4]);
  setcolor(0);
  outtextXY(x[3]+(round((x[4]-x[3])/2))-1,y[3]+(round((y[4]-y[3])/5)),'2');
end;

procedure move(ch:char);
begin
  begin
    case ch of
      '1': vx2:=-6-v;
      '2': vx2:=6+v;
      'q': halt(0);
    end;
  end;
end;

procedure move1(ch:char);
begin
  begin
    case ch of
      'z': vx:=-6-v;
      'x': vx:=6+v;
      '1': vx2:=-6-v;
      '2': vx2:=6+v;
      'q': halt(0);
    end;
  end;
end;


procedure drawcir(c:integer);
begin
  setcolor(c);
  setfillstyle(1,c);
  fillellipse(xc,yc,r,r);
end;


procedure init;
begin
  x[2]:=x[1]+100; y[2]:=y[1]+10;
  x[4]:=x[3]+100; y[4]:=y[3]+10;
end;

procedure score;
begin
  if sc1=sc2 then
  begin
    ct1:=15;
    ct2:=15;
  end;
  if sc1>sc2 then
  begin
    ct1:=green;
    ct2:=red;
  end;
  if sc1<sc2 then
  begin
    ct1:=red;
    ct2:=green;
  end;
  str(sc1,score1);
  str(sc2,score2);
  setcolor(ct1);
  outtextXY(100,round(my/4),score1);
  setcolor(ct2);
  outtextXY(mx-100,round(my*3/4),score2);
end;



procedure inits;
begin
  xc:=round(mx/2); yc:=round(my/2);
  vcx:=round((random(3)-1)*v); vcy:=round((random(3)-1)*v);
  while vcx=0 do vcx:=round((random(3)-1)*v);
  while vcy=0 do vcy:=round((random(3)-1)*v);
  x[1]:=round(mx/2-50); y[1]:=10;
  x[3]:=round(mx/2-50); y[3]:=my-10;
  init;
  vx:=0; vx2:=0;
end;


begin
  gd:=ega; gm:=egahi;
  initgraph(gd,gm,'');
  randomize;
  mx:=getmaxX; my:=getmaxY;
beg:
  outtextxy(round(getmaxx/2)-90,round(getmaxy/2)-10,'Уровень сложности (1-9):');
  v:=ord(readkey)-ord('0');
  str(v,vs);
  outtextxy(round(getmaxx/2)+105,round(getmaxy/2)-10,vs);
  delay(1000);
  cleardevice;
beg1:
  outtextXY(round(mx/2)-180,round(getmaxy/2)-10,'Нажмите A чтобы начать игру с компьютером.');
  outtextXY(round(mx/2)-180,round(getmaxy/2)+5,'Нажмите B чтобы начать игру с другим игроком.');
  case ord(readkey) of
97:
  begin
  inits;
  repeat
    setactivepage(count);
    cleardevice;
    line(1,1,1,my-1);
    line(mx-1,1,mx-1,my-1);
    if yc<round(getmaxy*2/5) then
    begin
      if xc-round((x[2]-x[1])/2+x[1])<0 then vx:=-6-v
      else vx:=6+v;
      if (x[2]+vx<getmaxx) and (x[1]+vx>0) then
      begin
        x[2]:=x[2]+vx;
        x[1]:=x[1]+vx;
      end;
    end
    else vx:=0;
    if (x[4]+vx2<getmaxx) and (x[3]+vx2>0) then
    begin
      x[4]:=x[4]+vx2;
      x[3]:=x[3]+vx2;
    end;
    draw(15);
    score;

    if (getpixel(xc+r+1,yc)<>0) or (getpixel(xc-r-1,yc)<>0) then
    begin
      bum(1000,20);
      vcx:=-vcx;
    end;
    if (getpixel(xc,yc+r+1)<>0) or (getpixel(xc,yc-r-1)<>0) then
    begin
      bum(1000,20);
      vcy:=-vcy;
    end;


    if (xc+r+1>=getmaxx) or (xc-r-1<=0) then
    begin
      bum(1000,20);
      vcx:=-vcx;
    end;
    drawcir(15);

    setvisualpage(count);
    if keypressed then move(readkey);
    if yc-r>my then
    begin
      bum(500,20);
      sc1:=sc1+1;
      inits;
    end;
    if yc+r<0 then
    begin
      bum(500,20);
      sc2:=sc2+1;
      inits;
    end;
    xc:=xc+vcx; yc:=yc+vcy;
    delay(3000);
    count:=(count+1) mod 2;
  until (sc1=10) or (sc2=10);
  end;

98:
  begin
  inits;
  repeat
    setactivepage(count);
    cleardevice;
    drawcir(15);
    line(1,1,1,my-1);
    line(mx-1,1,mx-1,my-1);

    if (x[2]+vx<getmaxx) and (x[1]+vx>0) then
    begin
      x[2]:=x[2]+vx;
      x[1]:=x[1]+vx;
    end;
    if (x[4]+vx2<getmaxx) and (x[3]+vx2>0) then
    begin
      x[4]:=x[4]+vx2;
      x[3]:=x[3]+vx2;
    end;
    draw(15);
    score;

    if (getpixel(xc+r+1,yc)<>0) or (getpixel(xc-r-1,yc)<>0) then
    begin
      bum(1000,20);
      vcx:=-vcx;
    end;
    if (getpixel(xc,yc+r+1)<>0) or (getpixel(xc,yc-r-1)<>0) then
    begin
      bum(1000,20);
      vcy:=-vcy;
    end;


    if (xc+r+1>=getmaxx) or (xc-r-1<=0) then
    begin
      bum(1000,20);
      vcx:=-vcx;
    end;


    setvisualpage(count);
    if keypressed then move1(readkey);
    if yc-r>my then
    begin
      bum(500,20);
      sc1:=sc1+1;
      inits;
    end;
    if yc+r<0 then
    begin
      bum(500,20);
      sc2:=sc2+1;
      inits;
    end;
    xc:=xc+vcx; yc:=yc+vcy;
    delay(3000);
    count:=(count+1) mod 2;
  until (sc1=10) or (sc2=10);
  end
  else goto beg1;
  end;



  if sc1=10 then n:=1
  else n:=2;
  str(n,win);
  num:='Player ';
  num:=num+win+' WIN!!!';
  assign(music,'music.rec');
  reset(music);
  cleardevice;
    repeat
      setcolor(15);
      outtextXY(round(mx/2)-50,round(my/2)-1,num);
      outtextXY(round(mx/2)-85,50,'Нажмите A чтобы начать игру заново.');
      outtextXY(round(mx/2)-60,65,'Нажмите B чтобы выйти.');
      readln(music,mushz);
      readln(music,musms);
      bum(mushz,musms);
      if keypressed then
      begin
        if ord(readkey)=ord('a') then goto beg;
        if ord(readkey)=ord('b') then halt(0);
      end;
    until eof(music);
  closegraph;
  close(music);
end.