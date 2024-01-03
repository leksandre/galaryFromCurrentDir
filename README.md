//скрыть это бесящую иконку

procedure TForm1.Button2Click(Sender: TObject);
begin
 ShowWindow(FindWindow(nil, 'Program Manager'), SW_HIDE);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
ShowWindow(FindWindow(nil, 'Program Manager'), SW_SHOW);
end;
