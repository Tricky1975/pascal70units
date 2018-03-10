{ --- START LICENSE BLOCK ---
  conv.pas
  
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
unit conv;


interface

	function jbval(a:string):integer;
	function jbstr(a:longint):string;
	
	function jupper(a:string):string;
	
implementation

	function jbval;
	var
		code,v:integer;
	begin
		val(a,v,code);
		 if code <> 0 then
			Writeln('Error at position: ', Code);
		jbval:=v
	end;
	
	
	function jbstr;
	var 
		r:string;
	begin
		str(a,r);
		jbstr:=r
	end;
	
	
	function jupper;
	var
		r:string;
		i:integer;
	begin
		r:=a;
		for i:=1 to length(r) do r[i]:=upcase(r[i]);
		jupper:=r;
	end;
	
end.
