# -*- coding: utf-8 -*-
#########################################
#       IPTV List Updater		#
#     by Nobody28 & satinfo 		#
#########################################

from Screens.Screen import Screen
from Screens.MessageBox import MessageBox
from Components.ActionMap import ActionMap
from Components.Label import Label
import Components.config
from Plugins.Plugin import PluginDescriptor
from Components.config import config
from Tools.Directories import resolveFilename, SCOPE_PLUGINS
from Components.Language import language
from os import path, walk
from enigma import eEnv
from locale import _
from skin import *
from iptv import IPTV
from iptv import IPTV_Mod
from changelog import Changelog
from credits import Credits
from faq import FAQ
import os

Version = "1.20-26.10.13"

class Start(Screen):
	
	def __init__(self, session, args = None):

		self.session = session
		path = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/skins/original/Start.xml"
		print path
		with open(path, "r") as f:
			self.skin = f.read()
			f.close()
		
		Screen.__init__(self, session)
		
		self["title"] = Label(_("Version %s" % Version))
		self["maintain"] = Label(_("(c) by Nobody28 & satinfo"))
		self["link1"] = Label(_("www.opena.tv"))
		self["link2"] = Label(_("www.gigablue-support.com"))
		self["description"] = Label(_("Install & update IPTV streams from country list"))
		self["description2"] = Label(_("and add into TV Bouquet or Radio Bouquet"))
		self["thanks"] = Label(_("Special thanks goes to HasBahCa & FreeTuxTV for the links"))
		
		self["actions"] = ActionMap(["OkCancelActions", "WizardActions", "ColorActions", "SetupActions", "NumberActions", "EPGSelectActions"],
		{
			"ok": self.go,
			"back": self.close,
			"red": self.close,
			"green": self.go,
			"yellow": self.change,
			"blue": self.credits,
			"info": self.faq,
			"menu": self.mod,
		}, -1)
		self["key_red"] = Label(_("Close"))
		self["key_green"] = Label(_("Start"))
		self["key_yellow"] = Label(_("Changelog"))
		self["key_blue"] = Label(_("Credits"))
	
	def go(self):
		self.session.open(IPTV, Version)
		self.close()
	
	def mod(self):
		self.session.open(IPTV_Mod, Version)
		self.close()
		
	def credits(self):
		self.session.open(Credits)
				
	def change(self):
		self.session.open(Changelog)
		
	def faq(self):
		self.session.open(FAQ)
	
###########################################################################

def main(session, **kwargs):
	session.open(Start)
	pass

###########################################################################

def Plugins(**kwargs):
	return [PluginDescriptor(name = "IPTV List Updater %s" % Version, description = "IPTV Bouquets by Nobody28 & satinfo", where = [PluginDescriptor.WHERE_PLUGINMENU], fnc = main, icon = "plugin.png"),
			PluginDescriptor(name = "IPTV List Updater %s" % Version, description = "IPTV Bouquets by Nobody28 & satinfo", where = PluginDescriptor.WHERE_EXTENSIONSMENU, fnc=main)]
