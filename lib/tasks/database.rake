namespace :db do

  desc "Drop, create, load the schema and then seed the database"
  task :rebuild => ['environment', 'db:drop', 'db:create', 'db:schema:load', 'db:seed:load', 'db:seed'] do
  end

  namespace :seed do
    require './db/seed_tables'
 
    desc "dump the data to db/development/<table>.sql. Seed tables need to be defined in the db/seeds_tables"
    task :dump => :environment do
      config = ActiveRecord::Base.configurations[Rails.env]
      SEED_TABLES.each do |table|
        command = "pg_dump --data-only --host=localhost --username=#{config['username']} #{config['database']} -t #{table} > db/data_migrations/#{table}.sql"
        system(command)
      end  
    end
 
    desc "delete the seed data from configured database tables"
    task :delete => :environment do
      config = ActiveRecord::Base.configurations[Rails.env]
      SEED_TABLES.each do |table|
        command = "psql -c 'truncate #{table}' --host=localhost --username=#{config['username']} #{config['database']}"
        system(command)
      end
    end

    desc "load the dumped seed data from db/development/<table>.sql into the configured database"
    task :load => :environment do
      config = ActiveRecord::Base.configurations[Rails.env]
      SEED_TABLES.each do |table|
        command = "psql --host=localhost --username=#{config['username']} #{config['database']} < db/data_migrations/#{table}.sql"
        system(command)
      end
    end

    desc "dump, delete and load the seed data into the configured database."
    task :reload => [:environment, :dump, :delete, :load] do
    end

    desc "drop and load the data_migrations"
    task :refresh => [:environment, :delete, :load] do
    end

  end
end
