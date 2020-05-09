node[:target_user] ||= ENV['SUDO_USER']
user_info = node['user'][node[:target_user]]
p user_info

raise "rootでは実行しない。" if node[:target_user] == "root"

# packageのミラーを変更
case node[:platform]
when 'ubuntu'

  file '/etc/apt/sources.list' do
    action :edit
    block do |content|
      content.gsub!(/http:\/\/[^ ]+\/ubuntu\//, "mirror://mirrors.ubuntu.com/mirrors.txt")
    end
    notifies :run, "execute[apt upgrade]", :immediately
  end

  execute "apt upgrade" do
    command <<-"EOH"
export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get upgrade -y -q
apt-get autoremove -y -q
EOH
    action :nothing
  end

when 'redhat'
  if node[:platform_version].to_i >= 8
    file '/etc/dnf/dnf.conf' do
      action :edit
      block do |content|
        unless content =~ /^fastestmirror/
          content.concat <<-CONF
fastestmirror=True
          CONF
        end
      end
    end
  else
    package 'yum-plugin-fastestmirror'
  end
end

# anyenvのインストール
include_recipe 'anyenv'
