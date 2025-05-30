# Selenium-Gherkin

# 💬 Sobre
Base para automação de testes utilizando a linguagem Python com as tecnologias do Selenium WebDriver e Behave e com a 
estrutura organizacional CMT (Controller Model Test), uma adaptação do MVC.

Para exemplificar o funcionamento da base será automatizado a tela de login do site Netflix para cobrir 
os seguintes cenários de teste:
- CT01 - Acessar tela de Boas Vinda
- CT02 - Acessar tela de Login
- CT03 - Senha Inválida
- CT04 - Usuário Inválido
- CT05 - Usuário Válido

# 🧾 Índice
- <a href="#-instalação">Instalação</a>
- <a href="#-desenvolvimento">Desenvolvimento</a>
  - <a href="#-controller">Controller</a>
    - <a href="#logpy">/log.py</a>
    - <a href="#webdriverpy">/webdriver.py</a>
      - <a href="#__code">Code</a>
      - <a href="#find">Find</a>
      - <a href="#click">Click</a>
      - <a href="#set">Set</a>
  - <a href="#-model">Model</a>
    - <a href="#check">Check</a>
    - <a href="#click">Click</a>
    - <a href="#set">Set</a>
  - <a href="#-test">Test</a>
    - Em andamento
- <a href="#-cenários-de-teste">Cenários de Teste</a>
  - Em andamento


# 💾 Instalação

**Projeto**

```
git clone https://github.com/andreinaoliveira/BDD-Base-Automation.git
```

**Dependencias**
* Python 3

**Módulos**

Os módulos devem ser instalados no cmd com os comandos abaixos
```
pip install behave
pip install selenium
pip install webdriver-manager
```

# 🖥 Desenvolvimento
## 🕹 Controller

### /log.py

Importa a biblioteca de loggin e formata a mensagem de log. Nesse arquivo é criado as funções debug(), info() e error(). 
Cada função recebe a mensagem que será enviada como log. Essas funções são chamadas em controller/webdriver. 
<br><br>A linha referente a basic config está por padrão comentada para evitar poluição visual no terminal. 
Contudo, quando houver erros, os logs serão apresentados.

```python
import logging
log_format = '%(asctime)s :: %(name)s :: %(levelname)s :: %(module)s :: %(message)s'
#logging.basicConfig(format=log_format, level=logging.INFO, filemode='w')


def degub(message):
    logging.debug(message)

def info(message):
    logging.info(message)

def error(message):
    logging.error(message)
```

### /webdriver.py

Em webdriver.py é criada a classe Element com os seguintes atribuitos e importações:
- driver: recebe o webdriver que será criado apenas no teste.
- name: nome do elemento ex.: Botão Sign In. O nome será enviado apenas nos log's. 
- element: Ao ser encontrado, o elemento é salvo nesse atributo.
- as_Code_Type...: É a referência do elemento. É necessário atribuir valor a um dos itens para 
poder usar as funções da classe. 

```python
import os
import sys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from controller import log
```

```python
class Element:
    def __init__(self, driver, name):
        self.driver = driver
        self.name = name
        self.element = None
        self.as_1_ID = None
        self.as_2_CLASS_NAME = None
        self.as_3_NAME = None
        self.as_4_TAG_NAME = None
        self.as_5_LINK_TEXT = None
        self.as_6_PARTIAL_LINK_TEXT = None
        self.as_7_CSS_SELECTOR = None
        self.as_8_XPATH = None
```

As funções da classe ao serem chamadas (find, click e set), executará as ações e retornará [True] ou [False] de acordo 
com o sucesso ou não da atividade. Portanto, além de executar a ação você poderá comparar o resultado, por exemplo, 
checar se retornou True, ou seja, checar se a ação foi executada com sucesso.

### __Code

A função é chamada na função find(). Recebe um valor inteiro por parâmetro na variável code, o valor está no range de 
1 a 8 e se refere ao tipo de referência do elemento (id, class etc.). <br><br>O código é o mesmo do atributo 
as_Code_Type da classe. 
Exemplo, instanciando a classe como as_1_ID o code da função deve ser _ code(1) para buscar por ID.
<br><br>O ideal é que a função seja chamada apenas pelo find(), nunca diretamente.

```python
    def _code(self, code):
        if code == 1:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, self.as_1_ID))
            )
        elif code == 2:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, self.as_2_CLASS_NAME))
            )
        elif code == 3:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.NAME, self.as_3_NAME))
            )
        elif code == 4:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.TAG_NAME, self.as_4_TAG_NAME))
            )
        elif code == 5:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.LINK_TEXT, self.as_5_LINK_TEXT))
            )
        elif code == 6:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.PARTIAL_LINK_TEXT, self.as_6_PARTIAL_LINK_TEXT))
            )
        elif code == 7:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, self.as_7_CSS_SELECTOR))
            )
        elif code == 8:
            self.element = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.XPATH, self.as_8_XPATH))
            )
        else:
            log.error('Código informado em find() fora do range ou inválido.')
            os.system("pause")
            sys.exit()
```

### Find
1. A Função tenta localizar o elemento e envia um log informando essa tentativa.
2. Não encontrando, imprime o log de erro e retorna Falso.
3. Encontrando, imprime log informando sucesso e retorna True.

```python
    def find(self, code):
        try:
            log.degub('Buscando ' + self.name)
            self._code(code)
        except Exception as e:
            log.error('Erro ao identificar ' + self.name)
            return False
        else:
            log.info(self.name + ' Identificado(a)')
            return True
```

### Click
1. Chama find() para atribuir valor ao atributo element da classe.
2. Tenta clicar no elemento identificado.
4. Não conseguindo, imprime o log de erro e retorna Falso
5. Conseguindo, imprime log informando sucesso e retorna True

```python
    def click(self, code):
        Element.find(self, code)
        try:
            self.element.click()
        except Exception as e:
            log.error('Erro ao clicar em ' + self.name)
            return False
        else:
            log.info(self.name + ' Clicado(a)')
            return True
```

### Set
1. Chama find() para atribuir valor ao atributo element da classe.
2. Tenta clicar no elemento identificado.
4. Não conseguindo, imprime o log de erro e retorna Falso.
5. Conseguindo, imprime log informando sucesso e retorna True.

```python
    def set(self, code, info):
        Element.find(self, code)
        try:
            self.element.send_keys(info)
        except Exception as e:
            log.error('Erro ao escerver ' + self.name)
            return False
        else:
            log.info(self.name + ' Inserido(a)')
            return True
```

## 🔧 Model
Modelo armazena todas as páginas de um sistema web em aquivos .py diferentes. Cada arquivo possui uma classe que se 
refere a página web em questão. O ideal é que os principais elementos da página sejam instanciados nessa classe 
herdando da classe Element de controller/webdriver. Para exemplificar, criamos o modelo da página de 
login da Netflix (login.py)

Como atribuito possuir:
- driver

As funções da página são divididas em: 
- **Check**: Checa se está na página, checa se alguma mensagem de erro é apresentada etc.
- **Click**: realiza o clique em qualquer elemento da página.
- **Set**: Insere alguma informação na página.

### Check
1. Instancia o elemento passando o driver e o nome do elemento.
2. Atribuir o valor da referência.
3. Retorna a função find que busca a referência informada.

```python
    def check_page_welcome(self):
        e = Element(self.driver, '[Welcome] Page')
        e.as_2_CLASS_NAME = 'our-story-card-title'
        return e.find(2)
```

### Click
1. Instancia o elemento passando o driver e o nome do elemento.
2. Atribuir o valor da referência.
3. Retorna a função click que tentará clicar na referência informada.

```python
    def click_signin_welcome(self):
        e = Element(self.driver, '[Welcome] Sign In button')
        e.as_5_LINK_TEXT = 'Sign In'
        return e.click(5)
```

### Set
1. Instancia o elemento passando o driver e o nome do elemento.
2. Atribuir o valor da referência.
3. Retorna a função set que tentará inserir uma informação na referência informada.

```python
    def set_email(self, email_or_number):
        e = Element(self.driver, '[Login] Email')
        e.as_1_ID = 'id_userLoginId'
        return e.set(1, email_or_number)
```

## 🧪 Test
Onde os testes de fato irão ocorrer. Após controller ser escrito suportando as instâncias da página em model chega a 
hora de criar os casos de teste, para isso, será utilizado Cucumber para escrever os cenários e Behave para interpretar 
a sintaxe do Gherkin

### Feature (Cucumber)
Dentro da pasta teste haverá arquivos .feature que representam o caso de teste. O arquivo refere-se a ferramenta 
Cucumber e está pronto para receber cenários de teste na sintaxe do Gherkin.

```Gherkin
# language: pt
Funcionalidade: Tela de Login
Contexto:
  Dado acesso ao Google Chrome
  E acesso à Netflix
Cenário: CT02 - Acessar tela de login
  Quando clicar em Login da tela de Boas Vindas
  Então carregar tela de Login
  E fechar navegador
```

### Steps (Behave)
Dentro de Steps estará contido o real procedimento para a realização dos testes das features.

Quanto a importação, será necessário a importação do behave para interpretar comandos do gherkin além de alguns
elementos do selenium para identificação do driver. Para gerar a conexão dos cenários de teste com os elementos da tela
será importado de modelo a página correspondente ao teste. No caso, como será testado elementos de Login será importado
a página login contida em model.
```python
from behave import *
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from model.P01_Login import Login
```

Após a importação poderá ser escrito as ações referente ao passo definido na feature.

```python
@when(u'clicar em Login da tela de Boas Vindas')
def clicar_login_welcome(context):
    assert context.login.click_signin_welcome() is True
```



## 👩🏼‍💻 Cenários de Teste


**Comando para Execução dos cenários de teste** 

```behave .\test\login.feature```

**Funcionalidade e Contexto**
```Gherkin
# language: pt
Funcionalidade: Tela de Login
  Contexto:
    Dado acesso ao Google Chrome
    E acesso à Netflix
```

### CT01 - Acessar tela de Boas Vindas
**Objetivo**
- Acessar o site da Netflix e checar se é carregada a tela de Boas Vindas.

**Código**
```Gherkin
# language: pt
  Cenário: CT01 - Acessar tela de Boas Vindas
    Então carregar tela de boas vindas
      E fechar navegador
```

<div align="center">
  <table>
    <tr>
      <th><p><b>Execução Assistida</b></p></th> 
      <th><p><b>Log's</b></p></th>
    </tr>
    <tr>
      <th><img src="https://user-images.githubusercontent.com/51168329/159390569-8cfff750-2593-421f-9b83-dc04d3e375a0.gif" width=600px></th>
      <th><img src="https://user-images.githubusercontent.com/51168329/196761790-bf031afe-2d2e-4114-b268-1d3d33a1490a.png" width=600px></th>
    </tr>
  </table>
</div>

### CT02 - Acessar tela de Login
**Objetivo**
- Acessar o site da Netflix, clicar em "Sign In" e checar se é carregada a tela de Login.

**Código**
```Gherkin
# language: pt
  Cenário: CT02 - Acessar tela de login
    Quando clicar em Login da tela de Boas Vindas
    Então carregar tela de Login
      E fechar navegador
```

<div align="center">
  <table>
    <tr>
      <th><p><b>Execução Assistida</b></p></th> 
      <th><p><b>Log's</b></p></th>
    </tr>
    <tr>
      <th><img src="https://user-images.githubusercontent.com/51168329/159391105-1be2aa4f-1808-48b6-8cd0-5c4ef811b470.gif" width=600px></th>
      <th><img src="https://user-images.githubusercontent.com/51168329/196761619-d5df5f02-0edc-4ad0-a351-e2df8b02f840.png" width=600px></th>
    </tr>
  </table>
</div>

### CT03 - Senha Inválida
**Objetivo**
- Dado o acesso ao site da Netflix e clicado em "Sign In" preenchendo um e-mail válido e senha inválida no site, checar se a mensagem referente a senha errada é apresentada.

**Código**
```Gherkin
# language: pt
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
```

<div align="center">
  <table>
    <tr>
      <th><p><b>Execução Assistida</b></p></th> 
      <th><p><b>Log's</b></p></th>
    </tr>
    <tr>
      <th><img src="https://user-images.githubusercontent.com/51168329/159392417-3f95dfeb-8e5d-45d6-8dae-6b55e0d0c963.gif" width=600px></th>
      <th><img src="https://user-images.githubusercontent.com/51168329/196761397-600ed194-01d7-416f-9dd2-8f49fc51981c.png" width=600px></th>
    </tr>
  </table>
</div>

### CT04 - Usuário Inválido
**Objetivo**
- Dado o acesso ao site da Netflix e clicado em "Sign In" preenchendo e-mail e senha com dados inexistente no site, checar se a mensagem de que o usuário não existe é apresentada.

**Código**
```Gherkin
# language: pt
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
```

<div align="center">
  <table>
    <tr>
      <th><p><b>Execução Assistida</b></p></th> 
      <th><p><b>Log's</b></p></th>
    </tr>
    <tr>
      <th><img src="https://user-images.githubusercontent.com/51168329/159392369-420cc93b-d050-49ca-8fc1-a2dff3a1937e.gif" width=600px></th>
      <th><img src="https://user-images.githubusercontent.com/51168329/196760908-cd60a940-82cc-4101-b82a-c263296ca901.png" width=600px></th>
    </tr>
  </table>
</div>
                                                                                                             
### CT05 - Usuário Válido
**Objetivo**
- Dado o acesso ao site da Netflix e clicado em "Sign In" preenchendo e-mail e senha com dados existentes no site e clicando em "Sign In", checar se a tela de Perfis é carregada.

**Código**
```Gherkin
# language: pt
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
```

<div align="center">
  <table>
    <tr>
      <th><p><b>Execução Assistida</b></p></th> 
      <th><p><b>Log's</b></p></th>
    </tr>
    <tr>
      <th><img src="https://user-images.githubusercontent.com/51168329/188284644-58c144c0-7ab3-47f6-8496-a0a9e804939f.gif" width=600px></th>
      <th>
      <img src="https://user-images.githubusercontent.com/51168329/196760684-c2a86e75-c1dc-4ea6-9e14-0565690c6ed1.png" width=600px>
      </th>
    </tr>
  </table>
  </div>
