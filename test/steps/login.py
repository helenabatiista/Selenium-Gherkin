from behave import *
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from model.P01_Login import Login


@given(u'acesso ao Google Chrome')
def conectar(context):
    context.driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))


@given(u'acesso à Netflix')
def acessar_netflix(context):
    context.driver.get('https://www.netflix.com/br/')
    context.login = Login(context.driver)


@when(u'clicar em Login da tela de Boas Vindas')
def clicar_login_welcome(context):
    assert context.login.click_signin_welcome() is True


@when(u'inserir e-mail válido "{email}"')
@when(u'inserir e-mail inválido "{email}"')
def inserir_email(context, email):
    assert context.login.set_email(email) is True


@when(u'inserir senha inválida "{senha}"')
@when(u'inserir senha válida "{senha}"')
def inserir_senha(context, senha):
    assert context.login.set_password(senha) is True


@when(u'clicar em login')
def clicar_login(context):
    assert context.login.click_signin_login() is True


@then(u'carregar tela de Boas Vindas')
def acessar_welcome(context):
    assert context.login.check_page_welcome() is True


@then(u'carregar tela de Login')
def acessar_login(context):
    assert context.login.check_page_login() is True


@then(u'apresentar erro de senha inválida')
def erro_senha_invalida(context):
    assert context.login.check_error_passwordInvalid() is True


@then(u'apresentar erro de usuário inválido')
def erro_usuario_invalido(context):
    assert context.login.check_error_userInvalid() is True


@then(u'realizar Login com sucesso')
def realizar_login(context):
    assert context.login.check_page_profiles() is True


@then(u'fechar navegador')
def fechar_navegador(context):
    context.driver.quit()
