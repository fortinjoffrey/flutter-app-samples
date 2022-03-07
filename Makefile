get:
	fvm flutter pub get

generated:
	fvm flutter packages pub run build_runner build

generated-delete:
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs

all:
	$(MAKE) get
	$(MAKE) generated

all-clean:
	$(MAKE) get
	$(MAKE) generated-delete