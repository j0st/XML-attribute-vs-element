<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> <!-- Es wird über jedes Element interiert, Elementnamen als Attributnamen genommen und Elementext als Attributtext-->
    <xsl:template match="car_database">
        <car_database>
            <xsl:apply-templates/>
        </car_database>
    </xsl:template>
    
    <xsl:template match="car">
        <car>
            <xsl:for-each select="*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="text()"/>
                </xsl:attribute>
            </xsl:for-each>
        </car>
    </xsl:template>
</xsl:stylesheet>