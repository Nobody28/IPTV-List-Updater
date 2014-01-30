# -*- coding: utf-8 -*-
#########################################
#            IPTV List Updater          #
#          by Nobody28 & satinfo        #
#########################################

from Screens.Screen import Screen
from Screens.MessageBox import MessageBox
from Screens.Standby import TryQuitMainloop
from Screens.Console import Console
from Components.ActionMap import ActionMap
from Components.Pixmap import Pixmap
from Components.Sources.StaticText import StaticText
from Components.Label import Label
import Components.config
from Components.MenuList import MenuList
from Components.config import config
from Components.Language import language
from Tools.Directories import resolveFilename, SCOPE_PLUGINS
from locale import _
from os import path, walk
from enigma import eConsoleAppContainer, eDVBDB, eEnv
from skin import *
from faq import FAQ
import os
import urllib2
import ssl


class IPTV(Screen):
                
    iptvlist =[]
    root = eEnv.resolve("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/images/")

    def __init__(self, session, args = None):

        self.session = session
        self.Version = args
        path = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/skins/original/IPTV.xml"
        print path
        with open(path, "r") as f:
            self.skin = f.read()
            f.close()
           
        Screen.__init__(self, session)
        
        self.iptvlist = []
        self.iptvname = ""
        self.IPTVInstalled = False
        self.countryPath = ""
        self.actual = None
        self.type = None
        self.getDownloadTxt()
        self.iptvlist.sort()
        self["IPTVList"] = MenuList(self.iptvlist)
        self["country"] = Pixmap()
        self["text1"] = Label(_("Select country from list to add into TV Bouquet or Radio Bouquet:"))
        
        self["actions"] = ActionMap(["OkCancelActions", "WizardActions", "ColorActions", "SetupActions", "NumberActions", "EPGSelectActions"],
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
            "info": self.faq,
        }, -1)
        self["key_red"] = Label(_("Close"))
        self["key_green"] = Label(_("Install"))
        self["key_yellow"] = Label(_("Install all"))
        self["key_blue"] = Label(_("Update list"))
        print"[IPTVList] Current Language: %s" % config.osd.language.getValue()
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
    
    def faq(self):
        self.session.open(FAQ)   
        
    def getDownloadTxt(self):
        downloadPath = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/list/%s.txt" % language.getLanguage()[:2]
        userlistPath = "/etc/enigma2/iptvlistupdater.user"
        
        if not path.exists(downloadPath):
            downloadPath = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/list/en.txt"

        self.downloadlist = []
        f = open(downloadPath,'r')
        tmp = f.readlines()
        f.close

        if path.exists(userlistPath): # if user have his own list, then add this to the selection
            f = open(userlistPath,'r')
            userlisttmp = f.readlines()
            f.close
            tmp = tmp + userlisttmp

        for l in tmp:
            if l.startswith('#'):
                continue
            if l.endswith('\n'): # Remove at the end "newline"
                l = l[:-1]

            ll = l.split(' ')
            if len(ll) >= 4:
                ll[3] = ll[3].replace('_\xc3', ' \xc3')
                ll[3] = ll[3].replace('_',' ')
                self.downloadlist.append(ll)
                self.iptvlist.append(ll[3])
            else:
                continue            

    def layoutFinished(self):
        self.loadCountry()

    def Add_Script(self, Bname, startbefore):
        if startbefore:
            Bname = "B_" + Bname
        else:
            Bname = "E_" + Bname
        startSH = '/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/%s.sh' % Bname
        print "[IPTVList] Check if %s.sh exists" % Bname
        if path.exists(startSH):
            print"[IPTVList] Adding %s to run list" % startSH
            self.ScriptList.append(startSH)
            if startbefore:
                self.Start_Script()
            
    def Start_Script(self):
        if self.ScriptList:
            self.session.openWithCallback(self.Start_ScriptCB, Console, title = _("Running script(s) , Please wait ..."), cmdlist = self.ScriptList, closeOnSuccess = True)

    def Start_ScriptCB(self):
        self.ScriptList = []
        pass
          
    def ok(self):
        self.IPTVInstalled = True
        self.ScriptList = []
        self.type = "TV"
        url = None
        sel = self["IPTVList"].l.getCurrentSelection()
        if sel == None:
            print"Nothing to select !!"
            return
        print"[IPTVList] Current selection: %s" % sel
        for l in self.downloadlist:
            self.convert = True
            if len(sel) >= 3:
                if sel == l[3]:
                    url = l[2]
                    if len(l) >= 5:
                        if l[4] == "B":
                            self.convert = False
                    self.type = l[1]
                    if self.type == "WEBCAM":
                        self.type = "TV"
                    break

        if url == None:
            self.session.open(MessageBox,_("Error, no url found"), MessageBox.TYPE_INFO)
            return

        name_file = self.file_filter(sel)
        self.Add_Script(name_file, True)
        file = self.Fetch_URL(url)
        if file.startswith("HTTP ERROR:") or file.startswith("HTTP download ERROR:") or file.startswith("HTTP URL ERROR:"):
            self.session.open(MessageBox,_(file), MessageBox.TYPE_INFO)
            return

        self.Convert_m3u(sel, file)
        infotext = _('IPTV List Updater %s\n' % self.Version)
        infotext += _('(c) by Nobody28 & satinfo\n\n')
        infotext += _('IPTV Streams from HasBahCa & FreeTuxTV')
        infotext += _('\n\n\n')
        infotext += _('Update Bouquets and Services for:')
        infotext += _(' %s\n' % sel.upper() + '\n')
        infotext += _('Press OK or EXIT to go back !')
        
        self.session.open(MessageBox,_(infotext), MessageBox.TYPE_INFO)
        self.Start_Script()

    def Fetch_URL(self, url):
        req = urllib2.Request(url)
        print "[IPTV List] Fetch URL: %s" %url
        try:
            response = urllib2.urlopen(req)
            last_modified = response.info().getdate('last-modified')  #  example ==> (2013, 7, 21, 20, 49, 19, 0, 1, 0)
            if last_modified:
                last_modified_date = str(last_modified[3])+ ":" + str(last_modified[4]) + " " + str(last_modified[2]) + "." + str(last_modified[1]) + "." + str(last_modified[0])
                print "File Last Modified: %s" % last_modified_date
            the_page = response.read()
        except urllib2.URLError as e:
            the_page = "HTTP URL ERROR: %s" % e
            print the_page
        except urllib2.HTTPError as e:
            the_page = "HTTP download ERROR: %s" % e.code
            print the_page
        return the_page

    def file_filter(self, name):
        name_file = name.replace('/','_')
        name_file = name_file.replace(' ','_')
        name_file = name_file.replace('\r','')
        name_file = name_file.replace('\n','')
        return name_file

    def Convert_m3u(self, name, file):
        name_file = self.file_filter(name)
        bouquetname = 'userbouquet.%s.%s' %(name_file.lower(), self.type.lower())
        tmp = ''
        tmplist = []
        tmplist.append('#NAME IPTV %s (%s)' % (name,self.type))
        tmplist.append('#SERVICE 1:64:0:0:0:0:0:0:0:0::%s Channels' % name)
        tmplist.append('#DESCRIPTION --- %s ---' % name)
        print"Converting Bouquet %s" % name
        l = file.split('\n')
        if self.convert:
            l.pop(0) # remove first line
        else:
            for t in range(1,4): # remove first 3 lines
                l.pop(0)

        for line in l:
            if line == '':
                continue
            if line.startswith("#EXTINF:"):
                line = line.replace('#EXTINF:-1,','#DESCRIPTION: ')
                line = line.replace('#EXTINF%3a0,','#DESCRIPTION: ')
                line = line.replace('#EXTINF:0,','#DESCRIPTION: ')
                tmp = line
            else:
                if self.type.upper() == 'TV' and self.convert:
                    line = line.replace(':','%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmp%3a','rtmp%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmpe%3a','rtmpe%3a')
                    line = line.replace('rtp%3a//@','#SERVICE 1:0:1:1:1:0:820000:0:0:0:http%3a//127.0.0.1%3a4050/rtp/')
                    if line.startswith('rtmp') or line.startswith('rtsp') or line.startswith('mms'):
                        line = '#SERVICE 4097:0:1:0:0:0:0:0:0:0:' + line
                    if not line.startswith("#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt"):
                        if line.startswith('http%3a'):
                            line = '#SERVICE 4097:0:1:0:0:0:0:0:0:0:' + line
                    tmplist.append(line)
                    tmplist.append(tmp)
                elif self.type.upper() == 'RADIO' and self.convert:
                    line = line.replace(':','%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmp%3a','rtmp%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmpe%3a','rtmpe%3a')
                    line = line.replace('rtp%3a//@','#SERVICE 1:0:1:1:1:0:820000:0:0:0:http%3a//127.0.0.1%3a4050/rtp/')
                    if line.startswith('rtmp') or line.startswith('rtsp') or line.startswith('mms'):
                        line = '#SERVICE 4097:0:2:0:0:0:0:0:0:0:' + line
                    if not line.startswith("#SERVICE 4097:0:2:0:0:0:0:0:0:0:rt"):
                        if line.startswith('http%3a'):
                            line = '#SERVICE 4097:0:2:0:0:0:0:0:0:0:' + line
                    tmplist.append(line)
                    tmplist.append(tmp)
                elif not self.convert:
                    tmplist.append(line)
                else:
                    print"UNKNOWN TYPE: %s" %self.type

        # check for proxy script
        self.Add_Script(name_file, False)

        # write bouquet file
        f = open('/etc/enigma2/' + bouquetname, 'w')
        for item in tmplist:
            f.write("%s\n" % item)
        f.close()

        # check if bouquet exists in bouquet file
        ff = open('/etc/enigma2/bouquets.%s' % self.type.lower(), 'r+')
        bouquets = ff.readlines()

        found = False
        for ll in bouquets:
            if ll.find(bouquetname) > -1:
                found = True
                break

        if found:
            print"Bouquetname exists, do nothing"
        else:
            print"Bouquetname doesn't exists, adding it"
            nline = '#SERVICE: 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "%s" ORDER BY bouquet\n' % bouquetname
            ff.write(nline)
        ff.close
        
    def cancel(self):
        if self.IPTVInstalled is True:
            infobox = self.session.open(MessageBox,_("Reloading Bouquets and Services..."), MessageBox.TYPE_INFO, timeout=5)
            infobox.setTitle(_("Info"))
            eDVBDB.getInstance().reloadBouquets()
            eDVBDB.getInstance().reloadServicelist()
        self.close()
            
    def install(self):
        self.IPTVInstalled = True
        self.ScriptList = []
        for l in self.downloadlist:
            self.convert = True
            url = l[2]
            self.type = l[1]
            if len(l) >= 5:
                if l[4] == "B":
                    self.convert = False
            if self.type == "WEBCAM":
                self.type = "TV"
            name_file = self.file_filter(l[3])
            print l[3], name_file
            self.Add_Script(name_file, True)
            file = self.Fetch_URL(url)
            if file.startswith("HTTP ERROR:"):
                self.session.open(MessageBox,_(file), MessageBox.TYPE_INFO)
                continue

            self.Convert_m3u(l[3], file)
            infotext = _('IPTV List Updater %s\n' % self.Version)
            infotext += _('(c) by Nobody28 & satinfo\n\n')
            infotext += _('IPTV Streams from HasBahCa & FreeTuxTV')
            infotext += _('\n\n\n')
            infotext += _('Update Bouquets and Services for:')
            infotext += _('\n')
            infotext += _('Press OK or EXIT to go back !')
        
        self.session.open(MessageBox,_(infotext), MessageBox.TYPE_INFO)
        self.Start_Script()
        
    def loadCountry(self):
        pngpath = self["IPTVList"].getCurrent()

        if pngpath == None:
            return

        for l in self.downloadlist:
            if len(l) >= 3:
                if pngpath == l[3]:
                    pngpath = l[0]
                    break

        try:
            pngpath = pngpath + (".png")
            pngpath = self.root + pngpath
        except AttributeError:
            pngpath = resolveFilename("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/images/noprev.png")
            
        if not path.exists(pngpath):
            pngpath = eEnv.resolve("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/images/noprev.png")
        if self.countryPath != pngpath:
            self.countryPath = pngpath
            
        self["country"].instance.setPixmapFromFile(self.countryPath)
        Screen.hide(self)
        Screen.show(self)
        
class IPTV_Mod(Screen):
                
    iptvlist =[]
    root = eEnv.resolve("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/images/")

    def __init__(self, session, args = None):
    
        self.session = session
        self.Version = args
        path = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/skins/original/IPTV.xml"
        print path
        with open(path, "r") as f:
            self.skin = f.read()
            f.close()
          
        Screen.__init__(self, session)
        
        self.iptvlist = []
        self.iptvname = ""
        self.IPTVInstalled = False
        self.countryPath = ""
        self.actual = None
        self.type = None
        self.getDownloadTxt()
        self.iptvlist.sort()
        self["IPTVList"] = MenuList(self.iptvlist)
        self["country"] = Pixmap()
        self["text1"] = Label(_("Select country from list to add into TV Bouquet or Radio Bouquet:"))
        
        self["actions"] = ActionMap(["OkCancelActions", "WizardActions", "ColorActions", "SetupActions", "NumberActions", "EPGSelectActions"],
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
            "info": self.faq,
        }, -1)
        self["key_red"] = Label(_("Close"))
        self["key_green"] = Label(_("Install"))
        self["key_yellow"] = Label(_("Install all"))
        self["key_blue"] = Label(_("Update list"))
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
    
    def faq(self):
        self.session.open(FAQ)
        
    def getDownloadTxt(self):
        downloadPath = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/list/%s.txt" % language.getLanguage()[:2]
        if not path.exists(downloadPath):
            downloadPath = "/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/list/en.txt"

        self.downloadlist = []
        f = open(downloadPath,'r')
        tmp = f.readlines()
        f.close
                
        for l in tmp:
            if l.startswith('#'):
                continue
            if l.endswith('\n'): # Remove at the end "newline"
                l = l[:-1]

            ll = l.split(' ')
            if len(ll) >= 4:
                ll[3] = ll[3].replace('_',' ')
                self.downloadlist.append(ll)
                self.iptvlist.append(ll[3])
            else:
                continue

    def layoutFinished(self):
        self.loadCountry()
            
    def ok(self):
        self.IPTVInstalled = True
        self.type = "TV"
        sel = self["IPTVList"].l.getCurrentSelection()
        if sel == None:
            print"Nothing to select !!"
            return
        for l in self.downloadlist:
            self.convert = True
            if len(sel) >= 4:
                if sel == l[3]:
                    url = l[2]
                    if len(l) >= 5:
                        if l[4] == "B":
                            self.convert = False
                    self.type = l[1]
                    if self.type == "WEBCAM":
                        self.type = "TV"
                    break

        file = self.Fetch_URL(url)
        if file.startswith("HTTP ERROR:") or file.startswith("HTTP download ERROR:") or file.startswith("HTTP URL ERROR:"):
            self.session.open(MessageBox,_(file), MessageBox.TYPE_INFO)
            return

        self.Convert_m3u(sel, file)
        infotext = _('IPTV List Updater %s\n' % self.Version)
        infotext += _('(c) by Nobody28 & satinfo\n\n')
        infotext += _('IPTV Streams from HasBahCa & FreeTuxTV')
        infotext += _('\n\n\n')
        infotext += _('Update Bouquets and Services for:')
        infotext += _(' %s\n' % sel.upper() + '\n')
        infotext += _('Press OK or EXIT to go back !')
        
        self.session.open(MessageBox,_(infotext), MessageBox.TYPE_INFO)

    def Fetch_URL(self, url):
        req = urllib2.Request(url)
        print "[IPTV List] Fetch URL: %s" %url
        try:
            response = urllib2.urlopen(req)
            last_modified = response.info().getdate('last-modified')  #  example ==> (2013, 7, 21, 20, 49, 19, 0, 1, 0)
            if last_modified:
                last_modified_date = str(last_modified[3])+ ":" + str(last_modified[4]) + " " + str(last_modified[2]) + "." + str(last_modified[1]) + "." + str(last_modified[0])
                print "File Last Modified: %s" % last_modified_date
            the_page = response.read()
        except urllib2.URLError as e:
            the_page = "HTTP URL ERROR: %s" % e
            print the_page
        except urllib2.HTTPError as e:
            the_page = "HTTP download ERROR: %s" % e.code
            print the_page
        return the_page

    def Convert_m3u(self, name, file):
        name_file = name.replace('/','_')
        name_file = name_file.replace(' ','_')
        bouquetname = 'userbouquet.%s.%s' %(name_file.lower(), self.type.lower())
        tmp = ''
        tmplist = []
        tmplist.append('#NAME IPTV %s (%s)' % (name,self.type))
        tmplist.append('#SERVICE 1:64:0:0:0:0:0:0:0:0::%s Channels' % name)
        tmplist.append('#DESCRIPTION --- %s ---' % name)
        print"Converting Bouquet %s" % name
        l = file.split('\n')
        if self.convert:
            l.pop(0) # remove first line
        else:
            for t in range(1,4): # remove first 3 lines
                l.pop(0)

        for line in l:
            if line == '':
                continue
            if line.startswith("#EXTINF:"):
                line = line.replace('#EXTINF:-1,','#DESCRIPTION: ')
                line = line.replace('#EXTINF%3a0,','#DESCRIPTION: ')
                line = line.replace('#EXTINF:0,','#DESCRIPTION: ')
                tmp = line
            else:
                if self.type.upper() == 'TV' and self.convert:
                    line = line.replace(':','%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmp%3a','rtmp%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmpe%3a','rtmpe%3a')
                    line = line.replace('rtp%3a//@','#SERVICE 1:0:1:1:1:0:820000:0:0:0:http%3a//127.0.0.1%3a4050/rtp/')
                    if line.startswith('rtmp') or line.startswith('rtsp') or line.startswith('mms'):
                        line = '#SERVICE 1:0:1:1:1:0:820000:0:0:0:' + line
                    if not line.startswith("#SERVICE 1:0:1:1:1:0:820000:0:0:0:rt"):
                        if line.startswith('http%3a'):
                            line = '#SERVICE 1:0:1:1:1:0:820000:0:0:0:' + line
                    tmplist.append(line)
                    tmplist.append(tmp)
                elif self.type.upper() == 'RADIO' and self.convert:
                    line = line.replace(':','%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmp%3a','rtmp%3a')
                    line = line.replace('rtmp%3a//$OPT%3artmp-raw=rtmpe%3a','rtmpe%3a')
                    line = line.replace('rtp%3a//@','#SERVICE 1:0:1:1:1:0:820000:0:0:0:http%3a//127.0.0.1%3a4050/rtp/')
                    if line.startswith('rtmp') or line.startswith('rtsp') or line.startswith('mms'):
                        line = '#SERVICE 1:0:1:1:1:0:820000:0:0:0:' + line
                    if not line.startswith("#SERVICE 1:0:1:1:1:0:820000:0:0:0:rt"):
                        if line.startswith('http%3a'):
                            line = '#SERVICE 1:0:1:1:1:0:820000:0:0:0:' + line
                    tmplist.append(line)
                    tmplist.append(tmp)
                elif not self.convert:
                    tmplist.append(line)
                else:
                    print"UNKNOWN TYPE: %s" %self.type

        # write bouquet file
        f = open('/etc/enigma2/' + bouquetname, 'w')
        for item in tmplist:
            f.write("%s\n" % item)
        f.close()

        # check if bouquet exists in bouquet file
        ff = open('/etc/enigma2/bouquets.%s' % self.type.lower(), 'r+')
        bouquets = ff.readlines()

        found = False
        for ll in bouquets:
            if ll.find(bouquetname) > -1:
                found = True
                break

        if found:
            print"Bouquetname exists, do nothing"
        else:
            print"Bouquetname doesn't exists, adding it"
            nline = '#SERVICE: 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "%s" ORDER BY bouquet\n' % bouquetname
            ff.write(nline)
        ff.close
        
    def cancel(self):
        if self.IPTVInstalled is True:
            infobox = self.session.open(MessageBox,_("Reloading Bouquets and Services..."), MessageBox.TYPE_INFO, timeout=5)
            infobox.setTitle(_("Info"))
            eDVBDB.getInstance().reloadBouquets()
            eDVBDB.getInstance().reloadServicelist()
        self.close()
            
    def install(self):
        self.IPTVInstalled = True
        for l in self.downloadlist:
            self.convert = True
            url = l[2]
            self.type = l[1]
            if len(l) >= 5:
                if l[4] == "B":
                    self.convert = False
            if self.type == "WEBCAM":
                self.type = "TV"
            file = self.Fetch_URL(url)
            if file.startswith("HTTP ERROR:"):
                self.session.open(MessageBox,_(file), MessageBox.TYPE_INFO)
                continue

            self.Convert_m3u(l[3], file)
            infotext = _('IPTV List Updater %s\n' % self.Version)
            infotext += _('(c) by Nobody28 & satinfo\n\n')
            infotext += _('IPTV Streams from HasBahCa & FreeTuxTV')
            infotext += _('\n\n\n')
            infotext += _('Update Bouquets and Services for:')
            infotext += _('\n')
            infotext += _('Press OK or EXIT to go back !')
        
        self.session.open(MessageBox,_(infotext), MessageBox.TYPE_INFO)
        
    def loadCountry(self):
        pngpath = self["IPTVList"].getCurrent()

        if pngpath == None:
            return

        for l in self.downloadlist:
            if len(l) >= 3:
                if pngpath == l[3]:
                    pngpath = l[0]
                    break

        try:
            pngpath = pngpath + (".png")
            pngpath = self.root + pngpath
        except AttributeError:
            pngpath = resolveFilename("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/images/noprev.png")
            
        if not path.exists(pngpath):
            pngpath = eEnv.resolve("/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/images/noprev.png")
        if self.countryPath != pngpath:
            self.countryPath = pngpath
            
        self["country"].instance.setPixmapFromFile(self.countryPath)
        Screen.hide(self)
        Screen.show(self)
