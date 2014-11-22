require_relative '../spec_helper'

describe 'libxml2::default' do
  before do
  end
  platforms = {
    'centos-6.4' => {
      'packages' => [
        'libxml2'
      ],
      'devel_packages' => [
        'libxml2-devel'
      ]
    },
    'amazon-2013.09' => {
      'packages' => [
        'libxml2'
      ],
      'devel_packages' => [
        'libxml2-devel'
      ]
    },
    'ubuntu-12.04' => {
      'packages' => [
        'libxml2'
      ],
      'devel_packages' => [
        'libxml2-dev'
      ]
    }
  }
  platforms.each do |platform,data|
    (os,version) = platform.split('-')
    context "On #{os} #{version}" do
      let(:chef_run) do
        runner = ChefSpec::SoloRunner.new(
          platform: os,
          version: version
        )
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

    context "Compile time option true" do
      let(:chef_run) do
        runner = ChefSpec::SoloRunner.new(
          platform: os,
          version: version
        )
        runner.node.set['libxml2']['compile_time'] = true
        runner.converge(described_recipe)
      end
      data['packages'].each do |pkg|
        it "should nothing #{pkg}" do
          expect(chef_run).to install_package pkg
        end
      end
      data['devel_packages'].each do |pkg|
        it "should nothing #{pkg}" do
          expect(chef_run).to install_package pkg
        end
      end
    end
  end
end
