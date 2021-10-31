From 103825145055449a11f9b9f6062dc074153d4cde Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Wed, 28 Nov 2018 10:38:20 -0500
Subject: [PATCH] add libtool's -no-undefined flag

Otherwise libtool will refuse to build shared libraries on Cygwin,
MinGW, and possibly other platforms.
---
 src/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index a79b2610..8a929f50 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -56,7 +56,7 @@ dist_libfsm_la_SOURCES = \
 nodist_libfsm_la_SOURCES = \
 	version.h
 
-libfsm_la_LDFLAGS = -Wl,--no-undefined
+libfsm_la_LDFLAGS = -Wl,--no-undefined -no-undefined
 
 #
 # libragel: ragel program minus host-specific code
@@ -67,7 +67,7 @@ dist_libragel_la_SOURCES = \
 	parsedata.h parsetree.h inputdata.h pcheck.h reducer.h rlscan.h load.h \
 	parsetree.cc longest.cc parsedata.cc inputdata.cc load.cc reducer.cc
 
-libragel_la_LDFLAGS = -Wl,--no-undefined
+libragel_la_LDFLAGS = -Wl,--no-undefined -no-undefined
 libragel_la_LIBADD = libfsm.la $(COLM_LD)
 
 
-- 
2.17.0

