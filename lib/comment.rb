require 'csv'

class Comment 
  attr_accessor :gossip_id, :author, :content

  def initialize(comment_id, comment_author, comment_content)
    @gossip_id = comment_id
    @author = comment_author
    @content = comment_content
  end 

  def save
		CSV.open("./db/comments.csv", "ab") do |csv|
    	csv << [@gossip_id, @author, @content]
      csv.close
 		end
	end


	def self.show_all 
		all_comments = []
		CSV.read('./db/comments.csv').each do |csv_line|
			all_comments << Comment.new(csv_line[0],csv_line[1],csv_line[2])
		end
		return all_comments
	end

	def self.get_gossip_comments(id)
		# Création d'un tableau qui contiendra tous les commentaires relatifs à ce gossip
		gossip_comments = []
		all_comments = Comment.show_all
		all_comments.each do |comment|
		# Si le commentaire appartient au gossip voulu, on le met dans notre tableau
			if comment.gossip_id.to_i == id.to_i
				gossip_comments << comment
			end
		end
		return gossip_comments
	end
end