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
	procedure CenterText(x,y:byte;text:string);
	procedure CLS;
	function  WaitKey:string;



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
	
	procedure CLS; begin ClrScr end;
	
	procedure CenterText(x,y:byte;text:string);
	var 
		l:byte;
		d:byte;
	begin
		l := length(text);
		d := l div 2;
		WriteXY(x-d,y,text)
	end;

	function WaitKey:string;
	var x:char;
	var x2:char;
	begin
		x:=ReadKey;
		if ord(x)>0 then 
		begin
			WaitKey:=x
		end else begin
			x2:=ReadKey;
			case x2 of
				'P': WaitKey:='Down';
				'H': WaitKey:='Up';
				'M': WaitKey:='Left';
				'K': Waitkey:='Right'
			else
				WaitKey:='Unknown'
			end
		end
	end;

end.
