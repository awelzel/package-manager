VERSION=`cat VERSION`

.PHONY: all
all:

.PHONY: doc
doc: man html

.PHONY: man
man:
	(cd doc && make man && mkdir -p man && cp _build/man/zkg.1 man)

.PHONY: html
html:
	(cd doc && make html)

.PHONY: livehtml
livehtml:
	(cd doc && make livehtml)

.PHONY: test
test:
	@( cd testing && make )

.PHONY: upload
upload: twine-check
	ZKG_PYPI_DIST=yes python setup.py bdist_wheel
	twine upload -u bro dist/bro_pkg-$(VERSION)-py2.py3-none-any.whl

.PHONY: twine-check
twine-check:
	@type twine > /dev/null 2>&1 || \
		{ \
		echo "Uploading to PyPi requires 'twine' and it's not found in PATH."; \
		echo "Install it and/or make sure it is in PATH."; \
		echo "E.g. you could use the following command to install it:"; \
		echo "\tpip install twine"; \
		echo ; \
		exit 1; \
		}
