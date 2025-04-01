from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait as WDW
from selenium.webdriver.support import expected_conditions as EC
import urllib.request



driver = webdriver.Edge()

driver.get("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos")

cookies = driver.find_element(By.CLASS_NAME, 'Fechar overlay')
cookies.click()

anexoI = driver.find_element(By.LINK_TEXT, 'ANEXO I')
anexoII = driver.find_element(By.LINK_TEXT, 'ANEXO I')


print(anexoI)

## // urllib.request.urlretrieve(anexoI, "anexoI.PDF")
## // urllib.request.urlretrieve(anexoII, "anexoII.PDF")