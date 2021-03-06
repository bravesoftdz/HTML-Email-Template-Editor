unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, {Vcl.Forms,} Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  EditDesigner, Vcl.OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, ShellAPI,
  Forms, Unit3;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Saveto1: TMenuItem;
    Exit1: TMenuItem;
    Insert1: TMenuItem;
    Hyperlink1: TMenuItem;
    Image1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    EmbeddedWB1: TEmbeddedWB;
    EditDesigner1: TEditDesigner;
    Splitter1: TSplitter;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    btnConnect: TButton;
    btnDisconnect: TButton;
    UpdateTemplates1: TMenuItem;
    Checkforupdates1: TMenuItem;
    ViewTemplates1: TMenuItem;
    FileOpenDialog1: TFileOpenDialog;
    procedure EditDesigner1InnerHtml(const innerHtml: string);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Hyperlink1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Saveto1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure EmbeddedWB1DragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.About1Click(Sender: TObject);
begin
  Unit3.Form3.ShowModal;
end;

procedure TForm1.btnConnectClick(Sender: TObject);
var
  sFileName: string;
begin
//  sFileName := ExtractFilePath(Paramstr(0)) + 'Template_Library\email.html';
//  EmbeddedWB1.LoadFromFile(sFileName);
  if EditDesigner1.ConnectDesigner = S_OK then
  begin
    btnConnect.Enabled := False;
    btnDisconnect.Enabled := not btnConnect.Enabled;
  end;
end;

procedure TForm1.btnDisconnectClick(Sender: TObject);
begin
  if EditDesigner1.RemoveDesigner = S_OK then
  begin
    btnDisconnect.Enabled := False;
    btnConnect.Enabled := not btnDisconnect.Enabled;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  sFileName: string;
begin
  try
    sFileName := ExtractFilePath(Paramstr(0)) + 'Template_Library\email.html';
    if ComboBox1.ItemIndex = 0 then
    begin
      EditDesigner1.ConnectDesigner;
      EmbeddedWB1.LoadFromFile(sFileName);
      EmbeddedWB1.SetFocus;
    end;
  except
    ShowMessage('Error while Saving.')
  end;
end;

procedure TForm1.EditDesigner1InnerHtml(const innerHtml: string);
begin
  Memo1.Lines.Text := innerHtml;
end;

procedure TForm1.EmbeddedWB1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  // ShowMessage('hello');
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Hyperlink1Click(Sender: TObject);
begin
  EditDesigner1.InsertHyperlink;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  EditDesigner1.InsertImage;
end;

procedure TForm1.Open1Click(Sender: TObject);
var
  sFileName: string;
begin
  FileOpenDialog1.Execute;
  sFileName := FileOpenDialog1.FileName;
  EmbeddedWB1.LoadFromFile(sFileName);
end;

procedure TForm1.Saveto1Click(Sender: TObject);
var
  sFileName: string;
begin
  try
    sFileName := ExtractFilePath(Paramstr(0)) + 'Modified\Demo.html';
    if EditDesigner1.SaveToFile(sFileName) = S_OK then
      ShellExecute(Forms.Application.Handle, 'explore', PChar(sFileName), nil,
        nil, SW_SHOWNORMAL);
  except
    ShowMessage('Error while Saving.')
  end;
end;

end.
