# Quotes API
[Heroku link][heroku]
[heroku]: http://nationstatesclone.herokuapp.com/
An application for storing quotes and displaying them randomly. Can be used with an iframe or with jQuery.
## Example
For a library of math quotes called "math":
### iframe
```<iframe src="https://quotes.herokuapp.com/libraries/math/iframe">/<iframe>```
### jQuery
Suppose you have a div with the id "quote":

```<div id="quote"></div>```

This is the jQuery script to put a quote in that div:

```
<script>
  $(function() {
    $.get("https://quotes.herokuapp.com/libraries/math/random", function(data) {
      $("#quote").html(data);
    });
  });
</script>
```
## Notes
* A public library can be viewed by anyone. A private library can only be viewed by its owner.

* You can also add a `max_chars` param to the iframe or jQuery version to set a maximum length for returned quotes: ```<iframe src="https://quotes.herokuapp.com/libraries/math/iframe?max_chars=20"></iframe>``` will only return full quotes (text and author) whose length is at nost 20 characters.

* Must use PostgreSQL for the database, as randomization is Postgres-specific.
