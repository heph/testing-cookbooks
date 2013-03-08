require 'chefspec'

describe 'tester::default' do
  let (:chef_run) do
    runner = ChefSpec::ChefRunner.new do |node|
      node.set['memory']['total'] = '1019488kB'
    end
    runner.converge 'tester::default'
  end

  it 'should create a file' do
    chef_run.should create_file '/tmp/dumper'
  end

end
