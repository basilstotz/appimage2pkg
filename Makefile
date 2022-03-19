.PHONY all:
all:
	@find packages -name "*.package" -exec ./bin/appimage2puavopkg \{\} \;
