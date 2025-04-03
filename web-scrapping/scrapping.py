from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
import urllib.request
import zipfile
import os 


with webdriver.Chrome() as driver:
    driver.get("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos")

    windowSize = driver.get_window_size()
    x = windowSize['width']//2
    y = windowSize['height']//2

    ActionChains(driver).move_by_offset(x, y).click().perform()

    anexoI = driver.find_element(By.LINK_TEXT, 'Anexo I.')
    anexoII = driver.find_element(By.LINK_TEXT, 'Anexo II.')

    urllib.request.urlretrieve(anexoI.get_attribute('href'), "anexoI.pdf")
    urllib.request.urlretrieve(anexoII.get_attribute('href'), "anexoII.pdf")

with zipfile.ZipFile('anexos.zip', 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write('anexoI.pdf')
    zipf.write('anexoII.pdf')
    
os.remove('anexoI.pdf')
os.remove('anexoII.pdf')