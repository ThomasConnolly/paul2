namespace :assets do
  task :precompile do
    system("yarn run build")
    system("yarn run build:css")
  end
end
