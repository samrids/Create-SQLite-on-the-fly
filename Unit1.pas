unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, Vcl.StdCtrls,
  FireDAC.DApt, // Required this when create database.
  FireDAC.Phys.SQLite, Data.DB, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button2: TButton;
    Button3: TButton;
    FDConnection1: TFDConnection;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    Connection: TFDConnection;
    DriverLink: TFDPhysSQLiteDriverLink;
    Query: TFDQuery;

    FDSQLiteSecurity: TFDSQLiteSecurity;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    procedure CreatedDatabase;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  MyDBFile = 'C:\temp\db5.sqlite3';
  //'c:\temp\mesadb.db3';

procedure TForm1.CreatedDatabase;
begin
 // if FileExists(MyDBFile) then
 //   DeleteFile(MyDBFile);

  Connection.Params.Values['Database'] := MyDBFile;
  Connection.Params.Values['DriverID'] := 'SQLite';
  //Connection.Params.Values['Encrypt']  := 'aes-128';
  //Connection.Params.Values['Password'] := '1234';
  Connection.Connected := True;

  Connection.StartTransaction;
  Connection.ExecSQL('create table test1( id integer, name text( 64 ));');
  Connection.Commit;

  Connection.StartTransaction;
  Connection.ExecSQL('insert into test1(id, name) values(1, ''Jane'');');
  Connection.ExecSQL('insert into test1(id, name) values(2, ''John'');');
  Connection.ExecSQL('insert into test1(id, name) values(3, ''Cheetah'');');
  Connection.ExecSQL('insert into test1(id, name) values(4, ''Mesa'');');
  Connection.ExecSQL('insert into test1(id, name) values(5, ''Jason'');');
  Connection.ExecSQL('insert into test1(id, name) values(6, ''Bourne'');');
  Connection.Commit;

  Query.SQL.Add('select * from test1 order by id;');
  Query.active := true;
  DataSource1.DataSet := Query;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CreatedDatabase;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FDSQLiteSecurity.Database := MyDBFile;    //aes-ecb-256
  FDSQLiteSecurity.Password := 'aes-128:1234';
  FDSQLiteSecurity.SetPassword;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FDSQLiteSecurity.Database := MyDBFile; //aes-ecb-256
  FDSQLiteSecurity.Password := 'aes-128:1234';
  FDSQLiteSecurity.RemovePassword;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Connection.Free;
  DriverLink.Free;

  Query.Free;
  FDSQLiteSecurity.Free;
  FDPhysSQLiteDriverLink.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DriverLink := TFDPhysSQLiteDriverLink.Create(Self);
  Connection := TFDConnection.Create(Self);
  Query := TFDQuery.Create(Self);
  Query.Connection :=  Connection;

  FDSQLiteSecurity:= TFDSQLiteSecurity.Create(self);
  FDPhysSQLiteDriverLink:= TFDPhysSQLiteDriverLink.Create(Self);
  FDSQLiteSecurity.DriverLink := FDPhysSQLiteDriverLink;
end;

end.
