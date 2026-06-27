{
      Pizza Dough Calculator - Yeast unit

      This file includes an implementation of a yeast calculation algorithm
      inspired by the RafCalc project:
      https://github.com/Rafbor42/RafCalc

      Original author:
      Copyright (C) Raphael Borrelli (@Rafbor)

      Adaptation and integration:
      Copyright (C) 2026 Damien MARTIN

      This program is free software: you can redistribute it and/or modify
      it under the terms of the GNU General Public License as published by
      the Free Software Foundation, either version 3 of the License, or
      (at your option) any later version.

      This program is distributed in the hope that it will be useful,
      but WITHOUT ANY WARRANTY; without even the implied warranty of
      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

      See the GNU General Public License for more details.

      You should have received a copy of the GNU General Public License
      along with this program. If not, see <https://www.gnu.org/licenses/>.
}

unit yeast;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Math;

const
    YEAST_CALIBRATION_COEFFICIENT = 2250;
    HYDRATION_QUADRATIC_COEFFICIENT = 0.0305;

type
    TYeastType = (FreshYeast, ActiveDryYeast);

    TInputIngredients = record
        salt, hydration: Double;
        dough, weight, fermentationDuration, fermentationTemperature: Integer;
        yeastType: TYeastType;
    end;

    TOutputIngredients = record
        flour, water, salt, yeast: Double;
    end;

function CalculateQuantities(inputIngredients: TInputIngredients): TOutputIngredients;
function CalculateYeast(Flour, hydration, salt, temperature, duration: Double): Double;
function ApplyYeastAdjustmentForFermentationDuration(yeast, FermentationDuration: Double): Double;
function AdjustYeastByType(yeast: Double; askedType: TYeastType): Double;

implementation

function CalculateQuantities(inputIngredients: TInputIngredients): TOutputIngredients;
var
    outputIngredients: TOutputIngredients;
    totalDough: Integer;
    hydration, salt: Double; { salt is salt ratio in % }
begin
    totalDough := inputIngredients.dough * inputIngredients.weight;
    hydration := inputIngredients.hydration / 100;
    salt := inputIngredients.salt / 100;

    outputIngredients.flour := totalDough / ( 1 + hydration + salt );
    outputIngredients.water := outputIngredients.flour * hydration;
    outputIngredients.salt := outputIngredients.flour * salt;
    outputIngredients.yeast := CalculateYeast(
        outputIngredients.flour,
        inputIngredients.hydration,
        salt,
        inputIngredients.fermentationTemperature,
        inputIngredients.fermentationDuration
    );
    outputIngredients.yeast := AdjustYeastByType(outputIngredients.yeast, inputIngredients.yeastType);

    Result := outputIngredients;
end;

function CalculateYeast(flour, hydration, salt, temperature, duration: Double): Double;
var
    saltPerLiter, hydrationFactor: Double;
begin
    saltPerLiter := (salt / (hydration / 100)) * 1000;
    hydrationFactor := -80 + 4.2 * hydration - HYDRATION_QUADRATIC_COEFFICIENT * Power(hydration, 2);

    Result := flour * YEAST_CALIBRATION_COEFFICIENT;
    Result := Result * (1 + saltPerLiter / 200);
    Result := Result / (hydrationFactor * Power(temperature, 2.5) * Power(duration, 1.2));
    Result := ApplyYeastAdjustmentForFermentationDuration(Result, duration);
end;

{
    The japi2 protocol from RafCalc is really optimistic and error prone for
    casual pizza makers.

    This function aims to apply a multiplicator based on the fermentation
    duration.

    The result is bigger than the original but the quantity is still small and
    the dough will not tasts yeast.
}
function ApplyYeastAdjustmentForFermentationDuration(yeast, fermentationDuration: Double): Double;
begin
    if fermentationDuration <= 6 then
       Result := yeast * 1.0
    else if fermentationDuration <= 24 then
         Result := yeast * 1.8
    else
        Result := yeast * 2.2;
end;

function AdjustYeastByType(yeast: Double; askedType: TYeastType): Double;
begin
    Result := yeast;

    if askedType = ActiveDryYeast then
        Result := Result * 0.4;
end;

end.

