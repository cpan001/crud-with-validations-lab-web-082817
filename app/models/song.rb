class Song < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {scope: [:release_year, :artist_name], message: "this title has been taken!"}

  validates :released, inclusion: {in: [true, false]}

  validates :release_year, presence: true, if: :released

  validate :release_year_must_be_present

  validates :artist_name, presence: true

  def release_year_must_be_present
    if released == true && release_year && (release_year > Time.now.year)
      errors.add(:release_year, "must be present and not in the future!")
    end
  end
end
