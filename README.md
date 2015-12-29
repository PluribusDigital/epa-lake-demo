# EPA National Lakes Assessment Prototype

The EPA National Lakes Assessment is a statistical survey of the condition of our nation's lakes, ponds, and reservoirs. This application allows you to explore that data. You can explore the dataset, viewing the data for a given lake. Further, you can gain context about the data. By clicking on a field, you get a definition of what it contains, as well as some descriptive statistics as to how the lake compares to other lakes.

This prototype application was developed by STSI as part of a response to a Request for Information published by the EPA. The EPA has done a great job of making raw data available as a set of CSV files. This prototype expands on that, allowing would-be users of the data a chance to "kick the tires" and understand the contents of the dataset.

See the live prototype at [http://nla.stsiinc.biz/](http://nla.stsiinc.biz/).

<iframe width="420" height="315" src="https://www.youtube.com/embed/vQLbE3hn__o" frameborder="0" allowfullscreen></iframe>

## Installation
*Windows Users should perform the following steps using the Git Shell*

1. `npm install`
1. `bundle install`
1. `rake db:reset`
1. `rake bower:install`

# Libraries and Frameworks

This application leverages many code libraries and frameworks, nearly all free/open source. Some of the heavily used ones include...

## GraphQL API Design

In addition to the user-facing application functionality, this prototype is also a proof of concept of the GraphQL style of API first developed by Facebook. GraphQL is an alternative to the REST pattern, most appropriate for APIs that don't fit the concept of traditional "resources". The notable example is social network data, with many nodes and relationships. We were interested in trying out GraphQL to gain experience with other potential benefits:

 * __Client-specified data format__: The consumer of the API asks for only the data it needs, in the structure it desires. This seemed relevant with the NLA data, where there are approximately 1000 columns of data for a given lake.
 * __Backward compatible__: API versioning is painful for consuming or providing developers. With GraphQL, Fields can be added or deprecated incrementally.
 * __Discoverable meta-data__: The GraphQL endpoint includes meta-data about each field or relationship. This has many benefits, including the ability to create a quasi-IDE for query writing via [GraphiQL](https://github.com/graphql/graphiql).

## Back-end

 * [Ruby on Rails](http://rubyonrails.org/) web application framework
 * [GraphQL Ruby](https://github.com/rmosolgo/graphql-ruby) implementation of GraphQL in Ruby
 * [PostgreSQL](http://www.postgresql.org/) database

## Front-end

 * [Angular.js](https://angularjs.org/) javascript front-end web application framework
 * [Angular Material](https://material.angularjs.org/) angular directives to implement the Material Design standard
 * [D3.js](http://d3js.org/) charting/visualization
 * [Google Maps](https://developers.google.com/maps/?hl=en) interactive maps 
