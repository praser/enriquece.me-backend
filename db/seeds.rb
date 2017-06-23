# frozen_string_literal: true

Bank.create(
  [
    { name: 'Carteira', code: 0 },
    { name: 'Banco do Brasil S.A.', code: 1 },
    { name: 'Banco Bradesco S.A.', code: 237 },
    { name: 'Itaú Unibanco S.A.', code: 341 },
    { name: 'Banco Santander  (Brasil)  S.A.', code: 33 },
    { name: 'Caixa Econômica Federal', code: 104 },
    { name: 'Banco do Estado do Rio Grande do Sul S.A.', code: 41 },
    { name: 'Banco do Nordeste do Brasil S.A.', code: 4 },
    { name: 'BANESTES S.A. Banco do Estado do Espírito Santo', code: 21 },
    { name: 'Banco Citibank S.A.', code: 477 },
    { name: 'Banco da Amazônia S.A.', code: 3 },
    { name: 'Banco Safra S.A.', code: 422 },
    { name: 'Unicred', code: 91 },
    { name: 'BRB - Banco de Brasília S.A.', code: 70 },
    { name: 'Sicoob', code: 90 },
    { name: 'Banco do Estado do Pará S.A.', code: 37 },
    { name: 'Banco Votorantim S.A.', code: 655 },
    { name: 'Banco BMG S.A.', code: 318 },
    { name: 'Banif-Banco Internacional do Funchal (Brasil)S.A.', code: 719 },
    { name: 'Banco Cooperativo Sicredi S.A.', code: 748 },
    { name: 'Banco BBM S.A.', code: 107 },
    { name: 'Banco Cacique S.A.', code: 263 },
    { name: 'Banco Panamericano S.A.', code: 623 }
  ]
)

AccountType.create(
  [
    { name: 'Conta corrente' },
    { name: 'Conta poupança' },
    { name: 'Conta salário' }
  ]
)
