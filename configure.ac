AC_INIT([enigma2-plugins],[3.0.0])
AM_INIT_AUTOMAKE([dist-bzip2 foreign no-define tar-pax])

# Silent rules are available since 1.11, but older versions
# are still in use. So don't use them unconditionally.
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_USE_SYSTEM_EXTENSIONS
AC_SYS_LARGEFILE

AC_PROG_CC
AC_PROG_CXX
m4_ifdef([LT_INIT], [LT_INIT], [AC_PROG_LIBTOOL])
AC_CONFIG_MACRO_DIR([m4])

AC_PATH_PROG(MSGFMT, msgfmt, AC_MSG_ERROR(Could not find msgfmt))

AM_PATH_PYTHON

AC_ARG_WITH(debug,
	AS_HELP_STRING([--without-debug],[disable debugging code]),
	[with_debug="$withval"],[with_debug="no"])
if test "$with_debug" = "yes"; then
	DEBUG_CFLAGS="-ggdb3"
	AC_DEFINE([DEBUG],[1],[Define to 1 to enable debugging code])
fi

AM_CONDITIONAL(UPDATE_PO, test "$with_po" = "yes")

CPPFLAGS="$CPPFLAGS $PYTHON_CPPFLAGS -include Python.h"
CFLAGS="$CFLAGS $DEBUG_CFLAGS -Wall"
CXXFLAGS="$CXXFLAGS $DEBUG_CFLAGS -Wall $ENIGMA2_CFLAGS $PTHREAD_CFLAGS"

AC_CONFIG_FILES([
Makefile
src/Makefile
src/changelog/Makefile
src/credits/Makefile
src/faq/Makefile
src/images/Makefile
src/list/Makefile
src/skins/Makefile
src/skins/original/Makefile
src/skins/original/buttons/Makefile
src/skins/original/images/Makefile
po/Makefile

])
AC_OUTPUT
