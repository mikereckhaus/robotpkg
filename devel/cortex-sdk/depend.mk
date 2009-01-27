# $LAAS: depend.mk 2009/01/27 11:52:17 mallet $
#
# Copyright (c) 2008-2009 LAAS/CNRS
# All rights reserved.
#
# Redistribution and use  in source  and binary  forms,  with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   1. Redistributions of  source  code must retain the  above copyright
#      notice and this list of conditions.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice and  this list of  conditions in the  documentation and/or
#      other materials provided with the distribution.
#
#                                      Anthony Mallet on Tue Jul 15 2008
#

DEPEND_DEPTH:=		${DEPEND_DEPTH}+
CORTEX_SDK_DEPEND_MK:=	${CORTEX_SDK_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		cortex-sdk
endif

ifeq (+,$(CORTEX_SDK_DEPEND_MK)) # -----------------------------------------
PREFER.cortex-sdk?=	robotpkg

DEPEND_USE+=		cortex-sdk

DEPEND_ABI.cortex-sdk?=	cortex-sdk>=1.0.3
DEPEND_DIR.cortex-sdk?=	../../devel/cortex-sdk

SYSTEM_SEARCH.cortex-sdk=\
	bin/EVaComm2.dll		\
	include/EVaRT2.h

endif # CORTEX_SDK_DEPEND_MK -----------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}