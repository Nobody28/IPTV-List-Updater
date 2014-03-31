#
# to use this for the localisation of other plugins,
# just change the DOMAIN to the name of the Plugin.
# It is assumed, that the domain ist the same as
# the directory name of the plugin.
#

DOMAIN=IPTV-List-Updater
installdir = /usr/lib/enigma2/python/Plugins/Extensions/$(DOMAIN)
#GETTEXT=./pygettext.py
GETTEXT=xgettext

#MSGFMT = ./msgfmt.py
MSGFMT = msgfmt

LANGS := ar de en fa hu it nl pl tr sr ru sk
LANGPO := $(foreach LANG, $(LANGS),$(LANG).po)
LANGMO := $(foreach LANG, $(LANGS),$(LANG).mo)

default: $(DOMAIN).pot $(LANGPO) merge $(LANGMO)
	for lang in $(LANGS); do \
		mkdir -p $$lang/LC_MESSAGES; \
		cp $$lang.mo $$lang/LC_MESSAGES/$(DOMAIN).mo; \
                cp $$lang.po $$lang/LC_MESSAGES/$$lang.po; \
	done

merge:
	for lang in $(LANGS); do \
		msgmerge --no-location -s -N -U $$lang.po $(DOMAIN).pot; \
	done


# the TRANSLATORS: allows putting translation comments before the to-be-translated line.
$(DOMAIN).pot:
	$(GETTEXT) -L python --add-comments="TRANSLATORS:" -d $(DOMAIN) -s -o $(DOMAIN).pot ../*.py

	../xml2po.py ../ >> $(DOMAIN).pot

	msguniq -o $(DOMAIN)uniq.pot $(DOMAIN).pot

.PHONY: $(DOMAIN).pot


%.mo: %.po
	$(MSGFMT) -o $@ $<

%.po:
	msginit -l $@ -o $@ -i $(DOMAIN).pot --no-translator

CLEANFILES = $(foreach LANG, $(LANGS),$(LANG).mo)

clean-local:
	$(RM) -r $(LANGS)

install-data-am: default
	for lang in $(LANGS); do \
		mkdir -p $(DESTDIR)$(installdir)/locale/$$lang/LC_MESSAGES; \
		cp $$lang.mo $(DESTDIR)$(installdir)/locale/$$lang/LC_MESSAGES/$(DOMAIN).mo; \
                cp $$lang.po $(DESTDIR)$(installdir)/locale/$$lang/LC_MESSAGES/$$lang.po; \
	done
