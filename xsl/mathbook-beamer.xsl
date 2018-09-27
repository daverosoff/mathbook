<?xml version="1.0" encoding="UTF-8"?>

<!-- ********************************************************************
Copyright 2018 Dave Rosoff

This file is part of PreTeXt.

PreTeXt is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 or version 3 of the
License (at your option).

PreTeXt is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with PreTeXt.  If not, see <http://www.gnu.org/licenses/>.
********************************************************************* -->

<!-- http://pimpmyxslt.com/articles/entity-tricks-part2/ -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>

<!-- Identify as a stylesheet -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="exsl date str"
>

<xsl:import href="./mathbook-latex.xsl" />

<!-- Intend output for rendering by a web browser -->
<xsl:output method="text" />

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

</xsl:stylesheet>
