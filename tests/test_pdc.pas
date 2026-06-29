unit test_pdc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, fpcunit, testutils, testregistry, pdc;

type

    TTestPDC= class(TTestCase)
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure TestYeastAdjustmentForFermentationDuration;
        procedure TestYeastConversion;
    end;

implementation

procedure TTestPDC.TestYeastConversion;
begin
    AssertEquals(5, AdjustYeastByType(5, FreshYeast));
    AssertEquals(4, AdjustYeastByType(10, ActiveDryYeast));
end;

procedure TTestPDC.TestYeastAdjustmentForFermentationDuration;
begin
    AssertEquals(10, ApplyYeastAdjustmentForFermentationDuration(10, 4));
    AssertEquals(18, ApplyYeastAdjustmentForFermentationDuration(10, 8));
    AssertEquals(22, ApplyYeastAdjustmentForFermentationDuration(10, 48));
end;

procedure TTestPDC.SetUp;
begin

end;

procedure TTestPDC.TearDown;
begin

end;

initialization

    RegisterTest(TTestPDC);
end.

