require 'fileutils'

class Backup
	def initialize(dest_dir, sources)		
		@dest_path = dest_dir + '/backup_' + Time.now.strftime("%Y%m%d_%H%M")
		@source_arr = sources				
	end

	def do_backup		
		if !Dir.exist?(@dest_path) then
			FileUtils::mkdir_p @dest_path
		end
		
		for source_dir in @source_arr
			puts `rsync -avzh "#{source_dir}" "#{@dest_path}"`
		end
	end
end

#### Perform actions ####

dest_dir = '/media/TOSHIBA EXT/backupsfromlinux'
# Change the sources depending your local configuration
sources = [
	'/etc',
	'/home/vytautas',
	'/srv',
	'/var',
	'/media/F09CC6259CC5E666/Documents and Settings/Vytas/Desktop/'
]


# Catching an exception on error
begin
	b_obj = Backup.new dest_dir,sources	
	b_obj.do_backup
rescue Exception => e
	puts "Something gone wrong during the backup: #{e}. Backtrace: #{e.backtrace}"
end




