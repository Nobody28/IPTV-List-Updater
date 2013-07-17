# -*- coding: utf-8 -*-
#########################################
#            IPTV List Updater          #
#          by Nobody28 & satinfo        #
#########################################

from Screens.Screen import Screen
from Screens.MessageBox import MessageBox
from Components.ActionMap import NumberActionMap
from Components.Sources.StaticText import StaticText
from Components.Label import Label
from Components.ScrollLabel import ScrollLabel
import Components.config
from Components.config import config
from Tools.Directories import resolveFilename, SCOPE_PLUGINS
from Components.Language import language
from os import path, walk
from os import environ as os_environ
from enigma import eEnv
from locale import _
from skin import *
import os


class Changelog(Screen):
    
    def __init__(self, session, args = None):
        
        self.session = session
        path = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/skins/original/Changelog.xml"
        print path
        with open(path, "r") as f:
            self.skin = f.read()
            f.close()
        
        Screen.__init__(self, session)    

        self["title"] = Label(_("Version 1.10"))
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
        self.file = open("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/changelog/changelog.txt","r")
        self.text = self.file.read()
        self.file.close()
        return self.text
