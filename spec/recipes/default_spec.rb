require_relative '../spec_helper'

describe 'libxml2::default' do
  before do
  end
  platforms = {
    'centos-6.5' => {
      'packages' => [
        'libxml2'
      ],
      'devel_packages' => [
        'libxml2-devel'
      ],
      :plaform_family => 'rhel',
      :package_manager => 'yum'
    },
    'amazon' => {
      'packages' => [
        'libxml2'
      ],
      'devel_packages' => [
        'libxml2-devel'
      ],
      :plaform_family => 'rhel',
      :package_manager => 'yum'
    },
    'ubuntu-12.04' => {
      'packages' => [
        'libxml2'
      ],
      'devel_packages' => [
        'libxml2-dev'
      ],
      :plaform_family => 'debian',
      :package_manager => 'apt'
    }
  }
  platforms.each do |platform,data|
    (os,version) = platform.split('-')
    context "On #{os} #{version}" do
      let(:chef_run) do
        runner = ChefSpec::SoloRunner.new
        runner.node.set[:platform] = os
        runner.node.set[:version] = version
        runner.node.set[:plaform_family] = data[:plaform_family]
        runner.converge(described_recipe) 
      end
      data['packages'].each do |pkg|
        it "should install #{pkg}" do
          expect(chef_run).to install_package pkg
        end
      end
      data['devel_packages'].each do |pkg|
        it "should install #{pkg}" do
          expect(chef_run).to install_package pkg
        end
      end
    end
  end
end
