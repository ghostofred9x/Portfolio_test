import re
import requests
import sys
#re.sub(reg, "", changed_admin_html)
reg = re.compile('Site Settings')
#session = requests.session()
payload = {'ctl00$ctl00$C$W$_loginWP$_myLogin$_userNameTB': 'administrator', 'ctl00$ctl00$C$W$_loginWP$_myLogin$_passwordTB': 'D$fA$p01!', 'ctl00$ctl00$C$W$_loginWP$_myLogin$Login': 'Login'}
URL = 'http://dsfprdapp01.printhosting.com/dsf/asp1/storefront.aspx'
p = requests.Session()
#p.auth = ('administrator', 'D$fA$p01!')
#p = session.get(URL)
p = p.post(URL, data=payload)
p.post('http://dsfprdapp01.printhosting.com/DSF/Admin/AdminHome.aspx')
#p = session.get('https://www.google.com', timeout=0.000001)
page_test = p.text
re.findall(reg, page_test)
##########################################################


r = requests.get('http://dsfprdapp01.printhosting.com/dsf/asp1/storefront.aspx')
p = requests.get('http://dsfprdapp01.printhosting.com/dsf/asp1/storefront.aspx/get')
p = requests.post('http://dsfprdapp01.printhosting.com/dsf/asp1/storefront.aspx', data=payload)
page_test = p.text
page_test = r.text
re.findall(reg, page_test)


payload = {'j_clientId': '1666', 'j_username': 'efiihs', 'j_password': 'K@!aM*dr!d'}
r = requests.post('https://portal.solutionary.com/post', data=payload)


t = requests.get('https://portal.solutionary.com/ViewHomePage.mvc')

#######################################################################
import re
from twill.commands import *
from twill import get_browser
reg = re.compile('Site Settings')
b = get_browser()
URL = 'http://dsfprdapp01.printhosting.com/dsf/asp1/storefront.aspx'
b.go(URL)
showforms()
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__userNameTB", "administrator")
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__passwordTB", "D$fA$p01!")
b.submit('24')
#print(html)
#b.go('http://dsfprdapp01.printhosting.com/DSF/Admin/AdminHome.aspx')
b.go('http://dsfprdapp01.printhosting.com/DSF/Admin/svddashboard/svddashboardmain.aspx')
html=b.get_html()
#re.findall(reg, page_test)

#######################################################################


from twill.commands import *
from twill import get_browser
b = get_browser()
URL = 'https://portal.solutionary.com/login.jsp'
b.go(URL)
fv("1","j_clientId","1666")
fv("1","j_username","efiihs")
fv("1","j_password","K@!aM*dr!d")
b.submit('4')
html=b.get_html()
print(html)


from twill.commands import *
from twill import get_browser
b = get_browser()
URL = 'http://www.py2exe.org'
b.go(URL)
html=b.get_html()
print(html)

######################################################################

dsfmaster.html

import re
from twill.commands import *
from twill import get_browser
reg = re.compile('Site Settings')
b = get_browser()
#URL = 'C:\dsfmaster.html'
URL = 'artwork_show.html'
b.go(URL)
showforms()
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__userNameTB", "administrator")
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__passwordTB", "D$fA$p01!")
b.submit('24')
#print(html)
#b.go('http://dsfprdapp01.printhosting.com/DSF/Admin/AdminHome.aspx')
b.go('http://localhost/DSF/Admin/svddashboard/svddashboardmain.aspx')
html=b.get_html()


#Getting forms for html tests
import re
from twill.commands import *
from twill import get_browser
reg = re.compile('Site Settings')
b = get_browser()
URL = 'http://dsfprdapp01.printhosting.com/dsf/master.aspx'
b.go(URL)
showforms()
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__userNameTB", "administrator")
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__passwordTB", "administrator")
b.submit('9')
SiteMan = 'http://dsfqaapp01.printhosting.com/DSF/Admin/HostingCenter/WebSitesMgmt.aspx'
b.go(SiteMan)
loginNonMaster = 'http://dsfqaapp01.printhosting.com:80/DSF/Storefront.aspx?SITEGUID=947268a1-8a93-4a58-bbaf-281f2f5fa357&amp;FROMMASTERIH18R15PF4GJ2S0837UX=1708723286&amp;AUTOLOGINIH18R15PF4GJ2S0837UX=920724142'
b.go(loginNonMaster)
b.go('http://localhost/DSF/Admin/svddashboard/svddashboardmain.aspx')
html=b.get_html()
print(html)

#####################################MAIN MAIN MAIN########################################################

import re
from twill.commands import *
from twill import get_browser
reg = re.compile('Site Settings')
b = get_browser()
URL = 'http://dsfprdapp01.printhosting.com/dsf/master.aspx'
b.go(URL)
showforms()
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__userNameTB", "administrator")
fv("1","ctl00_ctl00_C_W__loginWP__myLogin__passwordTB", "administrator")
b.submit('9')
SiteMan = 'http://dsfqaapp01.printhosting.com/DSF/Admin/HostingCenter/WebSitesMgmt.aspx'
b.go(SiteMan)


loginNonMaster = 'http://dsfqaapp01.printhosting.com:80/DSF/Storefront.aspx?SITEGUID=947268a1-8a93-4a58-bbaf-281f2f5fa357&amp;FROMMASTERIH18R15PF4GJ2S0837UX=1708723286&amp;AUTOLOGINIH18R15PF4GJ2S0837UX=920724142'
b.go(loginNonMaster)
b.go('http://localhost/DSF/Admin/svddashboard/svddashboardmain.aspx')
html=b.get_html()
print(html)
