# 
# Here is where you will write the class Quotes
# 
# For more information about classes I encourage you to review the following:
# 
# @see http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes
# @see Programming Ruby, Chapter 3
# 
# 
# For this exercise see if you can employ the following techniques:
# 
# Use class convenience methods: attr_reader; attr_writer; and attr_accessor.
# 
# Try using alias_method to reduce redundancy.
# 
# @see http://rubydoc.info/stdlib/core/1.9.2/Module#alias_method-instance_method
# 
class Quotes
require_relative "assignment.rb"
require 'rubygems'
#require 'ruby-debug\debugger'

  @@missing_quote = nil

  attr_reader  :file
  
  def initialize(file)
    @all = []
	if File.exists? file[:file]
	  @file = file[:file]
	else
	  @file = ""
	end
  end

  def all
  #return all quotes
	if !@file.empty?
      @all = File.readlines(@file).map {|quote| quote.strip }
    else
	  @all = []
    end
  end
  
  alias_method :quotes, :all 
  
  def find(linenumber=0)
  # find a quote by line number
    if @file.empty?
	  if @@missing_quote.nil?
	    "Could not find a quote at this time"
	  else
	    @@missing_quote
	  end	
	elsif linenumber > (all.length - 1)
	  all.sample
	else
	  all[linenumber]
	end
  end
  
  alias_method :[], :find
  
  def search(search_method = "")
  #search for quote via search keyword
    if @file.empty?
	  puts "empty!!"
	  []
	elsif search_method.empty?
	  all
	else
	  all.map do |quote|
        search_method.map { |key,value| quote if quote.send("#{key}?",value)}.uniq
	  end.flatten.compact
	end
  end
 
 
  def self.load(file)
  #load the quotes file
    Quotes.new :file => file
  end
  
  def self.missing_quote=(udef_quote)
    @@missing_quote=udef_quote
  end
  
end
