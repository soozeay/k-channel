module NewsHelper

  def check_jp_header(country, category)
    if country == "jp"
      case category
      when "general"
        str = "日本のニュース一覧"
      when "business"
        str = "日本のビジネスニュース"
      when "entertainment"
        str = "日本のエンタメニュース"
      when "health"
        str = "日本のヘルスケアニュース"
      when "science"
        str = "日本のサイエンスニュース"
      when "sports"
        str = "日本のスポーツニュース"
      when "technology"
        str = "日本のテクノロジーニュース"
      end
    else
      case category
      when "general"
        str = "韓国のニュース一覧"
      when "business"
        str = "韓国のビジネスニュース"
      when "entertainment"
        str = "韓国のエンタメニュース"
      when "health"
        str = "韓国のヘルスケアニュース"
      when "science"
        str = "韓国のサイエンスニュース"
      when "sports"
        str = "韓国のスポーツニュース"
      when "technology"
        str = "韓国のテクノロジーニュース"
      end
    end
    return str
  end

  def check_kr_header(country, category)
    if country == "jp"
      case category
      when "general"
        str = "일본의 뉴스 일람"
      when "business"
        str = "일본의 비즈니스 뉴스"
      when "entertainment"
        str = "일본의 엔터테인먼트 뉴스"
      when "health"
        str = "일본의 헬스케어 뉴스"
      when "science"
        str = "일본의 사이언스 뉴스"
      when "sports"
        str = "일본의 스포츠 뉴스"
      when "technology"
        str = "일본의 테크놀로지 뉴스"
      end
    else
      case category
      when "general"
        str = "한국의 뉴스 일람"
      when "business"
        str = "한국의 비즈니스 뉴스"
      when "entertainment"
        str = "한국의 엔터테인먼트 뉴스"
      when "health"
        str = "한국의 헬스케어 뉴스"
      when "science"
        str = "한국의 사이언스 뉴스"
      when "sports"
        str = "한국의 스포츠 뉴스"
      when "technology"
        str = "한국의 테크놀로지 뉴스"
      end
    end
    return str
  end

end
