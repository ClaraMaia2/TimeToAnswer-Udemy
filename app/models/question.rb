class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  after_create :set_statistic

  paginates_per 5

  # scopes => usa para fazer queries (pesquisas) no banco de dados
  scope :_search_, -> (page, term) {
    Question.includes(:answers, :subject).where("lower(description) LIKE ?", "%#{term.downcase}%").page(page)
  }

  scope :last_questions, -> (page) {
    Question.includes(:answers).order('created_at desc').page(page)
  }

  scope :_search_subject_, -> (page, subject_id) {
    Question.includes(:answers, :subject).where(subject_id: subject_id).page(page)
  }

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end
end
