<p align="center">
  <img src="https://img.shields.io/github/v/release/pmadalozzo/MsConnection?style=flat-square">
  <img src="https://img.shields.io/github/stars/pmadalozzo/MsConnection?style=flat-square">
  <img src="https://img.shields.io/github/contributors/pmadalozzo/MsConnection?color=orange&style=flat-square">
  <img src="https://img.shields.io/github/forks/pmadalozzo/MsConnection?style=flat-square">
</p>

# MsConnection
Framework para realização de conexão com banco de dados de forma abstrata.

O <b>MSConnection</b> tem o objetivo de abstrair o componente de conexão com banco de dados, facilitando assim a troca de componente quando necessário com menor impacto possível para a aplicação. Abstraindo a necessidade de uso de componentes visuais, com o <b>MsConnection</b> a aplicação fica mais leve e performática.
<br>


## Instalação

Basta registrar no Library Path do seu Delphi o caminho da pasta SRC da Biblioteca ou utilizar o Boss (https://github.com/HashLoad/boss) para facilitar ainda mais, executando o comando 

```
boss install https://github.com/pmadalozzo/MsConnection
```

*Pré-Requisitos*:<br> 

[**MsLoading**](https://github.com/pmadalozzo/MSLoading) - Biblioteca para visualizar o carregamento dos dados  <br>
[**localcache4d**](https://github.com/bittencourtthulio/localcache4d) - Mini Banco de Dados Chave-Valor para Cache local <br>

## Primeiros Passos - Tutorial

Para utilizar o <b>MSConnection</b> você deve adicionar as uses:

```
...
Uses
  MsConnection;
```
No Exemplo foi usado uma classe para carregar os paramentros do banco de dados carregados no arquivo <b>MsConfig.lc4</b> gerado pelo [**localcache4d**](https://github.com/bittencourtthulio/localcache4d).

``` delphi
unit Service;

interface

type
  TService = class
    private
      procedure RegisterMsConnection;
    public
      constructor Create;
      destructor Destroy; override;

  end;

var
  aService : TService;

implementation

uses
  MsConnection,
  LocalCache4D,
  System.SysUtils;

{ TService }

constructor TService.Create;
begin
  RegisterMsConnection;
end;

destructor TService.Destroy;
begin

  inherited;
end;

procedure TService.RegisterMsConnection;
begin
  LocalCache.LoadDatabase('.\Config\MsConfig.lc4');

  TMsConnection
    .New
     .Credential
      .Host(LocalCache.Instance('Database').GetItem('host'))
      .Port(strtoint(LocalCache.Instance('Database').GetItem('port')))
      .User(LocalCache.Instance('Database').GetItem('user'))
      .Pass(LocalCache.Instance('Database').GetItem('pass'))
      .Database(LocalCache.Instance('Database').GetItem('database'))
      .Driver(LocalCache.Instance('Database').GetItem('driver'))
      .Dll(LocalCache.Instance('Database').GetItem('dll'))
      .RowsetSize(LocalCache.Instance('Database').GetItem('rowsetsize'))
     .&End;
end;

initialization
  aService := TService.Create;
finalization
  aService.Free;

end.
```

Para executar uma instrução SQL com <b>MsConnection</b>, baste seguir o exemplo abaixo:

```delphi
...
Procedure TForm1.btnConsulta;
begin
  TMsConnection
   .New
    .Connection
    .DataSource(DataSource1)
     .Close
      .Clear
       .SQL('select * from table ')
      .Open;
end;      
```
