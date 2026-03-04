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

  # Detecta URLs en el contenido y devuelve bloques: texto o enlace (YouTube/Instagram con miniatura)
  def content_blocks(content)
    return [{ type: :text, content: content }] if content.blank?

    # Dividir por URLs (el grupo capturado se mantiene en el split)
    url_regex = %r{(https?://[^\s<>"\]\)]+)}
    parts = content.split(url_regex)
    blocks = []
    parts.each do |part|
      if part.match?(%r{\Ahttps?://})
        blocks << link_block(part)
      elsif part.present?
        blocks << { type: :text, content: part }
      end
    end
    blocks
  end

  def link_block(url)
    url = url.strip.sub(/[.,;:!?)]+\z/, "")
    if (video_id = extract_youtube_id(url))
      return {
        type: :youtube,
        url: url,
        video_id: video_id,
        thumbnail_url: "https://img.youtube.com/vi/#{video_id}/hqdefault.jpg"
      }
    end
    if url.match?(%r{instagram\.com/(?:p|reel)/})
      return { type: :instagram, url: url }
    end
    { type: :link, url: url }
  end

  def extract_youtube_id(url)
    m = url.match(%r{(?:youtube\.com/watch\?v=|youtu\.be/|youtube\.com/embed/)([a-zA-Z0-9_-]{11})})
    m && m[1]
  end
end
