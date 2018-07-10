<?xml version='1.0'?>

<!--********************************************************************
Copyright 2014 Robert A. Beezer

This file is part of MathBook XML.

MathBook XML is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 or version 3 of the
License (at your option).

MathBook XML is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with MathBook XML.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************-->

<!-- Identify as a stylesheet -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:b64="https://github.com/ilyakharlamov/xslt_base64"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="b64"
    extension-element-prefixes="exsl date str"
>

<xsl:import href="./mathbook-html.xsl" />

<!-- Intend output for rendering by a web browser -->
<xsl:output method="html" encoding="utf-8"/>

<xsl:template match="/mathbook">
	<xsl:apply-templates select="slideshow" />
</xsl:template>

<!-- stops recursion up the tree -->
<xsl:template match="slideshow" mode="is-structural">
    <xsl:value-of select="true()" />
</xsl:template>

<!-- Don't chunk -->
<xsl:variable name="chunk-level">
    <xsl:text>0</xsl:text>
</xsl:variable>


<xsl:template match="slideshow">
	<xsl:text disable-output-escaping='yes'><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
		"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title><xsl:apply-templates select="title" /></title>
	<!-- metadata -->
	<meta name="generator" content="S5" />
	<meta name="version" content="S5 1.1" />
	<meta name="presdate" content="20050728" />
	<meta name="author" content="Eric A. Meyer" />
	<meta name="company" content="Complex Spiral Consulting" />
	<!-- configuration parameters -->
	<meta name="defaultView" content="slideshow" />
	<meta name="controlVis" content="hidden" />
	<!-- style sheet links -->
	<link rel="stylesheet" href="ui/default/slides.css" type="text/css" media="projection" id="slideProj" />
	<link rel="stylesheet" href="ui/default/outline.css" type="text/css" media="screen" id="outlineStyle" />
	<link rel="stylesheet" href="ui/default/print.css" type="text/css" media="print" id="slidePrint" />
	<link rel="stylesheet" href="ui/default/opera.css" type="text/css" media="projection" id="operaFix" />
	<link rel="stylesheet" href="mathbook-add-on.css" type="text/css" />
	<!-- S5 JS -->
	<script src="ui/default/slides.js" type="text/javascript"></script>
	<!-- Using the google code prettifier is a not a good idea out of the box    -->
	<!-- It just "colorizes" what S5 does onto an already gray background        -->
	<!-- Maybe overriding MBX's choice of color scheme, and/or adding style      -->
	<!-- background-image: none; background-color: #FFF would allow co-existence -->
	<!-- <xsl:call-template name="goggle-code-prettifier" />                     -->
	<!--  -->
	<!-- Add support for MathJax -->
    <xsl:call-template name="mathjax" />
	<!-- Add support for Sage Cells -->
	<xsl:call-template name="makesagecell" />
	</head>
	<body>

	<div class="layout">
	<div id="controls"></div>
	<div id="currentSlide"></div>
	<div id="header"></div>
	<div id="footer">
	<h1>
		<xsl:apply-templates select="frontmatter/titlepage/event" />
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="frontmatter/titlepage/date" />
	</h1>
	<h2><xsl:apply-templates select="title" /></h2>
	</div>
	</div>

	<div class="presentation mathbook-content">
		<xsl:apply-templates select="." mode="title-slide" />
		<xsl:apply-templates select="slide" />
	</div>
	</body>
	</html>
</xsl:template>

<xsl:template match="*" mode="title-slide">
	<div class="slide">
		<h1><xsl:apply-templates select="title" /></h1>
		<h2><xsl:apply-templates select="subtitle" /></h2>
		<xsl:apply-templates select="frontmatter/titlepage/author" />
	</div>
</xsl:template>

<xsl:template match="author">
	<h3><xsl:apply-templates select="personname" /></h3>
	<h4><xsl:apply-templates select="affiliation" /></h4>
</xsl:template>

<xsl:template match="slide">
	<div class="slide">
		<h1>
			<xsl:apply-templates select="title" />
		</h1>
		<div class="slidecontent">
			<xsl:apply-templates select="*[not(self::title or self::handout)]" />
		</div>
		<div class="handout">
			<xsl:apply-templates select="handout" />
		</div>
	</div>
</xsl:template>

<!-- Height for 1024x768 target resolution -->
<xsl:template match="embed">
	<xsl:element name="object">
		<xsl:attribute name="data"><xsl:value-of select="@href" /></xsl:attribute>
		<xsl:attribute name="type">text/html</xsl:attribute>
		<!-- <xsl:attribute name="width"><xsl:value-of select="@width" />vw</xsl:attribute> -->
		<xsl:attribute name="height">555</xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="style">border: 1px solid black;</xsl:attribute>
	</xsl:element>
</xsl:template>



	<!-- <object data="http://scholar.google.com/" type="text/html" width="780" height="400" style="border: 1px solid black;"> -->

</xsl:stylesheet>
