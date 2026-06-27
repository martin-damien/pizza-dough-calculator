unit about;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
    LCLIntf, LCLTranslator;

type

    { TAboutForm }

    TAboutForm = class(TForm)
        Image1: TImage;
        Label1: TLabel;
        RepositoryURLLabel: TLabel;
        procedure Button1Click(Sender: TObject);
        procedure RepositoryURLLabelClick(Sender: TObject);
    private

    public

    end;

var
    AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.Button1Click(Sender: TObject);
begin
    self.Free;
end;

procedure TAboutForm.RepositoryURLLabelClick(Sender: TObject);
begin
    OpenURL(RepositoryURLLabel.Caption);
end;

end.

