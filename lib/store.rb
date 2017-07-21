class Store < ActiveRecord::Base
	has_many :stores_shoes
    has_many :brands, through: :stores_shoes #creating many to many relationship

	#validates the number of characters input by the user
	validates(:name, {:presence => true, :length => { :maximum => 19 }})

	#changes the input to Title_Case
	before_save(:titlecase_name)

private

    define_method(:titlecase_name) do
      self.name = (name().titlecase())
    end
end