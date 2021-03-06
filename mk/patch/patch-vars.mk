#
# Copyright (c) 2006-2009,2011 LAAS/CNRS
# Copyright (c) 1994-2006 The NetBSD Foundation, Inc.
# All rights reserved.
#
# This project includes software developed by the NetBSD Foundation, Inc.
# and its contributors. It is derived from the 'pkgsrc' project
# (http://www.pkgsrc.org).
#
# Redistribution  and  use in source   and binary forms,  with or without
# modification, are permitted provided that  the following conditions are
# met:
#
#   1. Redistributions  of  source code must  retain  the above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must  reproduce the above copyright
#      notice,  this list of  conditions and  the following disclaimer in
#      the  documentation   and/or  other  materials   provided with  the
#      distribution.
#   3. All  advertising  materials  mentioning  features or  use of  this
#      software must display the following acknowledgement:
#        This product includes software developed by the NetBSD
#        Foundation, Inc. and its contributors.
#   4. Neither the  name  of The NetBSD Foundation  nor the names  of its
#      contributors  may be  used to endorse or promote  products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
# ANY  EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES   OF MERCHANTABILITY AND  FITNESS  FOR  A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO  EVENT SHALL THE AUTHOR OR  CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT,  INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING,  BUT  NOT LIMITED TO, PROCUREMENT  OF
# SUBSTITUTE  GOODS OR SERVICES;  LOSS   OF  USE,  DATA, OR PROFITS;   OR
# BUSINESS  INTERRUPTION) HOWEVER CAUSED AND  ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE  USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# From $NetBSD: bsd.patch-vars.mk,v 1.3 2006/07/13 14:02:34 jlam Exp $
#
#                                       Anthony Mallet on Sat Dec  2 2006
#

# This Makefile fragment is included by robotpkg.mk and defines some
# variables for the patch target.
#
# The following variables may be set in a package Makefile:
#
#    PATCHFILES
#	is a list of distribution patches relative to ${_DISTDIR} that
#	are applied first to the package.
#
#    PATCHDIR
#	is the location of the robotpkg patches for the package. This defaults
#	to the "patches" subdirectory of the package directory.
#

# The default PATCHDIR is currently set in robotpkg.prefs.mk
#PATCHDIR?=	${CURDIR}/patches

_PATCH_APPLIED_FILE=	${WRKDIR}/.patch
_COOKIE.patch=		${WRKDIR}/.patch_cookie


# --- patch (PUBLIC) -------------------------------------------------
#
# patch is a public target to apply the distribution and pkgsrc
# patches to the extracted sources for the package.
#
ifneq (,$(or ${PATCHFILES},$(filter yes,$(call exists,${PATCHDIR}))))
  include ${ROBOTPKG_DIR}/mk/patch/patch.mk
else
  ifeq (yes,$(call exists,${_COOKIE.patch}))
    patch:
	@${DO_NADA}
  else
    $(call require, ${ROBOTPKG_DIR}/mk/extract/extract-vars.mk)

    patch: $(call add-barrier, bootstrap-depends, patch)
    ifdef _EXTRACT_IS_CHECKOUT
      patch: checkout patch-cookie;
    else
      patch: extract patch-cookie;
    endif
  endif
endif


# --- patch-cookie (PRIVATE) -----------------------------------------
#
# patch-cookie creates the "patch" cookie file.  The contents are
# the paths to the patches that were applied (if any).
#
.PHONY: patch-cookie
patch-cookie:
	${RUN}${TEST} ! -f ${_COOKIE.patch} || ${FALSE}
	${RUN}exec >>${_COOKIE.patch};					\
	${ECHO} "_COOKIE.patch.date:=`${_CDATE_CMD}`";			\
	${ECHO} "_COOKIE.patch.applied:=";				\
	if ${TEST} -f ${_PATCH_APPLIED_FILE}; then			\
	  ${SED} -e 's/^/_COOKIE.patch.applied+=/'			\
		<${_PATCH_APPLIED_FILE};				\
	  ${RM} -f ${_PATCH_APPLIED_FILE};				\
	fi
