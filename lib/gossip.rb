require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content 
  end

  def save 
    CSV.open("../the_gossip_project_sinatra/db/gossip.csv", "a+", headers: ['Author', 'Content']) do |csv|
      csv << [@author, @content]
    end
  end

  def self.show_all
    all_gossips = []
    CSV.read("../the_gossip_project_sinatra/db/gossip.csv").each do |row|
      all_gossips << Gossip.new(row[0], row[1])
    end
    return all_gossips
  end

  def self.show_gossip(id)
    specific_gossip = []
    CSV.open("../the_gossip_project_sinatra/db/gossip.csv").each do |row|
      specific_gossip << Gossip.new(row[0], row[1])
    end
    return specific_gossip[id.to_i]
  end

  def self.update(id, updated_author, updated_content)
    gossip_updated = CSV.read("../the_gossip_project_sinatra/db/gossip.csv")
    gossip_updated[id.to_i][0] = updated_author
    gossip_updated[id.to_i][1] = updated_content
    CSV.open("../the_gossip_project_sinatra/db/gossip.csv", "w+") do |csv|
      gossip_updated.each do |row_updated|
        csv << row_updated
      end
    end
  end
end
