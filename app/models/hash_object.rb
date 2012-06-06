class HashObject
  def initialize(hash={})     
  	@hash = hash   
	end   

	def method_missing(sym, *args, &block)     
		@hash[sym]   
	end 
end 