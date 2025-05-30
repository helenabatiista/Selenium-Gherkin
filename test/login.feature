# language: pt
Funcionalidade: Tela de Login

  Contexto:
    Dado acesso ao Google Chrome
    E acesso à Netflix

  Cenário: CT01 - Acessar tela de Boas Vindas
    Então carregar tela de boas vindas
      E fechar navegador

  Cenário: CT02 - Acessar tela de login
    Quando clicar em Login da tela de Boas Vindas
    Então carregar tela de Login
     E fechar navegador

  Esquema do Cenário: CT03 - Senha inválida
    Quando clicar em Login da tela de Boas Vindas
      E inserir e-mail válido "<email>"
      Mas inserir senha inválida "<senha>"
      E clicar em Login
    Então apresentar erro de senha inválida
       E fechar navegador
    Exemplos:
      # Primeiro exemplo a senha está realmente inválida
      # e no segundo exemplo o usuário não existe
      | email                  | senha      |
      | teste@gmail.com        | Teste@1234 |
      | testeGherkin@gmail.com | Teste@1234 |

  Esquema do Cenário: CT04 - Usuário inválido
    Quando clicar em Login da tela de Boas Vindas
      Mas inserir e-mail inválido "<email>"
        E inserir senha inválida "<senha>"
      E clicar em Login
    Então apresentar erro de usuário inválido
       E fechar navegador
    Exemplos:
      # Primeiro exemplo o usuário existe porém está com senha inválida
      # e no segundo exemplo o usuário realmente não existe
      | email                  | senha      |
      | teste@gmail.com        | Teste@1234 |
      | testeGherkin@gmail.com | Teste@1234 |

  Esquema do Cenário: CT05 - Usuário Válido
    Quando clicar em Login da tela de Boas Vindas
      E inserir e-mail válido "<email>"
      E inserir senha válida "<senha>>"
      E clicar em Login
    Então realizar Login com sucesso
       E fechar navegador
    Exemplos:
      | email            | senha      |
      | valido@gmail.com | valido     |