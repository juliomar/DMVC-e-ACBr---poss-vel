unit BPeController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons, Provider.BPe, Model.BPeMeu;

type

  [ MVCPath('/bpe/v1') ]
  TBPeController = class(TMVCController)
  public
    [ MVCPath ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
      //Sample CRUD Actions for a "Customer" entity
    [ MVCPath('/customers') ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure GetCustomers;

    [ MVCPath('/customers/($id)') ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure GetCustomer(id: Integer);

    [ MVCPath('/bilhetes') ]
    [ MVCHTTPMethod([ httpPOST ]) ]
    procedure CreateBrilhetes;

    [ MVCPath('/customers/($id)') ]
    [ MVCHTTPMethod([ httpPUT ]) ]
    procedure UpdateCustomer(id: Integer);

    [ MVCPath('/customers/($id)') ]
    [ MVCHTTPMethod([ httpDELETE ]) ]
    procedure DeleteCustomer(id: Integer);

  end;

implementation

uses
  System.SysUtils,
  MVCFramework.Logger,
  System.StrUtils;

procedure TBPeController.Index;
begin
  Render('<h1>DelphiMVCFramework e ACBr</h1>');
  ContentType := TMVCMediaType.TEXT_HTML;
end;

procedure TBPeController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
    { Executed after each action }
  inherited;
end;

procedure TBPeController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
    { Executed before each action
      if handled is true (or an exception is raised) the actual
     action will not be called }
  inherited;
end;

  //Sample CRUD Actions for a "Customer" entity
procedure TBPeController.GetCustomers;
begin
    //todo: render a list of customers
end;

procedure TBPeController.GetCustomer(id: Integer);
begin
    //todo: render the customer by id
end;

procedure TBPeController.CreateBrilhetes;
var
  LProviderBPe : TProviderBPe;
  LMeu : TBPeMeu;
begin
  LMeu := Context.Request.BodyAs<TBPeMeu>;
  LProviderBPe := TProviderBPe.Create(nil);

  Render( LProviderBPe.AlimentarComponente(LMeu.id.ToString));

  ContentType := TMVCMediaType.TEXT_XML;

///  Render();
end;

procedure TBPeController.UpdateCustomer(id: Integer);
begin
    //todo: update customer by id
end;

procedure TBPeController.DeleteCustomer(id: Integer);
begin
    //todo: delete customer by id
end;

end.
