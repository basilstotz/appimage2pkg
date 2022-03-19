.PHONY all:
all:
	@find . -name "*.package" -exec ./bin/appimage2puavopkg \{\} \;
