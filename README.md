# what_dis_ruby


Problem
As a user I want to be able to provide a class name and method and see the ruby-doc explanation and examples.

As a user I want to be able to see a list of classes, select a class, select a method from a list and then see the description + sample code.  

As a user I want to select a class from a list and see the major manipulation operations provided on ruby-docs.  



From the Index Page
  -Get all Class names and their site link (looks like this follows standard patter)

From the Class Page
Get a comprehensive section order and confirm that it is consistent
Find a way to organize content so that it can be reproduced within cli





Test Classes
ArgumentError - short
BasicObject - medium
Array - long

Assumptions:
-Array will contain a complete representation of all of the different sections that can be found on ruby-docs.


Argument Error Sections

Class title  - h1
Description  - all p
Sample Code - pre class="ruby" goes on to identify values, identifies etc keep in mind for styling
Console Output - pre (only)

Class Title - h1
Description
Public Class Methods - h3 class SEction Header
   some methods contained in div id class=method-detail
Public Instance Methods - h3 class SEction Header
Private Instance Methods
  some methods



Class Title
Description
  -CRUD with h2 headers
  -h3 for subsections  

Public Class Methods
 -Common gotchas has h2 within the method section, description and pseudo-code
 Public Instance Methods


 Method


Objects:
Classes
Methods
   has a name
   has a id
   has an order
   has error code
   has sample code
   has text
