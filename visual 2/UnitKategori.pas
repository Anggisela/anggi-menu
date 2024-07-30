unit UnitKategori;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons;

type
  TFormKategori = class(TForm)
    edt1: TEdit;
    lbl1: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    dbgrd1: TDBGrid;
    lbl2: TLabel;
    edt2: TEdit;
    btn4: TButton;
    btn5: TBitBtn;
    btn6: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure bersih;
    procedure posisiawal;
    procedure FormShow(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure edt2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormKategori: TFormKategori;
  a: string;

implementation

uses
  UnitDataModule;

{$R *.dfm}

procedure TFormKategori.bersih;
begin
  edt1.Clear
end;

procedure TFormKategori.btn1Click(Sender: TObject);
begin
if edt1.Text = '' then
begin
  ShowMessage('Nama Kategori Tidak Boleh Kosong!');
end else
if DataModule1.Zkategori.Locate('name',edt1.Text,[]) then
begin
  ShowMessage('Nama Kategori '+edt1.Text+' Sudah Ada Didalam Sistem');
end else
Begin // simpan
  with DataModule1.Zkategori do
  begin
    SQL.Clear;
    SQL.Add('insert into kategori values(null,"'+edt1.Text+'")');
    ExecSQL;
    SQL.Clear;
    SQL.Add('select * from kategori');
    Open;
  end;
    ShowMessage('Data Berhasil Disimpan');
posisiawal;
end;
end;

procedure TFormKategori.btn2Click(Sender: TObject);
begin
if edt1.Text = '' then
begin
  ShowMessage('Nama Kategori Tidak Boleh Kosong!');
end else
if edt1.Text = DataModule1.Zkategori.Fields[1].AsString then
begin
  ShowMessage('Nama Kategori '+edt1.Text+' Tidak Ada Perubahan');
end else
begin //kode update
  with DataModule1.Zkategori do
  begin
    SQL.Clear;
    SQL.Add('update kategori set name="'+edt1.text+'" where id= "'+a+'"');
    ExecSQL ;

    SQL.Clear;
    SQL.Add('select * from kategori');
    Open;
  end;
  ShowMessage('Data Berhasil Diupdate!');
posisiawal;
end;end;

procedure TFormKategori.btn3Click(Sender: TObject);
begin  //kode delete
if MessageDlg('Apakah Anda Yakin Menghapus Data ini',mtWarning,[mbYes,mbNo],0)=mryes then
begin
  with DataModule1.Zkategori do
  begin
    SQL.Clear;
    SQL.Add('delete from kategori where id= "'+a+'"');
    ExecSQL ;

    SQL.Clear;
    SQL.Add('select * from kategori');
    Open;
  end;
  ShowMessage('Data Berhasil DiDelete!');
end else
begin
  ShowMessage('Data Batal Dihapus!');
end;
posisiawal;end;

procedure TFormKategori.dbgrd1CellClick(Column: TColumn);
begin
edt1.Text:= DataModule1.Zkategori.Fields[1].AsString;
a:= DataModule1.Zkategori.Fields[0].AsString;

edt1.Enabled:= True;
btn2.Enabled:= True;
btn3.Enabled:=True;
btn5.Enabled:= True;
btn6.Enabled:= False;
btn1.Enabled:= False;
end;


procedure TFormKategori.FormShow(Sender: TObject);
begin
posisiawal;
end;

procedure TFormKategori.posisiawal;
begin
  bersih;
  btn6.Enabled:= True;
  btn1.Enabled:= false;
  btn2.Enabled:= false;
  btn5.Enabled:= false;
  btn3.Enabled:= false;
  edt1.Enabled:= False;
end;


procedure TFormKategori.btn6Click(Sender: TObject);
begin
edt1.Enabled:= True;
btn1.Enabled:= True;
btn2.Enabled:= False;
btn3.Enabled:= False;
btn5.Enabled:= True;
btn6.Enabled:= False;
end;


procedure TFormKategori.btn4Click(Sender: TObject);
begin
  with DataModule1.Zkategori do
  begin
    SQL.Clear;
    SQL.Add('select * from kategori where name = "'+edt1.Text+'"');
    Open;
  end;end;

procedure TFormKategori.edt2Change(Sender: TObject);
begin
  with DataModule1.Zkategori do
  begin
    SQL.Clear;
    SQL.Add('select * from kategori where name like "%'+edt2.Text+'%"');
    Open;
  end;
end;
end.
