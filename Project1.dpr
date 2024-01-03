program Project1;

uses
  SysUtils, Controls, Forms, Dialogs;
{$R *.res}

var
work:boolean;
vFile,vdir:Longint;
maskf:string;
tuy: array [1..9999999] of WideString;
ib:longint;
shell1:variant;

procedure searsh(dir:widestring);
var f,f2:TSearchRec;
begin
if work then   begin
FindFirst(dir+'*',faAnyFile,f);
repeat
if (ExtractFileExt(f.Name)<>'') and (not(DirectoryExists(dir+f.Name))) and (Pos((ExtractFileExt(f.Name)),
'*.ani;*.bmp;*.cdr;*.clp;*.cgm;*.cur;*.dib;*.djvu;*.drw;*.dxf;*.emf;*.eps;*.gif;'+
'*.ico;*.icl;*.iff;*img;*.jpg;*.jpeg;*.lbm;*.ldf;*.lwf;*.pbm;*.pcd;*.pcx;*.pgm;*.pic;*.pct;'+
'*.png;*.ppm;*.psd;*.psp;*.qtif;*.ras;*.rgb;*.rle;*.sfw;*.tga;*.tif;*.tiff;*.wmf;*.wpg;')>0)
then
//if ('.' <> f.Name)  and ('..' <> f.Name) and ('...' <> f.Name) and ('....' <> f.Name) then
if ib <=  9999999 then begin
tuy[ib]:=dir+f.Name;
inc(ib);          end;
   //ShowMessage(dir);
if DirectoryExists(dir+f.Name+'\')
and ('.' <> f.Name)  and ('..' <> f.Name) and ('...' <> f.Name) and ('....' <> f.Name)
then
begin
inc (vDir);
searsh(dir+f.Name+'\');
end else inc (vFile);
f2:=f;
FindNext(f);
Application.ProcessMessages;
until    (f.Name=F2.Name) and (F.Size=F2.Size);

FindClose(f);
end;
end;


procedure write;
var y:Longint; hf2:textFile;
ho,ca,po,bbg:string;
kvo,wid,bor:integer;
bg:shortstring;
begin
if messagedlg('найдено '+intTostr(ib)+' изображений'+#13#10+'хотите произвести настройку документа?',mtConfirmation,[mbYes,mbNo],0)=mrno
then begin wid:=30;bor:=0;kvo:=100; bg:='000000';end else begin
wid:=StrToIntdef(InputBox('width','введите ширину иконки (попорции сохраняются)','30'),111888);
if wid=111888 then wid:=30;
bor:=StrToIntdef(InputBox('border','введите ширину рамки иконки','0'),111888);
if bor=111888 then bor:=0;
kvo:=StrToIntdef(InputBox('max value','введите максимальное количество элементов в строке','100'),111888);
if kvo=111888 then kvo:=100;
bg:=InputBox('bakground','фон, указывается шестью шестнадцатиричными числами,'+#13#10+
'рекомндуется вводить правильно,'+#13#10+
'если ввести "captur", в качестве фона будет выбрана картинка из результатов поиска','000000');
bbg:='';
if (AnsiLowerCase(bg)='"captur"')or(bg ='') then
begin
randomize;
bg:='000000'; bbg:='Body background="'+tuy[random(ib+1)]+'"';
end;                                                      end;
ho:=
'<html>      '+#13#10+
'<head>        '+#13#10+
'<title>   </title>  '+#13#10+
'<meta charset="windows-1251">  '+#13#10+

'</head>'+#13#10+
'<body bgcolor="#'+bg+'" text="black" '+bbg+'>'+#13#10+

'<form name="galary">'+#13#10+
'<p align="left">result</p>'+#13#10+
'</form>'+#13#10+
'<p>&nbsp;</p>'+#13#10
;
if ib>1 then
for y:=1 to ib do Begin
po:=tuy[y];
ca:=ExtractFileName(tuy[y]);
if y mod kvo=0 then ho:=ho+#13#10+'<br>';
Application.ProcessMessages;
ho:=ho+#13#10+
'  <a href="'+ po +'" target=_blank> <img src="'+
po+'"alt="'+
po+'" width="'+intTostr(wid)+'" border="'+intTostr(bor)+'"  bordercolor="#000000" ></a>'
end;

ho:=ho+'<p align="left">&nbsp;</p><BR>'+#13#10+'<a href="mailto:jirdis@mail.ru">написать(ударение на последний слог) автору</a> '+#13#10+
'</body>'+#13#10+
'</html> ' ;


 AssignFile(hf2,'Результаты_поиска.htm');
 rewrite(hf2);
 writeln(hf2,ho);
 Closefile(hf2);
end;

begin
  Application.Initialize;
  Application.Run;
  ib:=0;     work:=true;
   searsh(ExtractFilePath(Application.ExeName));
   write;
end.


{faReadOnly  = $00000001 platform;
faReadOnly = $00000001;
faHidden    = $00000002 platform;
faSysFile   = $00000004 platform;
faVolumeID  = $00000008 platform;
faDirectory = $00000010;
faArchive   = $00000020 platform;
faSymLink   = $00000040 platform;
faAnyFile   = $0000003F;}

{MessageBeep($FFFFFFFF);
MessageBeep(MB_ICONASTERISK);
MessageBeep(MB_ICONEXCLAMATION);
MessageBeep(MB_ICONHAND); }

{All files (*.*)|*.*
|Архивы|*.7z;*.a0?;*.ace;*.arj;*.bz2;*.cab;*.cpio;*.edc;*.gz;*.GZip;*.ha;*.ice;*.iso;
*.jar;*.lfd;*.lha;*.lof;*.lst;*.lzh;*.pk3;*.r0?;*.rar;*.rpm;*.tar;*.uc2;.uha;*.uue;*.z;*.zip;*.zoo;*.zz|
Аудио файлы|*.aif;*.au;*.cda;*.med;*.mid;*.midi;*.mod;*.mpa;*.mp3;*.ogg;*.ra;*.rmi;
*.rmx;*.rv;*.s3m;*.sfx;*.sid;*.snd;*.spc;*.voc;*.vvs;*.wav;*.wma;*.xm|
Базы данных|*.db;*.dbf;*.mdb;*.xls|
Видео файлы|*.asf;*.avi;*.divx;*.mpe*;*.mpg;*.mpg4;*.mov;*.rm;*.vob;*.wmv;*.xvid|
Временные файлы|~*.*;*.~~~;$*.*;*.$??;*.bak;*.log;*.old;*.org;*.pk;*.swp;*.tmp;*.temp;*.wbk|
Загрузочные|boot.bak;boot.ini;bootfont.bin;cmldr;ntdetect.com;ntldr|
Изображения|*.ani;*.bmp;*.cdr;*.clp;*.cgm;*.cur;*.dib;*.djvu;*.drw;*.dxf;*.emf;*.eps;*.gif;
*.ico;*.icl;*.iff;*img;*.jpg;*.jpeg;*.lbm;*.ldf;*.lwf;*.pbm;*.pcd;*.pcx;*.pgm;*.pic;*.pct;
*.png;*.ppm;*.psd;*.psp;*.qtif;*.ras;*.rgb;*.rle;*.sfw;*.tga;*.tif;*.tiff;*.wmf;*.wpg|
Исполняемые файлы|*.bat;*.cmd;*.com;*.cpl;*.exe;*.js;*.lnk;*.msi;*.pif;*.scr;*.vbs;*.wsf|
Сервисы (работающие)|*.Running|

Системные файлы|*.386;*.bin;*.cpl;*.dll;*.drv;*.ocx;*.msc;*.swp;*.sys;*.vxd|
Справочные файлы |*.hlp;*.chm|
Страницы интенета|*.css;*.htm;*.html;*.jhtml;*.mht;*.php;*.php3;*.phtm;*.phtml;*.sht;*.shtm;*.shtml;*.url;*.xhtml;*.xml|
Текстовые файлы |*.bbs;*.cfg;*.doc;*.dir;*.diz;*.htm;*.html;*.inf;*.ini;*.ion;*.log;*.me;*.nfo;*.reg;*.rtf;*.rus;*.scp;*.txt;*.wri;*.!!!|
}

