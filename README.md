# Comparing the runtime between attributes vs elements for XPath expressions in a XML car database

## Introduction
This project titled "Laufzeit von verschiedenen XML Strukturen/XPath Ausdrücken am Beispiel einer Autodatenbank" explores one of the features of the Extensible Markup Language (XML), which is the ability to model information in various ways, primarily through elements and attributes. The project investigates the differences in processing time between these structures. 

In this project, a database consisting of 32,000 cars, each with 115 specifications, is represented using XML. The database is modeled in two different ways, and queries are performed using the XML Path Language (XPath). The runtime of queries that yield the same results but follow different structures is measured and compared.

The project was part of the university course "Auszeichnungssprachen" in the semester 2020/2021 at Bielefeld University.

## Project Structure
The project files are structured as follows:

- `report.pdf`: The (german) report document summarizing the project.
- `car_database.xml`: The XML file representing the car database without attributes.
- `car_database_attr.xml`: The XML file representing the car database with attributes.
- `results.html`: The HTML file presenting the results of the runtime comparison.
- `schema.xsd`: The XML Schema Definition file for validating the car_database.xml file.
- `schema_attr.xsd`: The XML Schema Definition file for validating the car_database_attr.xml file.
- `to_attributes.xsl`: XSLT file for transforming the car_database.xml file to include attributes.
- `to_html.xsl`: XSLT file for transforming the query results to HTML format.

## Method
Scraped car data was taken from [this repo](https://github.com/nicolas-gervais/predicting-car-price-from-scraped-data). The CSV-file was preprocessed by me into a XML structure. I used the [BaseX XML-Editor](https://basex.org/) to measure the runtime of different XPath expressions.


## Results
![XPath expression](https://github.com/j0st/XML-attribute-vs-element/blob/main/img.png)

The table shows one of the more complex XPath expression (relative and absolute) evaluated in this project. The test results clearly indicate that the runtime of XPath queries on a XML database with values encapsulated only in attributes, rather than elements, is the shortest, representing the more efficient structure. In most cases, these two structures differ mainly in evaluation time, and printing the results also tends to be faster.

While the results suggest that attributes should always be used instead of elements when representing values without nested structures, I personally would not support this statement. Elements have the following advantages comapared to attributes:

* __Readability__: Elements provide a clearer and more intuitive structure, improving the readability of the XML document for human readers.
* __Hierarchy and Nesting__: Elements allow for hierarchical organization and nesting of data, facilitating the representation of complex structures and relationships.
* __Flexibility__: Elements can contain both simple values and complex data structures, offering greater flexibility in data modeling.

These findings highlight the trade-off between performance and readability when designing XML structures. In my opinion, the mentioned advantages are worth a slightly longer runtime.

## Getting Started
To get started with this project and display the results for yourself, simply clone `project.zip`, unzip it and open `results.html`.
