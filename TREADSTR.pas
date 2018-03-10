unit TReadStr;


interface


	procedure TrickyReadString(var f:file; var value:string);
	
	
implementation


	procedure TrickyReadString;
	var 
		l,i:longint;
		b:char;
	begin
		blockread(f,l,sizeof(longint));
		value:='';
		for i:=1 to l do begin
			blockread(f,b,1);
			value:=value+b;
		end;
	end;

end.
