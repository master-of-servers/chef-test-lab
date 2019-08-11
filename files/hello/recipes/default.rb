cookbook_file '/tmp/hello.txt' do
  source 'hello.txt'
  owner 'root'
  group 'root'
  action :create
end
