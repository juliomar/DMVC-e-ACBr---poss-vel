unit Provider.BPe;

interface

uses
  System.SysUtils, System.Classes, ACBrBase, ACBrDFe, ACBrBPe, ACBrPosPrinter,
  ACBrDFeReport, ACBrBPeDABPEClass, ACBrBPeDABPeESCPOS;

type
  TProviderBPe = class(TDataModule)
    ACBrBPe1: TACBrBPe;
    ACBrBPeDABPeESCPOS1: TACBrBPeDABPeESCPOS;
    ACBrPosPrinter1: TACBrPosPrinter;
  private

    procedure AlimentarBPe(NumDFe: String);
    procedure AlimentarBPeTM(NumDFe: String);
  public
    function AlimentarComponente(NumDFe: String) : TStream;
  end;

//var
//  ProviderBPe: TProviderBPe;

implementation

uses pcnConversao, ACBrDFeUtil, pcnConversaoBPe;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TProviderBPe.AlimentarBPe(NumDFe: String);
begin
  with ACBrBPe1.Bilhetes.Add.BPe do
  begin
    //
    // Dados de Identificação do BP-e
    //
    Ide.cUF := UFtoCUF('SP');

    // TpcnTipoAmbiente = (taProducao, taHomologacao);
      Ide.tpAmb := taHomologacao;


    Ide.modelo  := 63;
    Ide.serie   := 1;
    Ide.nBP    := StrToIntDef(NumDFe, 0);
    Ide.cBP    := GerarCodigoDFe(Ide.nBP);
    // ( moRodoviario, moAquaviario, moFerroviario );
    Ide.modal   := moRodoviario;
    Ide.dhEmi   := Now;
    // TpcnTipoEmissao = (teNormal, teOffLine);
    Ide.tpEmis  := teNormal;
    Ide.verProc := '1.0.0.0'; //Versão do seu sistema
    Ide.indPres := pcPresencial;
    Ide.UFIni   := 'SP';
    Ide.cMunIni := 3503208;
    Ide.UFFim   := 'SP';
    Ide.cMunFim := 3550308;
    Ide.tpBPe   := tbNormal;

    //   Ide.dhCont  := Now;
//   Ide.xJust   := 'Motivo da Contingência';

    //
    // Dados do Emitente
    //
    Emit.CNPJ  := '00.000.000/0001-00';
    Emit.IE    := '123456789';
    Emit.IEST  := '';
    Emit.xNome := 'Teste';
    Emit.xFant := 'Teste';
    Emit.IM    := '123';
    Emit.CNAE  := '1234567';
    Emit.CRT   := crtRegimeNormal;
    Emit.TAR   := '';

    Emit.EnderEmit.xLgr    := 'Rua x';
    Emit.EnderEmit.Nro     := '12';
    Emit.EnderEmit.xCpl    := 'sem';
    Emit.EnderEmit.xBairro := 'Centro';
    Emit.EnderEmit.cMun    := 3550308;
    Emit.EnderEmit.xMun    := 'São Paulo';
    Emit.EnderEmit.CEP     := 08090284;
    Emit.EnderEmit.UF      := 'SP';
    Emit.EnderEmit.fone    := '321654987';
    Emit.enderEmit.email   := 'endereco@provedor.com.br';

    //
    // Dados do Comprador
    //
    Comp.xNome   := 'Nome do Comprador';
    Comp.CNPJCPF := '06760213874';
    Comp.IE      := '';

    Comp.EnderComp.xLgr    := 'Nome do Logradouro';
    Comp.EnderComp.Nro     := 'Numero';
    Comp.EnderComp.xCpl    := 'Complemento';
    Comp.EnderComp.xBairro := 'Bairro';
    Comp.EnderComp.cMun    := 3503208; //StrToInt('Codigo IBGE da cidade do comprador');
    Comp.EnderComp.xMun    := 'Nome da Cidade';
    Comp.EnderComp.CEP     := StrToIntDef('00000000', 0);
    Comp.EnderComp.UF      := 'SP';
    Comp.EnderComp.cPais   := 1058;
    Comp.EnderComp.xPais   := 'BRASIL';
    Comp.EnderComp.fone    := 'Telefone do comprador';
    Comp.enderComp.email   := 'endereco@provedor.com.br';

    //
    // Dados da Agencia
    //
    Agencia.xNome := 'Nome da Agencia';
    Agencia.CNPJ  := '00.000.000/0001-00';

    Agencia.EnderAgencia.xLgr    := 'Nome do Logradouro';
    Agencia.EnderAgencia.Nro     := 'Numero';
    Agencia.EnderAgencia.xCpl    := 'Complemento';
    Agencia.EnderAgencia.xBairro := 'Bairro';
    Agencia.EnderAgencia.cMun    := 3503208; //StrToInt('Codigo IBGE da cidade da Agencia');
    Agencia.EnderAgencia.xMun    := 'Nome da Cidade';
    Agencia.EnderAgencia.CEP     := StrToIntDef('00000000', 0);
    Agencia.EnderAgencia.UF      := 'SP';
    Agencia.EnderAgencia.fone    := 'Telefone da Agencia';
    Agencia.enderAgencia.email   := 'endereco@provedor.com.br';
    Agencia.EnderAgencia.cPais   := 1058;
    Agencia.EnderAgencia.xPais   := 'BRASIL';

    //
    // Informações do BP-e Substituido (informar se ocorrer)
    //
//   infBPeSub.chBPe := 'Chave do BPe substituido';
//   infBPeSub.tpSub := tsRemarcacao;

    //
    // Informações sobre a Passagem
    //
    infPassagem.cLocOrig := '1234567'; // Codigo da Localidade de Origem
    infPassagem.xLocOrig := 'Descrição da Localidade de Origem';
    infPassagem.cLocDest := '1234567'; // Codigo da Localidade de Destino
    infPassagem.xLocDest := 'Descrição da Localidade de Destino';
    infPassagem.dhEmb    := Now;
    //
    // Informações sobre o Passageiro
    //
    infPassagem.infPassageiro.xNome := 'Nome do Passageiro';
    infPassagem.infPassageiro.CPF   := '06760213874';
    infPassagem.infPassageiro.tpDoc := tdRG;
    infPassagem.infPassageiro.nDoc  := '12345678'; // Numero do documento
//   infPassagem.infPassageiro.dNasc := StrToDate('10/10/1970');
    infPassagem.infPassageiro.Fone  := '33445566'; // telefone do passageiro
    infPassagem.infPassageiro.Email := 'passageiro@provedor.com.br';
    infPassagem.dhValidade := Now + 366.0;

    //
    // Informações sobre a Viagem
    //

    with infViagem.New do
    begin
      cPercurso    := 'Código do Percurso';
      xPercurso    := 'Descrição do Percurso';
      tpViagem     := tvRegular;
      tpServ       := tsConvencionalComSanitario;
      tpAcomodacao := taAssento;
      tpTrecho     := ttNormal;
//     dhConexao    := ** Informar se o tpTrecho for ttConexao
      prefixo      := 'Prefixo da linha';
      Poltrona     := 21;
      dhViagem     := now;
      //
      // Informações sobre a Travessia (se ocorrer)
      //
//     infTravessia.tpVeiculo  := tvAutomovel;
//     infTravessia.sitVeiculo := svCarregado;
    end;

    //
    // Informações sobre o valor do BPe
    //

    infValorBPe.vBP        :=  98.00;
    infValorBPe.vDesconto  :=   0.00;
    infValorBPe.vPgto      := 100.00;
    infValorBPe.vTroco     :=   2.00;
    infValorBPe.tpDesconto := tdNenhum;
    infValorBPe.xDesconto  := '';
    //
    // Composição do valor do BPe
    //
    with infValorBPe.Comp.New do
    begin
      tpComp := tcTarifa;
      vComp  := 25.00;
    end;
    with infValorBPe.Comp.New do
    begin
      tpComp := tcPedagio;
      vComp  := 35.00;
    end;
    with infValorBPe.Comp.New do
    begin
      tpComp := tcOutros;
      vComp  := 38.00;
    end;

    //
    // Informações sobre o valor do BPe
    //

    Imp.ICMS.CST   := cst00;
    Imp.ICMS.vBC   := 98.00;
    Imp.ICMS.pICMS := 18.00;
    Imp.ICMS.vICMS := 17.64;

    Imp.vTotTrib   := 0.00;
    Imp.infAdFisco := '';

    //
    // Informações sobre o Pagamento
    //

    with Pag.New do
    begin
      tPag := fpDinheiro;
      vPag := 98.00;

      tpIntegra := tiNaoInformado;
      CNPJ      := '';
      tBand     := bcOutros;
      cAut      := '';
    end;

    //
    // Autorizados para o Download do XML do BPe
    //
    (*
    with autXML.New do
    begin
      CNPJCPF := '00000000000000';
    end;

    with autXML.New do
    begin
      CNPJCPF := '11111111111111';
    end;
    *)
    //
    // Informações Adicionais
    //

    infAdic.infAdFisco := '';
    infAdic.infCpl     := 'Informações Complementares';
  end;
end;

procedure TProviderBPe.AlimentarBPeTM(NumDFe: String);
begin

end;

function TProviderBPe.AlimentarComponente(NumDFe: String): TStream;
begin
  ACBrBPe1.Bilhetes.Clear;

  case ACBrBPe1.Configuracoes.Geral.ModeloDF of
    moBPeTM: AlimentarBPeTM(NumDFe);
  else
    AlimentarBPe(NumDFe);
  end;
//LProviderBPe.ACBrBPe1.Bilhetes.Assinar;
  if ACBrBPe1.Bilhetes.Count = 0 then
    raise Exception.Create( 'Não possível gerar o bilhete')
  else
  begin
    //Result :=  ACBrBPe1.Bilhetes.Items[0].GerarXML;
Result := TMemoryStream.Create;
  ACBrBPe1.Bilhetes.Items[0].GravarStream(Result);
  end;
end;

end.
