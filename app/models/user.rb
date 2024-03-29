class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 必須入力チェック
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :furi_last_name, presence: true
  validates :furi_first_name, presence: true
  validates :date_of_birth, presence: true
  # パスワード半角英数混合チェック
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX,
                      message: 'には英字と数字の両方を含めて設定してください' 
  # 入力フィールドペアチェック
  validate :both_name_present, :both_furi_name_present
  # お名前(全角)の全角（漢字・ひらがな・カタカナ）チェック
  # NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  # validates_format_of :last_name, :first_name, with: NAME_REGEX, 
  #                     base: 'お名前(全角)には全角（漢字・ひらがな・カタカナ）で設定してください'
  validate :custom_name_error_message
  # お名前カナ(全角)の全角（カタカナ）チェック
  # KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
  # validates_format_of :furi_last_name, :furi_first_name, with: KANA_REGEX, 
  #                     base: 'お名前カナ(全角)には全角（カタカナ）で設定してください' 
  validate :custom_kana_error_message

  private

  def both_name_present
    errors.add(:base, '苗字と名前が必要です') unless last_name.present? && first_name.present?
  end
  def both_furi_name_present
    errors.add(:base, '苗字と名前のふりがなが必要です') unless furi_last_name.present? && furi_first_name.present?
  end
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  def custom_name_error_message
    if (last_name.present? && !last_name.match(NAME_REGEX)) || (first_name.present? && !first_name.match(NAME_REGEX))
      errors.add(:base, 'お名前(全角)には全角（漢字・ひらがな・カタカナ）で設定してください')
    end
  end
  KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
  def custom_kana_error_message
    if (furi_last_name.present? && !furi_last_name.match(KANA_REGEX)) || (furi_first_name.present? && !furi_first_name.match(KANA_REGEX))
      errors.add(:base, 'お名前カナ(全角)には全角（カタカナ）で設定してください')
    end
  end

end
