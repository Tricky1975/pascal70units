unit conv;


interface

	function jbval(a:string):integer;
	function jbstr(a:longint):string;
	
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
	
end.	
