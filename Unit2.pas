unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Memo3: TMemo;
    Memo5: TMemo;
    Memo6: TMemo;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

  var FileIn,FileEx:file of byte;
  Currbyte, Outbyte:byte;
  readbyte:integer;
  s1,s2,s3:string;
  k1,k2,k3:integer;

implementation
{$R *.dfm}








procedure TForm2.Button1Click(Sender: TObject);
begin
 memo2.Text:='';
//  try
    if OpenDialog1.Execute then
    begin
      Memo2.Text:=OpenDialog1.FileName;
      //dlgOpen.Free;
    end;
end;

procedure TForm2.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [ '0','1',#8]) then

begin
Key :=#0;
ShowMessage('Uncorrect symbols. Try again');
end;
end;


function from10to2(b:byte):string;
var
 s:string;
 i,ko:integer;
 //ko:extended;
begin
s:='';
ko:=128;

  for i := 1 to 7 do
  begin
    if (b and ko)=0 then   s:=s+'0' else  s:=s+'1';
    ko:=Round(ko/2);
  end;
  s:=s+' ';
  result:=s;

end;

   function from2to10(s:string):integer;
var n,p,i:Integer;
 begin
   n:=0;
   p:=1;
    for i:=0 to Length(S)-1 do
   begin
     n:=n+strtoint(s[Length(s)-i])*p;
     p:=p*2;
   end;
   from2to10:=n;
 end;

 function GetNextByte:integer;

begin
    if not Eof(FileIn) then
     begin
      BlockRead(FileIn, CurrByte, 1, readByte);
     // Writeln(CurrByte);

      if k2<=10 then
      begin
      inc(k2);
       s2:=s2+from10to2(CurrByte);
      end;

     end
     else readByte:=-1;


     if readbyte<>-1 then
   result:=Currbyte
     else result:=-1;
end;

 procedure WorkWithByte(key:Int64);
 var
 b:Integer;
begin

 b:=key shr 25;
 b:= b and 255;
 if k1<=10 then
begin
  inc(k1);
  s1:=s1+(from10to2(b));
end;
 Outbyte:=GetNextByte xor b;
 //Writeln(Outbyte);
 if k3<=10 then
begin
  inc(k3);
  s3:=s3+(from10to2(OutByte));
end;
 BlockWrite(FileEx,Outbyte,1);
 end;

 procedure cipher(s:string);
 var a,b,key: int64;
 i:integer;
 f1,f2:Integer;
 begin
 s1:='';
 s2:='';
 s3:='';
 k1:=0;
 k2:=0;
 k3:=0;
 a:=1 shl 2;
  b:=1 shl 24;
  key:=from2to10(s);
   while not Eof(FileIn) do
   begin

   for i:=1 to 8 do
    begin
      if a and key =0 then f1:=0 else f1:=1;
      if b and key =0 then f2:=0 else f2:=1;
      key:=key shl 1;
      key:=key+(f1 xor f2);
    end;
    WorkWithByte(key);

   end;
  // Writeln(key);
 end;
procedure TForm2.Button2Click(Sender: TObject);
var
Flags: TReplaceFlags;
begin
   If length(memo1.Text)<>25 then
   begin
   ShowMessage('Not enought numbers.Try again');
   memo1.Text:='';
   end
   else
    begin
      AssignFile(FileIn,memo2.Text);
      AssignFile(FileEx,StringReplace(memo2.Text,ExtractFileExt(memo2.Text),'(ciphered)'+ExtractFileExt(memo2.Text), Flags));
      Rewrite(FileEx);
      Reset(FileIn);
      Cipher(memo1.Text);
      CloseFile(FileIn);
      CloseFile(Fileex);
      memo5.Text:=s2;
      memo3.Text:=s1;
      memo6.Text:=s3;
    end;
end;

procedure TForm2.Button3Click(Sender: TObject);

var
Flags: TReplaceFlags;
begin
   If length(memo1.Text)<>25 then
   begin
   ShowMessage('Not enought numbers.Try again');
   memo1.Text:='';
   end
   else
    begin
      AssignFile(FileIn,memo2.Text);
      AssignFile(FileEx,StringReplace(memo2.Text,ExtractFileExt(memo2.Text),'(deciphered)'+ExtractFileExt(memo2.Text), Flags));
      Rewrite(FileEx);
      Reset(FileIn);
      Cipher(memo1.Text);
      CloseFile(FileIn);
      CloseFile(Fileex);
      memo5.Text:=s2;
      memo3.Text:=s1;
      memo6.Text:=s3;
    end;
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
memo1.Text:='';
memo2.Text:='';
memo3.Text:='';
memo5.Text:='';
memo6.Text:='';
end;


end.
