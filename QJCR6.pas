{ --- START LICENSE BLOCK ---
  QJCR6.pas
  Quick JCR6 reader
  version: 18.03.09
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
unit qjcr6;

{
* This is a very simplistic unit for the JCR6 file system.
* It can only process non-compressed JCR6 files
* It has no modular support, so it won't be possible to add any 
* compression modules to it.
}


interface

	uses 
		TReadStr;
	
	procedure JCR_OpenDir(var ret:file;filename:string);


implementation

	procedure J_CRASH(error:string);
	begin
		WriteLn('JCR Error');
		WriteLn(error);
		halt(1);
	end;

	procedure JCR_OpenDir;
	var
		ecatch:integer;
		header:array[0..5] of Char;
		fatoffset:longint;
		fat_size,fat_csize:longint;
		fat_storage:string;
	begin
		{ Open the file and throw and error if it doesn't exist}
		assign(ret,filename);
		{$I-}
		reset(ret,1);
		{$I+}
		ECatch:=IOResult;
		if ECatch=2 then J_Crash('File not found: '+filename);
		if ECatch>0 then J_Crash('Error opening file');
		
		{ Is this an actual JCR6 file? }
		blockread(ret,header,5); 
		if not( (header[0]='J') and (header[1]='C') and (header[2]='R') and (header[3]='6') and (header[4]=#26) ) then begin
			close(ret);
			J_Crash(filename+': has not be recognized as a JCR6 resource file')
		end;
		
		{ Let's get the FAT offset }
		blockread(ret,fatoffset,sizeof(fatoffset));
		if fatoffset<=0 then begin
			close(ret);
			J_CRASH('Invalid offset')
		end;
		
		{ Now there is room for some extra config but this simplistic version of JCR6 will ignore all 
		  that crap and go straight into business }
		seek(ret,fatoffset);
		
		blockread(ret,fat_size ,sizeof(longint));
		blockread(ret,fat_csize,sizeof(longint));
		TrickyReadString(ret,fat_storage);
		if fat_storage<>'Store' then begin
			close(ret);
			J_Crash('Resource is packed with the ' +
						fat_storage+
						' algorithm, and this JCR6 unit only supports non-compressed resources')
		end;
		if fat_size<>fat_csize then begin
			close(ret);
			J_Crash('Invalid FAT size data');
		end;
		
		{ From here we can begin to work, so this procedure comes at an end }
	end;



end.
