CATEGORY ?= "Extensions"

plugindir = $(libdir)/enigma2/python/Plugins/$(CATEGORY)/$(PLUGIN)

LANGMO = $(LANGS:=.mo)
LANGPO = $(LANGS:=.po)

if UPDATE_PO
# the TRANSLATORS: allows putting translation comments before the to-be-translated line.
$(PLUGIN)-py.pot: $(srcdir)/../*.py
	$(XGETTEXT) -L python --from-code=UTF-8 --add-comments="TRANSLATORS:" -d $(PLUGIN) -s -o $@ $^

$(PLUGIN)-xml.pot: $(top_srcdir)/xml2po.py $(srcdir)/../*.xml
	$(PYTHON) $^ > $@

$(PLUGIN).pot: $(PLUGIN)-py.pot $(PLUGIN)-xml.pot
	cat $^ | $(MSGUNIQ) --no-location -o $@ -

%.po: $(PLUGIN).pot
	if [ -f $@ ]; then \
		$(MSGMERGE) --backup=none --no-location -s -N -U $@ $< && touch $@; \
	else \
		$(MSGINIT) -l $@ -o $@ -i $< --no-translator; \
	fi
endif

.po.mo:
	$(MSGFMT) -o $@ $<

BUILT_SOURCES = $(LANGMO)
CLEANFILES = $(LANGMO) $(PLUGIN)-py.pot $(PLUGIN)-xml.pot $(PLUGIN).pot

dist-hook: $(LANGPO)

install-data-local: $(LANGMO)
	for lang in $(LANGS); do \
		$(mkinstalldirs) $(DESTDIR)$(plugindir)/locale/$$lang/LC_MESSAGES; \
		$(INSTALL_DATA) $$lang.mo $(DESTDIR)$(plugindir)/locale/$$lang/LC_MESSAGES/$(PLUGIN).mo; \
	done

uninstall-local:
	for lang in $(LANGS); do \
		$(RM) $(DESTDIR)$(plugindir)/locale/$$lang/LC_MESSAGES/$(PLUGIN).mo; \
	done
