program StringTest;

{$APPTYPE CONSOLE}

uses
  SysUtils;

procedure Proc(S1: String; const S2: String; var S3: String;
               S4: String; const S5: String; var S6: String;
               out S7: String);
begin
  S7 := '1' + S1 + '2' + S2 + '3' + S3 + '4' + S4 + '5' +S5 + '6' + S6;
end;

procedure Work;
var
  S: String;
begin
  S := 'S';
  Proc(S, S, S, S, S, S, S);
  writeln(S);
end;

begin
  Work;
  readln;
end.
 