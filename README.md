# EventMerger 

Take an array of date-based events: 

``` 
[
  {date: '2014-01-01', a: 5, b:1},
  {date: '2014-01-01', xyz: 11},
  {date: '2014-10-10', qbz: 5},
  {date: '2014-10-10', v: 4, q: 1, strpm: -99}
 …
]
```

Merges the events by dates and returns an array of hashes: 

``` 
=> [
 {date: 2014-01-01, a: 5, b:1, xyz: 11 },
 {date: 2014-10-10, qbz: 5, v: 4, q: 1, strpm: -99},
 …
]
```

## Usage 

EventMerger has one public class: `::merge!(array)`

Simply give it an array of hashes in the above noted format, and EventMerger will take care of the rest.  

```
require 'eventmerger'

EventMerger.merge!([ {date: '2014-01-01', a: 5, b:1}, {date: '2014-01-01', xyz: 11},
                     {date: '2014-10-10', qbz: 5}, {date: '2014-10-10', v: 4, q: 1, strpm: -99} ])

=> [ {date: 2014-01-01, a: 5, b:1, xyz: 11 }, {date: 2014-10-10, qbz: 5, v: 4, q: 1, strpm: -99} ]
```

## Running the Test Suite 

EventMerger includes a Rspec test suite.  Run `rspec` while in the root folder to run it. 