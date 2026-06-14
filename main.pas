unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin, Menus, Buttons;

type

  { TMainForm }

  TMainForm = class(TForm)
    CalculateButton: TBitBtn;
    DoughGroupBox: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    YeastResultLabel: TLabel;
    FlourResultLabel: TLabel;
    WaterResultLabel: TLabel;
    SaltResultLabel: TLabel;
    LeftPanel: TPanel;
    ProportionsGroupBox: TGroupBox;
    FermentationGroupBox: TGroupBox;
    NumberOfPizzaLabel: TLabel;
    DoughWeightLabel: TLabel;
    WaterLabel: TLabel;
    SaltLabel: TLabel;
    FermentationDurationLabel: TLabel;
    TemperatureLabel: TLabel;
    DryYeastRadioButton: TRadioButton;
    FreshYeastRadioButton: TRadioButton;
    NumberOfPizzaSpinEdit: TSpinEdit;
    DoughWeightSpinEdit: TSpinEdit;
    WaterSpinEdit: TSpinEdit;
    SaltSpinEdit: TSpinEdit;
    FermentationDurationSpinEdit: TSpinEdit;
    TemperatureSpinEdit: TSpinEdit;
    YeastRadioGroup: TRadioGroup;
    procedure CalculateButtonClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.CalculateButtonClick(Sender: TObject);
var
  Flour, Water, Salt, Yeast, Hydration, SaltRatio, YeastRatio, YeastPercent: Real;
  TotalDough, NumberOfPizza, DoughWeight, WaterPercent, SaltPercent, FermentationDuration, RoomTemperature: Integer;
begin
  { Retrieve user data }

  NumberOfPizza := NumberOfPizzaSpinEdit.Value;
  DoughWeight := DoughWeightSpinEdit.Value;
  WaterPercent := WaterSpinEdit.Value;
  SaltPercent := SaltSpinEdit.Value;
  FermentationDuration := FermentationDurationSpinEdit.Value;
  RoomTemperature := TemperatureSpinEdit.Value;

  { Calculate quantities }

  TotalDough := NumberOfPizza * DoughWeight;
  Hydration := WaterPercent / 100;
  SaltRatio := SaltPercent / 100;

  YeastPercent := 2 / (FermentationDuration * RoomTemperature);
  YeastRatio := YeastPercent / 100;

  Flour := TotalDough / ( 1 + Hydration + SaltRatio + YeastRatio );
  Water := Flour * Hydration;
  Salt := Flour * SaltRatio;
  Yeast := Flour * YeastRatio;

  { Update UI }

  FlourResultLabel.Caption := FormatFloat('0.00', Flour) + ' g';
  WaterResultLabel.Caption := FormatFloat('0.00', Water) + ' g';
  SaltResultLabel.Caption := FormatFloat('0.00', Salt) + ' g';
  YeastResultLabel.Caption := FormatFloat('0.00', Yeast) + ' g';

end;

end.

