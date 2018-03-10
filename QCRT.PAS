{ --- START LICENSE BLOCK ---
  QCRT.PAS
  Quick CRT
  version: 18.03.10
  Copyright (C) 2018 Jeroen P. Broks
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
  --- END LICENSE BLOCK --- } 
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
	function  GetKey:string;
	
	{3rd party stuff}
	procedure turn_off_cursor;
	procedure turn_on_cursor;



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
	
	function GetKey:string;
	var ret:string;
	begin
		ret:='';
		if KeyPressed then ret:=WaitKey;
		GetKey:=ret;
	end;
	
	
{The code below is not mine, but was written by JAB@ib.rl.ac.uk}
procedure turn_off_cursor;
  var num : word;
  begin
    port[$03D4]:=$0A; num:=port[$03D5];
    port[$03D4]:=$0A; port[$03D5]:=num or 32;
  end;
  {}
 procedure turn_on_cursor;
  var num : word;
  begin
    port[$03D4]:=$0A; num:=port[$03D5];
    port[$03D4]:=$0A; port[$03D5]:=num xor 32;
  end;

end.
