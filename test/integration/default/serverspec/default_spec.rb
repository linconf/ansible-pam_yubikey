require_relative './spec_helper'

describe 'ansible-openssh::default' do

  if host_inventory['platform'] == 'opensuse'
    describe package('openssh') do
      it { should be_installed }
    end
  end

  if host_inventory['platform'] != 'opensuse'
    describe package('openssh-server') do
      it { should be_installed }
    end
  end

  if host_inventory['platform'] == 'fedora'
    describe package('openssh-clients') do
      it { should be_installed }
    end
  end
  if host_inventory['platform'] == 'ubuntu' || host_inventory['platform'] == 'debian'
    describe package('openssh-client') do
      it { should be_installed }
    end
  end

  describe port(22) do
    it { should be_listening }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should be_owned_by('root') }
    it { should be_owned_by('root') }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should be_mode 644 }
  end

  describe file('/etc/ssh/ssh_config') do
    it { should be_owned_by('root') }
    it { should be_owned_by('root') }
  end

  describe file('/etc/ssh/ssh_config') do
    it { should be_mode 644 }
  end

  if host_inventory['platform'] == 'fedora' || host_inventory['platform'] == 'opensuse'
    describe package('pam_yubico') do
      it { should be_installed }
    end
  end
  if host_inventory['platform'] == 'ubuntu' || host_inventory['platform'] == 'debian'
    describe package('libpam-yubico') do
      it { should be_installed }
    end
  end


  describe file('/etc/pam.d/yubico-sshd-auth') do
    it { should be_owned_by('root') }
    it { should be_owned_by('root') }
    it { should be_mode 644 }
  end

  describe file('/etc/pam.d/yubico-sudo-auth') do
    it { should be_owned_by('root') }
    it { should be_owned_by('root') }
    it { should be_mode 644 }
  end

  describe file('/etc/pam.d/sshd') do
    its(:content) { should match(/yubico/) }
  end

  describe file('/etc/pam.d/sudo') do
    its(:content) { should match(/yubico/) }
  end

end
