class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250}
    validates :summary, length: { maximum: 250}
    validates :category, inclusion: { in: ['Fiction', 'Non-Fiction']}
    
    validate :title_does_not_contain?

    # custom validation
    # =================
    def title_does_not_contain?
        # buzzwords = ["Won't Believe", "Secret", "Top [number]", "Guess"]
        # unless title.match? Regexp.union(buzzwords) 
        buzzwords = [/Won't Believe/i, /Secret/i, /Top \d/i, /Guess/i]
        unless buzzwords.any? { |substr| substr.match title }
        # unless title.include?("Won't Believe") || title.include?("Secret") || title.include?("Top [number]") || title.include?("Guess")
            errors.add(:title, "Title needs to be sufficiently clickbait-y!")
        end
    end
end
