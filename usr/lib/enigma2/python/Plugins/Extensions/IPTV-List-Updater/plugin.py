#########################################
#			IPTV List Updater			#
#	      by Nobody28 & satinfo 		#
#########################################

from Screens.Screen import Screen
from enigma import eConsoleAppContainer, eDVBDB
from Screens.Console import Console
from Screens.MessageBox import MessageBox
from Components.ActionMap import NumberActionMap
from Screens.Standby import TryQuitMainloop
from Components.Pixmap import Pixmap
from Components.Sources.StaticText import StaticText
from Components.Label import Label
from Components.ScrollLabel import ScrollLabel
import Components.config
from Components.MenuList import MenuList
from Plugins.Plugin import PluginDescriptor
from Components.config import config
from Tools.Directories import resolveFilename, SCOPE_PLUGINS
from os import path, walk
from enigma import eEnv
from skin import *
import os

class IPTVStart(Screen):
	skin = """
		<screen name="IPTVStart" position="center,center" size="700,350" title="Welcome to IPTV List Updater" >
			<widget name="title" position="0,20" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<widget name="maintain" position="0,50" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<widget name="link1" position="0,100" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<widget name="link2" position="0,130" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<widget name="description" position="0,180" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<widget name="thanks" position="0,230" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<ePixmap name="red" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/red.png" position="20,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<ePixmap name="green" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/green.png" position="195,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<ePixmap name="yellow" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/yellow.png" position="325,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<ePixmap name="blue" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/blue.png" position="450,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<widget name="key_red" position="45,320" zPosition="2" size="120,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
			<widget name="key_green" position="205,320" zPosition="2" size="100,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
			<widget name="key_yellow" position="310,320" zPosition="2" size="140,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
			<widget name="key_blue" position="485,320" zPosition="2" size="160,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
		</screen>"""
	
	def __init__(self, session, args = None):

		Screen.__init__(self, session)
		
		self["title"] = Label(_("IPTV List Updater V0.90"))
		self["maintain"] = Label(_("(c) by Nobody28 & satinfo"))
		self["link1"] = Label(_("www.gigablue-support.com"))
		self["link2"] = Label(_("www.opena.tv"))
		self["description"] = Label(_("Install & Update various IPTV Bouquet to your Favourites TV"))
		self["thanks"] = Label(_("Special thanks goes to HasBahCa for his Streamlinks"))
		
		self["actions"] = NumberActionMap(["WizardActions", "OkCancelActions", "ColorActions"],
		{
			"ok": self.go,
			"back": self.close,
			"red": self.close,
			"green": self.go,
			"yellow": self.faq,
			"blue": self.change,
		}, -1)
		self["key_red"] = Label(_("Close"))
		self["key_green"] = Label(_("Start"))
		self["key_yellow"] = Label(_("FAQ"))
		self["key_blue"] = Label(_("Changelog"))
	
	def go(self):
		self.session.open(IPTVMain)
		self.close()
		
	def change(self):
		self.session.open(Changelog)
		
	def faq(self):
		self.session.open(FAQ)
		

class Changelog(Screen):
	skin = """
		<screen name="Changelog" position="center,center" size="700,350" title="Changelog IPTV List Updater" >
			<widget name="title" position="0,20" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" valign="center" transparent="1" />
			<widget name="text" position="10,50" size="680,250" font="Regular;21" />
			<ePixmap name="red" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/red.png" position="20,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<widget name="key_red" position="45,320" zPosition="2" size="120,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
		</screen>"""
	
	def __init__(self, session, args = None):
		
		Screen.__init__(self, session)	

		self["title"] = Label(_("IPTV List Updater V0.90"))
		self["text"] = ScrollLabel()

		self["actions"] = NumberActionMap(["WizardActions", "OkCancelActions", "ColorActions"],
		{
			"back": self.close,
			"red": self.close,
			"up": self["text"].pageUp,
			"down": self["text"].pageDown,
		}, -1)
		self["key_red"] = Label(_("Close"))
		
		change = self.Ausgabe()
		self["text"].setText(change)
		
	def Ausgabe(self):
		self.file = open("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/changelog.txt","r")
		self.text = self.file.read()
		self.file.close()
		return self.text


class FAQ(Screen):
	skin = """
		<screen name="FAQ" position="center,center" size="800,450" title="FAQ IPTV List Updater" >
			<widget name="text" position="10,50" size="780,350" font="Regular;21" />
			<ePixmap name="red" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/red.png" position="20,415" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<widget name="key_red" position="45,420" zPosition="2" size="120,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
		</screen>"""
	
	def __init__(self, session, args = None):
		
		Screen.__init__(self, session)	

		self["text"] = ScrollLabel()

		self["actions"] = NumberActionMap(["WizardActions", "OkCancelActions", "ColorActions"],
		{
			"back": self.close,
			"red": self.close,
			"up": self["text"].pageUp,
			"down": self["text"].pageDown,
		}, -1)
		self["key_red"] = Label(_("Close"))
		
		change = self.Ausgabe()
		self["text"].setText(change)
		
	def Ausgabe(self):
		self.file = open("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/faq.txt","r")
		self.text = self.file.read()
		self.file.close()
		return self.text
	
	
class IPTVMain(Screen):
	skin = """
		<screen name="IPTVMain" position="center,center" size="700,350" title="IPTV List Updater V0.90" >
			<widget name="text1" position="50,10" size="250,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" halign="left" transparent="1" />
			<widget name="text2" position="0,270" halign="center" size="700,26" zPosition="1" foregroundColor="#FFE500" font="Regular;22" transparent="1" />
			<widget name="IPTVList" position="50,55" size="270,200" enableWrapAround="1" scrollbarMode="showOnDemand" />
			<widget name="country" position="380,55" size="270,200" zPosition="1" backgroundColor="background" transparent="0" alphatest="on" />
			<ePixmap name="red" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/red.png" position="20,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<ePixmap name="green" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/green.png" position="170,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<ePixmap name="yellow" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/yellow.png" position="320,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<ePixmap name="blue" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/buttons/blue.png" position="460,315" zPosition="1" size="30,46" transparent="1" alphatest="on" />
			<widget name="key_red" position="45,320" zPosition="2" size="120,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
			<widget name="key_green" position="205,320" zPosition="2" size="100,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
			<widget name="key_yellow" position="330,320" zPosition="2" size="140,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
			<widget name="key_blue" position="485,320" zPosition="2" size="160,25" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
		</screen>"""
	
	iptvlist =[]
	root = eEnv.resolve("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/")

	def __init__(self, session, args = None):
		
		Screen.__init__(self, session)
		
		self.iptvlist = []
		self.iptvname = ""
		self.IPTVInstalled = False
		self.countryPath = ""
		self.actual = None
		path.walk(self.root, self.find, "")
		
		self.iptvlist.sort()
		self["IPTVList"] = MenuList(self.iptvlist)
		self["country"] = Pixmap()
		self["text1"] = Label(_("Select Bouquet to add:"))
		self["text2"] = Label(_("Select IPTV Bouquet to add in your Favourite TV Bouquet."))
		
		self["actions"] = NumberActionMap(["WizardActions", "OkCancelActions", "ColorActions"],
		{
			"ok": self.ok,
			"back": self.cancel,
			"red": self.cancel,
			"green": self.ok,
			"up": self.up,
			"down": self.down,
			"left": self.left,
			"right": self.right,
			"yellow": self.install,
			"blue": self.update,
		}, -1)
		self["key_red"] = Label(_("Close"))
		self["key_green"] = Label(_("Install"))
		self["key_yellow"] = Label(_("Install all"))
		self["key_blue"] = Label(_("Update scripts"))
		self.onLayoutFinish.append(self.layoutFinished)
		
	def up(self):
		self["IPTVList"].up()
		self.loadCountry()
	
	def down(self):
		self["IPTVList"].down()
		self.loadCountry()	
	
	def left(self):
		self["IPTVList"].pageUp()
		self.loadCountry()
	
	def right(self):
		self["IPTVList"].pageDown()
		self.loadCountry()	
		
	def find(self, arg, dirname, names):
		for x in names:
			if x.startswith("IPTV_") and x.endswith(".sh"):
				if dirname <> self.root:
					subdir = dirname[19:]
					self.iptvname = x
					self.iptvname = subdir + "/" + iptvname
					self.iptvlist.append(iptvname.split(".")[0])
				else:
					self.iptvname = x
					self.iptvlist.append(self.iptvname.split(".")[0])
					
	def layoutFinished(self):
		self.loadCountry()
	
	def ok(self):
		self.IPTVInstalled = True
		com = "sh /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/" + self["IPTVList"].l.getCurrentSelection() + ".sh" + ""
		self.session.open(Console,_("Install Log: %s") % (com), ["%s" %com])

	def cancel(self):
		if self.IPTVInstalled is True:
			infobox = self.session.open(MessageBox,_("Reloading bouquets and services..."), MessageBox.TYPE_INFO, timeout=5)
			infobox.setTitle(_("Info"))
			eDVBDB.getInstance().reloadBouquets()
			eDVBDB.getInstance().reloadServicelist()
		self.close()
			
	def install(self):
		self.IPTVInstalled = True
		com = "sh /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/install_all.sh"
		self.session.open(Console,_("Install Log: %s") % (com), ["%s" %com])
		
	def update(self):
		com = "sh /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/update_scripts.sh"
		self.session.open(Console,_("Install Log: %s") % (com), ["%s" %com])
		
	def loadCountry(self):
		pngpath = self["IPTVList"].getCurrent()
		try:
			pngpath = pngpath + ("_prev.png")
			pngpath = self.root + pngpath
		except AttributeError:
			pngpath = resolveFilename("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/noprev.png")
			
		if not path.exists(pngpath):
			pngpath = eEnv.resolve("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/noprev.png")
		if self.countryPath != pngpath:
			self.countryPath = pngpath
			
		self["country"].instance.setPixmapFromFile(self.countryPath)
		Screen.hide(self)
		Screen.show(self)
	
	
###########################################################################

def main(session, **kwargs):
	session.open(IPTVStart)
	pass

###########################################################################

def Plugins(**kwargs):
	return [PluginDescriptor(name = "IPTV List Updater V0.90", description = "IPTV Bouquets by Nobody28 & satinfo", where = [PluginDescriptor.WHERE_PLUGINMENU], fnc = main, icon = "plugin.png"),
			PluginDescriptor(name = "IPTV List Updater V0.90", description = "IPTV Bouquets by Nobody28 & satinfo", where = PluginDescriptor.WHERE_EXTENSIONSMENU, fnc=main)]