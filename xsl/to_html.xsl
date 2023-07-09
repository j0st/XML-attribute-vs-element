<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    .green {
                        color: #12961b;
                    }
                    table.scrolldown {
                        width: 100%;
                        border-spacing: 0;
                        border: 2px solid black;
                    }
                    
                    table.scrolldown tbody,
                    table.scrolldown thead {
                        display: block;
                    }
                    
                    thead tr th {
                        height: 20px;
                        line-height: 20px;
                    }
                    
                    table.scrolldown tbody {
                        height: 100px;
                        overflow-y: auto;
                        overflow-x: hidden;
                    }
                    
                    tbody {
                        border-top: 2px solid black;
                    }
                    
                    tbody td,
                    thead th {
                        width: 100%;
                        border-right: 2px solid black;
                    }
                    td {
                        text-align: left;
                    }
                    
                    .font1 {
                        font-family: Arial, Helvetica, sans-serif;
                    }
                    .center {
                        text-align: center;
                    }
                    #table1 {
                        font-family: Arial, Helvetica, sans-serif;
                        border-collapse: collapse;
                        width: 100%;
                        border-spacing: 0;
                        border: 2px solid black;
                    }
                    
                    #table1 td,
                    #table1 th {
                        border: 1px solid #ddd;
                        padding: 8px;
                    }
                    
                    #table1 tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                    
                    #table1 tr:hover {
                        background-color: #ddd;
                    }
                    
                    #table1 th {
                        padding-top: 12px;
                        padding-bottom: 12px;
                        text-align: left;
                        background-color: #0499aa;
                        color: white;
                    }</style>
            </head>
            <body>
                <h2 class="center font1">Laufzeit von verschiedenen XML Strukturen/XPath Ausdrücken
                    am Beispiel einer Autodatenbank</h2>
                <h3 class="font1">Einleitung</h3>
                <p class="font1">Ziel dieser Darstellung ist, die Laufzeit von XPath Ausdrücken für
                    Suchanfragen innerhalb einer Autodatenbank zu vergleichen. Die Autodatenbank
                    liegt dabei in zwei verschiedenen XML Strukturen vor. Die erste Struktur besteht
                    ausschließlich aus Elementen, wobei das Wurzelelement &lt;car_database&gt; ist,
                    gefolgt von den Kinderelementen &lt;car&gt;, welche jedes der über 30.000 Autos
                    in der Datenbank abbildet. Innerhalb des &lt;car&gt;-Elementes befinden sich die
                    jeweiligen Spezifikationen des Autos, wie beispielsweise das Modell, der
                    Listenpreis und so weiter als Element verpackt. Die zweite Struktur hat dasselbe
                    Wurzel- und Kinderelement. Der entscheidende Unterschied ist jedoch, dass
                    innerhalb des &lt;car&gt;-Elements die Spezifikationen ausschließlich als
                    Attribute vorhanden sind. Die zentrale Frage dieses Projektes ist also, welche
                    Modellierungsvariante schneller und effizienter ist. Die angegebene Laufzeit
                    stellt den Durchschnitt aus zehn Messungen dar.</p>
                <h3 class="font1">Suche 1</h3>
                <p class="font1">Zuerst soll aus der Autodatenbank die Bezeichnung der Motoren von
                    den zehn ersten Autos ausgegeben werden.</p>
                <table id="table1">
                    <thead>
                        <tr>
                            <th>XPath Ausdruck</th>
                            <th>Laufzeit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>/car_database/car[position()&lt;=10]/Engine</td>
                            <td>1,19ms</td>
                        </tr>
                        <tr>
                            <td>/car_database/car[position()&lt;=10]/@Engine</td>
                            <td>
                                <span class="green">1ms</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br/>
                <p class="font1">Ergebnis:</p>
                <table id="table1" class="scrolldown">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Engine</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="/car_database/car[position() &lt;= 10]">
                            <tr>
                                <td>
                                    <xsl:value-of select="Model"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Engine"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <br/>
                <h3 class="font1">Suche 2</h3>
                <p class="font1">Nun wird nach den Autos in der Datenbank gesucht, die einen
                    Listenpreis von &gt;$90.000 haben.</p>
                <table id="table1">
                    <thead>
                        <tr>
                            <th>XPath Ausdruck</th>
                            <th>Laufzeit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>/car_database/car[MSRP_in_USD>90.000]</td>
                            <td>1268,12ms</td>
                        </tr>
                        <tr>
                            <td>/car_database/car[@MSRP_in_USD>90.000]</td>
                            <td>
                                <span class="green">704,01ms</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br/>
                <p class="font1">Ergebnis:</p>
                <table id="table1" class="scrolldown">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="/car_database/car[MSRP_in_USD > 90.000]">
                            <tr>
                                <td>
                                    <xsl:value-of select="Model"/>
                                </td>
                                <td>$<xsl:value-of select="MSRP_in_USD"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <br/>
                <h3 class="font1">Suche 3</h3>
                <p class="font1">Man sucht in der Datenbank Autos, die Platz für mehr als sieben
                    Leute haben und gleichzeitig einen Listenpreis von &lt;$60.000 vorweisen.</p>
                <table id="table1">
                    <thead>
                        <tr>
                            <th>XPath Ausdruck</th>
                            <th>Laufzeit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>/car_database/car[MSRP_in_USD&lt;60.000 and
                                Passenger_Capacity&gt;7]</td>
                            <td>1294,35ms</td>
                        </tr>
                        <tr>
                            <td>/car_database/car[@MSRP_in_USD&lt;60.000 and
                                @Passenger_Capacity&gt;7]</td>
                            <td>
                                <span class="green">1159,98ms</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br/>
                <p class="font1">Ergebnis:</p>
                <table id="table1" class="scrolldown">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Passenger Capacity</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each
                            select="/car_database/car[MSRP_in_USD &lt; 60.000 and Passenger_Capacity > 7]">
                            <tr>
                                <td>
                                    <xsl:value-of select="Model"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Passenger_Capacity"/>
                                </td>
                                <td>$<xsl:value-of select="MSRP_in_USD"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <br/>
                <h3 class="font1">Suche 4</h3>
                <p class="font1">Gesucht werden Autos von der Marke Porsche, die das Baujahr 2018
                    und Platz für mehr als zwei Leute haben.</p>
                <table id="table1">
                    <thead>
                        <tr>
                            <th>XPath Ausdruck</th>
                            <th>Laufzeit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>/car_database/car[starts-with(Model,'2018') and
                                contains(Model,'Porsche') and Passenger_Capacity>2]</td>
                            <td>1172,23ms</td>
                        </tr>
                        <tr>
                            <td>/car_database/car[starts-with(Model,'2018') and
                                contains(Model,'Porsche') and Passenger_Capacity>2]</td>
                            <td>
                                <span class="green">643,63ms</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br/>
                <p class="font1">Ergebnis:</p>
                <table id="table1" class="scrolldown">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each
                            select="/car_database/car[starts-with(Model, '2018') and contains(Model, 'Porsche') and Passenger_Capacity > 2]">
                            <tr>
                                <td>
                                    <xsl:value-of select="Model"/>
                                </td>
                                <td>$<xsl:value-of select="MSRP_in_USD"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
            <br/>
            <h3 class="font1">Suche 5</h3>
            <p class="font1">Es wird nach dem Durchschnittspreis aller BMWs gesucht, die entweder
                Allrad- oder Hinterradantrieb vorweisen.</p>
            <table id="table1">
                <thead>
                    <tr>
                        <th>XPath Ausdruck</th>
                        <th>Laufzeit</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>avg(/car_database/car[contains(Model, 'BMW') and (contains (Drivetrain,
                            'Rear Wheel Drive') or contains (Drivetrain, 'All Wheel
                            Drive'))]/MSRP_in_USD)</td>
                        <td>1191,3ms</td>
                    </tr>
                    <tr>
                        <td>avg(/car_database/car[contains(@Model, 'BMW') and (contains (@Drivetrain,
                            'Rear Wheel Drive') or contains (@Drivetrain, 'All Wheel
                            Drive'))]/@MSRP_in_USD)</td>
                        <td>
                            <span class="green">658,15ms</span>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
            <p class="font1">Ergebnis:</p>
            <table id="table1" class="scrolldown">
                <thead>
                    <tr>
                        <th>Model</th>
                        <th>Drivetrain</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each
                        select="car_database/car[contains(Model, 'BMW') and (contains(Drivetrain, 'Rear Wheel Drive') or contains(Drivetrain, 'All Wheel Drive'))]">
                        <tr>
                            <td>
                                <xsl:value-of select="Model"/>
                            </td>
                            <td>
                                <xsl:value-of select="Drivetrain"/>
                            </td>
                            <td>$<xsl:value-of select="MSRP_in_USD"/></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
            <p class="font1">Der Durchschnittspreis beträgt $<xsl:value-of
                    select="avg(/car_database/car[contains(Model, 'BMW') and (contains(Drivetrain, 'Rear Wheel Drive') or contains(Drivetrain, 'All Wheel Drive'))]/MSRP_in_USD)"
                />.</p>
            <h3 class="font1">Fazit:</h3>
            <p class="font1">Es fällt sofort auf, dass die Laufzeit von XPath Ausdrücken, die der
                XML Struktur mit Attributen entsprichen, in jeder Suche eine geringere Laufzeit
                aufweisen.</p>
        </html>
    </xsl:template>
</xsl:stylesheet>