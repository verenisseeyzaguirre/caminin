module PostsHelper
  def posts_path_for_listing(tag = nil)
    if @listing == :mine
      tag ? mine_posts_path(tag: tag) : mine_posts_path
    else
      tag ? posts_path(tag: tag) : posts_path
    end
  end

  def tag_label(tag)
    return "Sin etiqueta" if tag.blank?
    tag.to_s.humanize
  end

  # Clase CSS para diferenciar cada etiqueta (colores dentro de la paleta Camino_n)
  def tag_css_class(tag)
    return "" if tag.blank?
    "camino-card-tag--#{tag}"
  end

  def reaction_labels
    { "seed" => "🌱", "strength" => "💪", "clover" => "🍀" }.freeze
  end

  def reaction_counts(post)
    post.reactions.group_by(&:kind).transform_values(&:count)
  end
end
