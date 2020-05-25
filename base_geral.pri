#
# Definições gerais para a grande maioria de projetos em Qt.
#
# Diferenças podem ser ajustadas após a inclusão deste arquivo no projeto.
#
# Exige a definição dos parâmetros:
#
# REV_MAJOR_CODE = x
# REV_MINOR_CODE = y
# REV_PATCH_CODE = z
# PROJECT_DIR=$$PWD

GENERATED_FILES_PATH_BASE = ./

unix {
	ARCH = $$system(uname -m)

	#QMAKE_CXXFLAGS -= "-std=gnu++14"
	#QMAKE_CXXFLAGS -= "-std=gnu++11"
	#QMAKE_CXXFLAGS += "-std=gnu++03 -pedantic"
	#QMAKE_CXXFLAGS += "-std=gnu++98 -pedantic"

	#QMAKE_CFLAGS += "-std=gnu99"

	#CONFIG -= c++14
	#CONFIG -= c++11
	#CONFIG -= GNU++11
	#CONFIG += c++98
	#CONFIG += GNU++98

	# # QMAKE_LFLAGS_DEBUG =
	# QMAKE_LFLAGS_RELEASE = -Wl,--as-needed -O1
	# QMAKE_CFLAGS_DEBUG -= -g
	# QMAKE_CXXFLAGS_DEBUG -= -g
	QMAKE_CFLAGS_DEBUG += -Og -O0 -ggdb
	QMAKE_CXXFLAGS_DEBUG += -Og -O0 -ggdb
	QMAKE_CFLAGS_RELEASE -= -O2 -ggdb
	QMAKE_CXXFLAGS_RELEASE -= -O2 -ggdb
	# QMAKE_CFLAGS_RELEASE += -O3 -mtune=native -march=native -mfpmath=sse -momit-leaf-frame-pointer -msahf -mcx16 -pipe
	# QMAKE_CXXFLAGS_RELEASE += -O3 -mtune=native -march=native -mfpmath=sse -momit-leaf-frame-pointer -msahf -mcx16 -pipe


	op3=$$find(ARCH,"x86_64")
	count (op3,1) {
		QMAKE_CFLAGS_RELEASE += -mfpmath=sse -momit-leaf-frame-pointer -msahf -mcx16 -pipe
		QMAKE_CXXFLAGS_RELEASE += -mfpmath=sse -momit-leaf-frame-pointer -msahf -mcx16 -pipe
		# CONFIG += link_prl  mmx sse sse2
		CONFIG += mmx sse sse2
	}

	defineReplace(BasePath)	{
		GENERATED_FILES_PATH = $$system(A=`whoami` && echo "/run/user/"`id -u $A`"/")
		# GENERATED_FILES_PATH = $$system(A=`whoami` && echo "/tmp/")
		return ($$GENERATED_FILES_PATH)
	}

	GENERATED_FILES_PATH_BASE = $$BasePath()$$TARGET/
}

win32: GENERATED_FILES_PATH_BASE = "Z:\\"$$TARGET"\\"

UI_DIR += $$GENERATED_FILES_PATH_BASE"GeneratedFiles"
RCC_DIR += $$GENERATED_FILES_PATH_BASE"GeneratedFiles"
MOC_DIR += $$GENERATED_FILES_PATH_BASE"GeneratedFiles"
INCLUDEPATH += $$GENERATED_FILES_PATH_BASE"GeneratedFiles" ./

release {
	INCLUDEPATH += $$GENERATED_FILES_PATH_BASE"GeneratedFiles/release"
	OBJECTS_DIR = $$GENERATED_FILES_PATH_BASE"GeneratedFiles/release"
	DEFINES -= _DEBUG
	DEFINES += _NO_DEBUG
	MODO="RELEASE"
}

debug	{
	INCLUDEPATH += $$GENERATED_FILES_PATH_BASE"GeneratedFiles/debug"
	OBJECTS_DIR = $$GENERATED_FILES_PATH_BASE"GeneratedFiles/debug"
	DEFINES -= _NO_DEBUG
	DEFINES += _DEBUG
	MODO="DEBUG"
}


VER = $$REV_MAJOR_CODE $$REV_MINOR_CODE $$REV_PATCH_CODE
VERSAO = $$join(VER, ".")

DEFINES += \
	REV_PATCH_CODE=$$REV_PATCH_CODE \
	REV_MINOR_CODE=$$REV_MINOR_CODE \
	REV_MAJOR_CODE=$$REV_MAJOR_CODE \
	REV_CODE=\\\"$$VERSAO\\\" \
	APP_VERSION=\\\"$$VERSAO\\\" \
	APP_NAME=\\\"$$TARGET\\\" \
	ARCH_$$ARCH

unix: DEFINES += _LINUX QT_DLL

win32: DEFINES += _WINDOWS WIN32 _WIN32_WINNT=0x0502


unix:  message($$DESTDIR/$$TARGET V.: $$VERSAO -  Qt: $$QT_VERSION  -  Compilador $$QMAKE_COMPILER  -  modo: $$MODO  -  opcoes: $$CONFIG  -  arquitetura $$ARCH)
win32: message($$DESTDIR/$$TARGET V.: $$VERSAO -  Qt: $$QT_VERSION  -  Compilador $$QMAKE_COMPILER  -  modo: $$MODO  -  opcoes: $$CONFIG - WIN32)
win64: message($$DESTDIR/$$TARGET V.: $$VERSAO -  Qt: $$QT_VERSION  -  Compilador $$QMAKE_COMPILER  -  modo: $$MODO  -  opcoes: $$CONFIG - WIN64)