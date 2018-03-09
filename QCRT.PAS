{ QUICK CRT
 
  Just a few additions to be lazy in CRT access ;)
  (c) Jeroen P. Broks
  zlib licensed!

}

unit qcrt;


interface

uses crt;

	procedure Color(foreground,background:integer);
	procedure WriteXY(x,y:byte;text:string);



implementation

	procedure Color(foreground,background:integer);
	begin
		TextColor(foreground);
		TextBackGround(background)
	end;

	procedure WriteXY(x,y:byte;text:string);
	var ox,oy:byte;
	begin
		ox:=WhereX;
		oy:=WhereY;
		GotoXY(x,y);
		Write(text);
		GotoXY(ox,oy)
	end;


end.
