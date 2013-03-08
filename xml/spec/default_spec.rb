require 'chefspec'

describe 'xml::default' do
  let (:chef_run_ubuntu) do
    runner = ChefSpec::ChefRunner.new do |node|
      node.automatic_attrs[:platform] = 'ubuntu'
    end
    runner.converge 'xml::default'
  end
  it 'should install libxml2-dev on ubuntu' do
    chef_run_ubuntu.should install_package 'libxml2-dev'
  end
end
