# robotpkg Makefile for:	youbot/youbot-applications
#

YOUBOT_APPLICATIONS_VERSION=	0.1
DISTNAME=		youbot-applications-${YOUBOT_APPLICATIONS_VERSION}
PKGNAME=		youbot-applications-${YOUBOT_APPLICATIONS_VERSION}
CATEGORIES=		youbot
MASTER_SITES=		http://brics.inf.h-brs.de/
#MASTER_REPOSITORY= 	git git://github.com/b-it-bots/youbot-stack.git

MAINTAINER=		Walter Nowak 
HOMEPAGE=		http://youbot-store.com
COMMENT=		Applications for the KUKA youBot
LICENSE=		gnu-lgpl-v2.1 modified-bsd

NO_CONFIGURE=		yes
NO_BUILD=		yes
NO_EXTRACT=		yes
#NO_INSTALL= 		no


do-install:
	${RUN} tar -C $(ROBOTPKG_BASE) -xvf ${DISTDIR}/${DISTNAME}${EXTRACT_SUFX}

include ../../hardware/youbot-driver/depend.mk
include ../../mk/robotpkg.mk

