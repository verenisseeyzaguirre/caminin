class Post < ApplicationRecord
  belongs_to :user

  has_many :reactions, dependent: :destroy

  # Etiquetas disponibles (puedes añadir más aquí)
  TAGS = %w[frase aprendizaje compartir proyecto].freeze

  validates :tag, inclusion: { in: TAGS, message: "no es una etiqueta válida" }, allow_blank: true
end
