program pizza_tests;

{$mode objfpc}{$H+}

uses
  Classes, consoletestrunner, fpcunittestinsight, jsonparser, test_pdc;

type

  { TMyTestRunner }

  TMyTestRunner = class(TTestRunner)
  protected
  // override the protected methods of TTestRunner to customize its behavior
  end;

var
  Application: TMyTestRunner;

begin
  if IsTestInsightListening() then
    RunRegisteredTests('','')
  else
    begin
    DefaultRunAllTests:=True;
    DefaultFormat:=fPlain;
    Application := TMyTestRunner.Create(nil);
    Application.Initialize;
    Application.Title := 'Pizza Dough Calculator Tests';
    Application.Run;
    Application.Free;
    end;
end.
