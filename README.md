# diff
A simple diff Ruby gem

###Usage:
```ruby
require 'diff'
d = Diff.new('test1', 'test2')
d.print
```

Result is presented in 3 columns: 
- the first column contains number of a line from a first file or is empty, when a new line is added to a second file;
- the second column contains change symbols: "+", if a new line is added to the second file, "-" - if line, which is in the first file, removed from the second one, and there is nothing, if lines are identical;
- the third column contains a text of a line.

###Sample input:
test1:

<pre>
Hi
Cheers
He
Yes
</pre>

test2:

<pre>
No
Cheers
Cheers
He
Bye-Bye
Yes

</pre>

###Sample output:

<pre>
1 - Hi
  + No
2   Cheers
  + Cheers
3   He
  + Bye-Bye
  + My
4   Yes
  + 
</pre>


