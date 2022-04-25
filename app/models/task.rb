class Task < ApplicationRecord
  validates :title, :start_date, :finish_date, presence: true
  validates :description, length: {maximum: 208}
  validate :check_start
  validate :check_date

  def check_start
    return if start_date.blank?
    errors.add(:start_date, "は今日の日付以降のものを選択してください") if start_date < Date.today
  end

  def check_date
    return if finish_date.blank? || start_date.blank?
    errors.add(:finish_date, "を開始日以降の日付で選択し直してください") if finish_date < start_date
  end

end
