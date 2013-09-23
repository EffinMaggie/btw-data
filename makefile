WGET:=wget
DATAURL:=http://www.bundeswahlleiter.de/de/bundestagswahlen/BTW_BUND_13/ergebnisse/
XSLTPROC:=xsltproc
TIDY:=tidy
INTERMEDIATE2013:=$(addsuffix -2013.sql,$(notdir $(wildcard data/www.bundeswahlleiter.de/de/bundestagswahlen/BTW_BUND_13/ergebnisse/wahlkreisergebnisse/*/wk*)))
SQLITE3:=sqlite3

all: election-2013.sql

clean:
	rm -f wk*.sql data-2013.sql election-2013.sql election-2013.sqlite3

scrub: clean
	rm -rf data

download:
	rm -rf data
	cd data && $(WGET) --mirror -np '$(DATAURL)'

wk%-2013.sql: data/www.bundeswahlleiter.de/de/bundestagswahlen/BTW_BUND_13/ergebnisse/wahlkreisergebnisse/l*/wk%/index.html xslt/sql-transcode-wk-html.xslt
	$(TIDY) -config tidy $< | $(XSLTPROC) --param year 2013 --param constituency $* xslt/sql-transcode-wk-html.xslt - > $@

data-2013.sql: $(INTERMEDIATE2013)
	cat $^ > $@

election-2013.sql: meta.sql data-2013.sql
	cat $^ > $@

%.sqlite3: %.sql
	rm -f $@* && $(SQLITE3) $@ < $^
