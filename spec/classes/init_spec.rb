require 'spec_helper'

describe 'corp104_prerender', :type => 'class' do
  context 'with defaults for all parameters' do
    let(:facts) do
      { 
        :os => { :family => 'Debian', :name => 'Ubuntu', :release => { :major => '16.04', :full => '16.04' }},
        :lsbdistrelease  => '16.04',
        :lsbdistid       => 'Ubuntu',
        :osfamily        => 'Debian',
        :lsbdistcodename => 'xenial',
        :operatingsystem => 'Ubuntu'
      }
    end
    it do
      should contain_class('corp104_prerender')
      should contain_class('corp104_prerender::install')
      should contain_class('corp104_prerender::config')
      should contain_class('corp104_prerender::service')
    end

    it do
      should compile.with_all_deps
    end

  end
end
