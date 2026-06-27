{
    Pizza Dough Calculator - Main Form

    This file contains an implementation inspired by the RafCalc project
    (https://github.com/ - if you have exact repo, you can add it here)

    Copyright (C) 2026 Damien MARTIN

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
}

unit main;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
    Spin, Menus, Buttons, LCLTranslator, DefaultTranslator, Yeast, about;

type

    { TMainForm }

    TMainForm = class(TForm)
        DoughGroupBox: TGroupBox;
        MainMenu: TMainMenu;
        HelpMenuItem: TMenuItem;
        AboutMenuItem: TMenuItem;
        QuantitiesGroupBox: TGroupBox;
        FlourGroupBox: TGroupBox;
        WaterGroupBox: TGroupBox;
        SaltGroupBox: TGroupBox;
        YeastGroupBox: TGroupBox;
        Quantities_SaltYeast_Panel: TPanel;
        Quantities_FloorWater_Panel: TPanel;
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
        procedure AboutMenuItemClick(Sender: TObject);
        procedure onInputChange(Sender: TObject);
    private
        function FormToInput: TInputIngredients;
        procedure outputToForm(outputIngredients: TOutputIngredients);
    public

    end;

var
    MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.onInputChange(Sender: TObject);
var
    inputIngredients: TInputIngredients;
    outputIngredients: TOutputIngredients;
begin
    inputIngredients := FormToInput;
    outputIngredients := CalculateQuantities(inputIngredients);
    outputToForm(outputIngredients);
end;

procedure TMainForm.AboutMenuItemClick(Sender: TObject);
var
    aboutForm: TAboutForm;
begin
    aboutForm := TAboutForm.Create(self);
    try
      aboutForm.ShowModal;
    finally
      aboutForm.Free;
    end;
end;

function TMainForm.FormToInput: TInputIngredients;
var
    input: TInputIngredients;
begin
    input.dough := NumberOfPizzaSpinEdit.value;
    input.weight := DoughWeightSpinEdit.Value;
    input.hydration := WaterSpinEdit.Value;
    input.salt := SaltSpinEdit.Value;
    input.fermentationDuration := FermentationDurationSpinEdit.Value;
    input.fermentationTemperature := TemperatureSpinEdit.Value;

    if DryYeastRadioButton.Checked then
       input.yeastType := ActiveDryYeast;
    if FreshYeastRadioButton.Checked then
       input.yeastType := FreshYeast;

    Result := input;
end;

procedure TMainForm.outputToForm(outputIngredients: TOutputIngredients);
begin
    FlourResultLabel.Caption := FormatFloat('0', outputIngredients.flour) + ' g';
    WaterResultLabel.Caption := FormatFloat('0', outputIngredients.water) + ' g';
    SaltResultLabel.Caption := FormatFloat('0.0', outputIngredients.salt) + ' g';
    YeastResultLabel.Caption := FormatFloat('0.00', outputIngredients.yeast) + ' g';
end;

end.

