##2013-03-07 - heph

Clone the repo: git@github.com:heph/testing-cookbooks.git


### Test 1:
Execute 'rspec tester':

    (skoenig@hephbook testing-cookbooks)$ rspec tester/
    [Thu, 07 Mar 2013 17:16:37 -0800] WARN: THIS CODE EXECUTED FROM tester/attributes/default.rb. Static: omghacks, Dynamic: 127.0.0.1
    [Thu, 07 Mar 2013 17:16:37 -0800] WARN: THIS CODE EXECUTED FROM tester/recipes/default.rb. Static: omghacks, Dynamic: 127.0.0.1
    .

    Finished in 0.00418 seconds
    1 example, 0 failures

Execute 'rspec xml':

    (skoenig@hephbook testing-cookbooks)$ rspec xml/
    [Thu, 07 Mar 2013 17:17:29 -0800] WARN: THIS CODE EXECUTED FROM tester/attributes/default.rb. Static: omghacks, Dynamic: 127.0.0.1
    .

    Finished in 0.00514 seconds
    1 example, 0 failures
    (skoenig@hephbook testing-cookbooks)$ 

Notice that code is being executed from tester/attributes/default.rb when rspec'ing a different cookbook.

###Test 2:

Edit tester/attributes/default.rb and replace the dynamic variable with the second example:

    #default['tester']['dynamic']= node['ipaddress']
    default['tester']['dynamic']= node['memory']['total']

Execute 'rspec tester':

    (skoenig@hephbook testing-cookbooks)$ rspec tester
    [Thu, 07 Mar 2013 17:24:29 -0800] WARN: THIS CODE EXECUTED FROM tester/attributes/default.rb. Static: omghacks, Dynamic: 1019488kB
    [Thu, 07 Mar 2013 17:24:29 -0800] WARN: THIS CODE EXECUTED FROM tester/recipes/default.rb. Static: omghacks, Dynamic: 1019488kB
    .
    
    Finished in 0.0043 seconds
    1 example, 0 failures

Notice the output is the same, this is because I've set in tester/spec/default_spec.rb:

    runner = ChefSpec::ChefRunner.new do |node|
      node.set['memory']['total'] = '1019488kB'
    end

Execute 'rspec xml':

    (skoenig@hephbook testing-cookbooks)$ rspec xml
    F
    
    Failures:
    
      1) xml::default should install libxml2-dev on ubuntu
         Failure/Error: runner.converge 'xml::default'
         NoMethodError:
           undefined method `[]' for nil:NilClass
         # ./tester/attributes/default.rb:3:in `from_file'
         # ./xml/spec/default_spec.rb:8
         # ./xml/spec/default_spec.rb:11
    
    Finished in 0.0028 seconds
    1 example, 1 failure
    
    Failed examples:
    
    rspec ./xml/spec/default_spec.rb:10 # xml::default should install libxml2-dev on ubuntu

###Assumption

The indicated behavior is that rspec is traversing directories, loading, and attempting to execute attribute files which are unrelated to the cookbook being tested.
