unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, Grids;

type
  TForm1 = class(TForm)
    btn1: TButton;
    strngrd1: TStringGrid;
    txt1: TStaticText;
    txt2: TStaticText;
    txt3: TStaticText;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    txt4: TStaticText;
    edt5: TEdit;
    txt5: TStaticText;
    edt6: TEdit;
    edt7: TEdit;
    txt6: TStaticText;
    edt8: TEdit;
    txt7: TStaticText;
    edt9: TEdit;
    txt8: TStaticText;
    txt9: TStaticText;
    edt10: TEdit;
    edt11: TEdit;
    txt10: TStaticText;
    txt11: TStaticText;
    edt12: TEdit;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function pp(xi:real): real;
begin
  pp:= 0;
end;

function qi(xi:real): real;
begin
  qi:= -1;
end;

function fi(xi:real): real;
begin
  fi:= xi;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  N, i: Integer;
  s: string;
  h, Aa, a, Bb, b: Real;
  Alpha, Beta, y, x, c, d, m, nn, p, q, f :array [0..100] of Real;
begin
  strngrd1.Visible:= True;
  N:= StrToInt(edt12.Text);
  a:= StrToFloat(edt10.Text);
  b:= StrToFloat(edt11.Text);
  Alpha[0]:= StrToFloat(edt4.Text);
  Alpha[1]:= StrToFloat(edt5.Text);
  Beta[0]:= StrToFloat(edt7.Text);
  Beta[1]:= StrToFloat(edt8.Text);
  h:= (b-a)/N;
  Aa:= StrToFloat(edt6.Text);
  Bb:= StrToFloat(edt9.Text);
  y[0]:= Aa;
  y[N]:= Bb;
  x[0]:= a;


  for i:=1 to N do
  begin
    x[i]:= x[0] + i*h;
  end;

  for i:=0 to N do
  begin
    p[i]:= pp(x[i]);
    q[i]:= qi(x[i]);
    f[i]:= fi(x[i]);
  end;

  for i:= 0 to N do
  begin
    m[i]:= -(2-q[i]*(h*h))/(1-(p[i]/2)*h);
    nn[i]:= (1-(p[i]/2)*h)/(1+(p[i]/2)*h);
    f[i]:= f[i]/(1+(p[i]/2)*h);
  end;

  c[0]:= Alpha[1]/(Alpha[0]*h-Alpha[1]);
  d[0]:= 999999;
  c[1]:= 1/m[1];
  d[1]:= f[1]*(h*h)-nn[1]*Aa;

  for i:= 2 to N-1 do
  begin
    c[i]:= 1/(m[i]-nn[i]*c[i-1]);
    d[i]:= f[i]*(h*h)-nn[i]*c[i-1]*d[i-1];
  end;

  strngrd1.ColCount:= N+2;
  strngrd1.RowCount:= 4;
  strngrd1.Cells[0,0]:= 'i';
  strngrd1.Cells[0,1]:= 'C';
  strngrd1.Cells[0,2]:= 'd';
  strngrd1.Cells[0,3]:= 'Y';

  for i:= N-1 downto 1 do
  begin
    y[i]:= c[i]*(d[i]-y[i+1]);
  end;

  for i:=0 to N+1 do
  begin
    str(c[i]:10:3,s);
    strngrd1.Cells[i+1,1]:= s;
    str(d[i]:10:3,s);
    strngrd1.Cells[i+1,2]:= s;
    str(y[i]:10:3,s);
    strngrd1.Cells[i+1,3]:= s;
    strngrd1.Cells[i+1,0]:= IntToStr(i);
  end;
end;

end.
